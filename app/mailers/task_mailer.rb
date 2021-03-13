class TaskMailer < ApplicationMailer
  default from: 'notifications@ourtask.de'

  def task_email(**opts)
    @task = opts[:task]
    @task.generate_pdf!(opts[:layout])
    @user = @task.user
    @partners = opts[:partners]
    partner_emails = opts[:partner_emails]

    attachments["Auftrag Nr. #{@task.prefix_number}.pdf"] = File.read("public/tasks_pdf/#{@task.id}_#{@task.updated_at}.pdf")
    mail(to: partner_emails, from: @user.email, cc: @user.email, subject: "Auftrag Nr. #{@task.prefix_number}")
  end
end
