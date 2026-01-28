module ApplicationHelper
# app/helpers/application_helper.rb
def logged_in?
  Current.user.present?
end
end
