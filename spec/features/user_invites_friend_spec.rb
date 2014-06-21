require 'spec_helper'

feature 'User invites friend' do
  scenario 'user invite friend and invitation is accepted', { js: true, vcr: true }do
    alice = Fabricate(:user)
    sign_in(alice)

    invite_a_friend
    friend_accepts_invitation
    friend_sign_in

    inviter_should_be_followed(alice)
    inviter_should_follow_friend(alice)    

    clear_emails

  end

  def invite_a_friend
    visit invite_path
    fill_in "Friend's Name", with: 'Bob'
    fill_in "Friend's Email Address", with: 'bob@gmail.com'
    fill_in 'Invitation Message', with: 'Hey Bob. Join this cool website'
    click_button 'Send Invitation'
    sign_out
  end

  def friend_accepts_invitation
    open_email 'bob@gmail.com'
    current_email.click_link("Accept this invitation")
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Bob bob"
    fill_in 'Credit Card Number', with: '42424242424242424242'
    fill_in 'Security Code', with: '314'
    select '1 - January', from: "date_month"
    select 2016 , from: 'date_year'
    click_button "Sign Up" 
  end

  def friend_sign_in
    fill_in "email", with: "bob@gmail.com"
    fill_in "password", with: "password"
    click_button "Sign in"
  end

  def inviter_should_be_followed(user)
    click_link "People"
    expect(page).to have_content user.full_name
    sign_out
  end

  def  inviter_should_follow_friend(user)
    sign_in(user)
    click_link "People"
    expect(page).to have_content "Bob bob"
  end
end
