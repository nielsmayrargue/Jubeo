module UsersHelper

def full_name_link(a_user)
  user_name = a_user.full_name
  user_id = a_user.id
  link_to("#{user_name}", user_profile_path(user_id)).html_safe
end

end
