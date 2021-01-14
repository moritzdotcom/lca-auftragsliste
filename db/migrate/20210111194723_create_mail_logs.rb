class CreateMailLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_logs do |t|
      t.string :sender
      t.string :recipient
      t.string :subject
      t.string :body_html
      t.string :body_text
      t.string :attachment_filenames
      t.datetime :date
      t.string :message_id
      t.string :smtp_response

      t.timestamps
    end
  end
end
