class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat, optional: true
  belongs_to :tenant, optional: true
  belongs_to :user
  belongs_to :company

  validates :status, inclusion: 0..3
  validates :priority, inclusion: 0..2
  validates_presence_of :house_id, message: 'Objekt muss angegeben werden'
  validates_presence_of :user_id, message: 'Auftrag braucht einen Verantwortlichen'
  validates_presence_of :title, message: 'Beschreibung muss angegeben werden'
  validates_uniqueness_of :task_number, scope: :year, message: 'Auftragsnummer ist schon vergeben'

  before_validation :set_default_values

  def self.next_number
    Task.where(year: Date.today.year).maximum(:task_number).to_i + 1
  end

  def self.status_options
    ['Offen', 'Wird erledigt', 'Erledigt', 'Problem']
  end

  def humanized_status
    Task.status_options[status]
  end

  def self.priority_options
    ['!', '!!', '!!!']
  end

  def self.priority_collection
    Task.priority_options.each_with_index.map { |prio, i| ([prio, i]) }
  end

  def humanized_priority
    Task.priority_options[priority]
  end

  def prefix_number
    "#{created_at.strftime('%y')}-#{task_number}"
  end

  def partners
    self.partner_array ? Partner.where(id: self.partner_array.split(';&')) : []
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
    self.task_number ||= Task.next_number
    self.created_at ||= DateTime.now
    self.year ||= self.created_at.year
    self.company = self.house.company
  end
end
