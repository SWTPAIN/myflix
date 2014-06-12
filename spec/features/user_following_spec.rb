require 'spec_helper'

feature 'User following' do
  scenario 'user follows and unfollows another user' do
    bob = Fabricate(:user)
    fantasy = Fabricate(:category)
    superman = Fabricate(:video, title: "Superman", category: fantasy)
    bob_review = Fabricate(:review, user: bob, video: superman)
    Fabricate(:queue_item, user: bob, video: superman)
    sign_in

    click_on_video_on_home_page(superman)
    click_link bob.full_name
    expect(page).to have_content "#{bob.full_name}'s video collections (#{bob.queue_items.size})"

    click_link "Follow"
    expect(page).to have_content "People I Follow"
    expect(page).to have_content bob.full_name
    click_link "People"
    unfollow(bob)
    expect(page).not_to have_content bob.full_name
  end

  def unfollow(user)
    find(:xpath, "//tr[contains(.,'#{user.full_name}')]//a[@data-method='delete']").click
  end
end