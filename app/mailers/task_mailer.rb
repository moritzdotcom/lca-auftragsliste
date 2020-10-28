class TaskMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def task_email(task)
    @task = task
    @task.generate_pdf!('internal')
    @user = @task.user
    @partners = @task.partners.where.not(email: nil)
    partner_emails = @partners.map(&:email).join(',')

    attachments["Auftrag Nr. #{@task.prefix_number}.pdf"] = File.read("public/tasks_pdf/#{@task.id}_#{@task.updated_at}.pdf")
    mail(to: partner_emails, from: @user.email, subject: "Auftrag Nr. #{@task.prefix_number}")
  end
end
