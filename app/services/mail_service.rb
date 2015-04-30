require 'mail'

class MailService

  def initialize

    Mail.defaults do
      delivery_method :smtp, address: 'localhost', port: 1025
    end

    @from = 'David Sandbox <postmaster@sandbox1eec6e41421a40ac9224888687531caa.mailgun.org>'
  end

  def create_mail (to, subject, body)

    Mail.new do
      from @from
      to to
      subject subject
      body body
    end
  end

  def send_email(mail, type='api')

    if type === 'api'

      RestClient.post 'https://api:key-49d13bb8abeef8f8575a047f685d2d8b'\
  '@api.mailgun.net/v3/sandbox1eec6e41421a40ac9224888687531caa.mailgun.org/messages',
                      :from => @from,
                      :to => mail.to,
                      :subject => mail.subject,
                      :text => mail.body
    else
      Mail.deliver mail
    end

  end
end
