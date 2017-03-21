#Devise::RegistrationsControllerを継承
class Users::RegistrationsController < Devise::RegistrationsController

#devise/registrations_controllerのbuild_resource(hash=nil)を上書き
  def build_resource(hash=nil)

    # uidカラムにランダムなuidを代入
    hash[:uid] = User.create_unique_string
    super #元のメソッドに記述されたものを代入
    # binding.pry
  end

end
