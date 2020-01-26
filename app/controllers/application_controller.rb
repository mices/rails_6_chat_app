class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  include PublicActivity::StoreController 


#  private 

 def configure_permitted_parameters
#  if resource_class == User
   devise_parameter_sanitizer.permit(:sign_up) { |user_params| user_params.permit(:email, :name, :first_name, :last_name, :middle_name,  :birth_date, :birth_place_country, :birth_place_state, :birth_place_city, :country, :state, :city, :gender, :band, :genre, :password, :password_confirmation) }
#   end
#  end
#  if resource_class == Admin
#   devise_parameter_sanitizer.permit(:sign_up) do |admin_params|
#    admin_params.permit(:email, :name, :password, :password_confirmation)
#   end
#  end
 end
#end
end
