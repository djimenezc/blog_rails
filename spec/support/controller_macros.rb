module ControllerMacros

  def login_user
    before(:each) do
      user = users(:eoin)
      sign_in user
    end
  end
end