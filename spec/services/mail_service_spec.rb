require 'spec_helper'
require 'rest-client'

describe MailService do

  mail_service = MailService.new

  before(:each) do
    @mail = mail_service.create_mail 'david.jimenez19@gmail.com', 'Journal test', 'test'
  end

  it 'Send test message' do

    @mail.subject = 'Smtp test'

    mail_service.send_email @mail, 'smtp'
  end

  it 'Send email through mailgum' do

    @mail.subject = 'API test'
    mail_service.send_email @mail, 'api'
  end

end
