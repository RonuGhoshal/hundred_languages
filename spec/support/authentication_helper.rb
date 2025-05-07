module AuthenticationHelper
  def sign_in(teacher)
    session = teacher.sessions.create!(
      user_agent: 'RSpec',
      ip_address: '127.0.0.1'
    )
    cookies.signed.permanent[:session_id] = session.id
    Current.session = session
  end

  def sign_out
    Current.session&.destroy
    cookies.delete(:session_id)
    Current.session = nil
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :controller

  config.before(:each, type: :controller) do
    Current.session = nil
  end
end
