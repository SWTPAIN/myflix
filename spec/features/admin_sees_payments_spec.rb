require 'spec_helper'

feature "Admin sees payment" do
  background do
    alice = Fabricate(:user, full_name: 'Alice', email: 'alice@gmail.com')
    Fabricate(:payment, amount: 999, user: alice, reference_id: 'abc')
  end
  scenario 'admin can see payments' do
    sign_in(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content '$9.99'
    expect(page).to have_content 'abc'
    expect(page).to have_content 'Alice'
    expect(page).to have_content 'alice@gmail.com'
  end
  scenario 'user cannot see payments' do
    sign_in(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content '$9.99'
    expect(page).not_to have_content 'abc'
    expect(page).not_to have_content 'Alice'
    expect(page).not_to have_content 'alice@gmail.com'
    expect(page).to have_content 'You are not allowed to access it.'
  end
end