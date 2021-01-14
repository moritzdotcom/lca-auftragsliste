module Mail
  class Message
    alias_method :original_deliver!, :deliver!

    def deliver
      deliver!
    end

    def deliver!
      @delivery_method.settings[:return_response] = true
      response = original_deliver!
      bdy_html = ''
      bdy_text = ''

      if self.multipart?
        if self.body.parts.first.multipart?
          base = self.body.parts.first.parts
        else
          base = self.body.parts
        end

        bdy_html = base.find { |p| p.content_type.match("text/html") }.body.to_s
        txt = base.find { |p| p.content_type.match("text/plain") }
        bdy_text = txt.body.to_s if txt
      else
        if self.content_type.match("text/plain")
          bdy_text = self.body.to_s
        else
          bdy_html = self.body.to_s
        end
      end

      MailLog.create(
        sender: self.from.join(", "),
        recipient: [self.to, self.cc, self.bcc].reject { |v| v == '' }.compact.join(", "),
        subject: self.subject,
        body_html: bdy_html,
        body_text: bdy_text,
        attachment_filenames: self.attachments.collect { |a| a.filename }.join(', '),
        date: self.date,
        message_id: self.message_id,
        smtp_response: response.try(:string)
      )
    end
  end
end
