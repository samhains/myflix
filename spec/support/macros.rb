def set_current_user
  session[:user_id] = user.id 
end

def sign_in(user=nil)
  user = user || Fabricate(:user)
  visit login_path
  fill_in "Email address", :with => user.email_address
  fill_in "Password", :with => user.password
  click_button "Sign In"
  expect(page).to have_content 'You have successfully logged in!'
end

def add_video_to_queue(video)
  find(:xpath, "//a[@href='/videos/#{video.id}']").click
  expect(page).to have_content(video.title)
  click_link('Add To Queue')
  expect(page).to have_button('Update List Order')
  expect(page).to have_link(video.title)
end
