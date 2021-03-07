class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat, optional: true
  belongs_to :tenant, optional: true
  belongs_to :user
  belongs_to :company
  has_one :owner, through: :house

  validates :status, inclusion: 0..4
  validates :priority, inclusion: 0..2
  validates_presence_of :house_id, message: 'Objekt muss angegeben werden'
  validates_presence_of :user_id, message: 'Auftrag braucht einen Aussteller'
  validates_presence_of :title, message: 'Beschreibung muss angegeben werden', if: :released?
  validates_uniqueness_of :task_number, scope: [:year, :company_id], message: 'Auftragsnummer ist schon vergeben', if: :released?

  before_validation :set_default_values

  scope :for_company, -> (company) { where(company: company) }
  scope :order_by_task_number, -> (asc_or_desc) { order(year: :desc, task_number: asc_or_desc) }

  def self.next_number(company)
    Task.where(year: Date.today.year, company: company).maximum(:task_number).to_i + 1
  end

  def self.status_options
    ['Offen', 'Wird erledigt', 'Erledigt', 'Problem', 'Storniert']
  end

  def self.color_options
    ['#ACACFF', '#ACFFFF', '#ACFFAC', '#FFACAC', '#ECECEC']
  end

  def self.priority_options
    ['!', '!!', '!!!']
  end

  def self.priority_collection
    Task.priority_options.each_with_index.map { |prio, i| ([prio, i]) }
  end

  def self.create_steps
    ['Ort', 'Mieter Bearbeiten', 'Inhalt', 'Partner festlegen']
  end

  def released?
    self.released
  end

  def humanized_status
    Task.status_options[status]
  end

  def humanized_priority
    Task.priority_options[priority]
  end

  def prefix_number
    "#{created_at.strftime('%y')}-#{task_number}"
  end

  def color
    Task.color_options[status]
  end

  def partners
    self.partner_array ? Partner.where(id: self.partner_array.split(';&')) : []
  end

  def set_partner_names!
    p_names = self.partners.map(&:name).sort.join(' & ')
    self.update(partner_names: p_names)
  end

  def generate_pdf!(internal_or_external)
    export_dir = 'public/tasks_pdf'
    Dir.mkdir(export_dir) unless Dir.exist?(export_dir)

    filename = "#{export_dir}/#{self.id}_#{self.updated_at}.pdf"

    unless File.file?(filename)
      pdf_body = ApplicationController.render("tasks/show_#{internal_or_external}_pdf.html.erb", format: :pdf, layout: 'pdf', assigns: { task: self })
      pdf = WickedPdf.new.pdf_from_string(pdf_body)

      File.open(filename, 'wb') do |file|
        file << pdf
      end
    end
  end

  private

  def set_default_values
    self.partner_names = partners.map { |partner| partner.name }.sort.join(' & ')
    self.status ||= 0
    self.priority ||= 0
    self.created_at ||= DateTime.now
    self.year ||= self.created_at.year
    self.company ||= self.house.company
    self.task_number ||= Task.next_number(self.company)
  end
end
