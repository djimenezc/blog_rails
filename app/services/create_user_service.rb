class CreateUserService
  def createAdminUser
    User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
      user.email = Rails.application.secrets.admin_email
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.admin!
    end
  end

  def createRegularUser

    puts "asdasd #{Rails.application.secrets.user_email}"

    User.find_or_create_by!(email: Rails.application.secrets.user_email) do |user|
      user.email = Rails.application.secrets.user_email
      user.password = Rails.application.secrets.user_password
      user.password_confirmation = Rails.application.secrets.user_password
    end
  end
end
