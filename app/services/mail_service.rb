require 'mail'

class MailService

  def initialize

    options = { :address              => 'smtp.mailgum.org',
                :port                 => 587,
                :domain               => 'postmaster@sandbox1eec6e41421a40ac9224888687531caa.mailgun.org',
                :user_name            => 'postmaster@sandbox1eec6e41421a40ac9224888687531caa.mailgun.org',
                :password             => '1e520ef4ff9da060ebc82a7cb8c3a4b2',
                :authentication       => 'plain',
                :enable_starttls_auto => true
    }

    Mail.defaults do
      delivery_method :smtp, options
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
