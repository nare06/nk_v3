class Feedback < MailForm::Base
append :remote_ip , :user_agent#, :session
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :feedback
  attribute :nickname,  :hint => 'Leave this field blank!', :captcha  => true
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => name,
      :to => "kampusbee@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
