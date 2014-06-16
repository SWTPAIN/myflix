def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(user=nil)
  visit '/sign_in'
  user = Fabricate(:user) unless user
  fill_in 'email', with: user.email
  fill_in 'password', with: user.password     
  click_button 'Sign in'
end

def sign_out
  click_link 'Logout'
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end