class Partner < ApplicationRecord

  def tasks
    Task.all.filter { |task| task.partner_array.split(';&').include?(self.id.to_s) }
  end
end
