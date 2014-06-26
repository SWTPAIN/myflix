require 'spec_helper'

feature 'Admin adds video' do
  scenario 'admin sucessfully add a video' do
    admin = Fabricate(:admin)
    fantasy = Fabricate(:category)
    sign_in(admin)
    visit new_admin_video_path
    fill_in 'Title', with: "Dragon"
    select fantasy.name, from: 'Category'
    fill_in 'Description', with: "A good movie"
    attach_file('Large cover', 'spec/support/uploads/fight_club_large.jpg')
    attach_file('Small cover', 'spec/support/uploads/fight_club_small.jpg')
    fill_in 'Video url', with: "http://www.example.com/my_video.mp4"
    click_button 'Add Video'

    sign_out
    sign_in

    visit home_path
    expect(page).to have_selector("img[src='/uploads/fight_club_small.jpg']")

    visit video_path(Video.first)
    expect(page).to have_selector("a[href='http://www.example.com/my_video.mp4']")
  end
end
