class TaskMailer < ApplicationMailer
  default from: 'notifications@ourtask.de'

  def task_email(**opts)
    @task = opts[:task]
    @task.generate_pdf!(opts[:layout])
    @user = @task.user
    @partners = opts[:partners]
    partner_emails = opts[:partner_emails]

    if @task.due_date
      ical = Icalendar::Calendar.new
      ical.event do |e|
        e.dtstart     = Icalendar::Values::Date.new(@task.due_date.strftime('%Y%m%d'))
        e.dtend       = Icalendar::Values::Date.new(@task.due_date.next_day.strftime('%Y%m%d'))
        e.summary     = @task.title
        e.description = @task.description
        e.ip_class    = "PRIVATE"
      end
      attachments['event.ics'] = { :mime_type => 'text/calendar',    content: ical.to_ical }
    end

    attachments["Auftrag Nr. #{@task.prefix_number}.pdf"] = File.read("public/tasks_pdf/#{@task.id}_#{@task.updated_at}.pdf")
    mail(to: partner_emails, from: @user.email, cc: @user.email, subject: "Auftrag Nr. #{@task.prefix_number}")
  end
end
