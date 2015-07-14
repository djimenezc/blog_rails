require 'spec_helper'
require 'rest-client'

describe MailService do

  mail_service = MailService.new

  before(:each) do
    @mail = mail_service.create_mail 'david.jimenez19@gmail.com', 'Journal test', 'test'
  end

  # it 'Send test message through smtp' do
  #
  #   @mail.subject = 'Smtp test'
  #   @mail.from = 'David Sandbox <postmaster@sandbox1eec6e41421a40ac9224888687531caa.mailgun.org>'
  #
  #   mail_service.send_email @mail, 'smtp'
  # end

  it 'Send email through mailgum API' do

    @mail.subject = 'API test'
    mail_service.send_email @mail, 'api'
  end

end
