require 'spec_helper'

feature "User interact with the queue" do 
 
  scenario "user adds and reorders videos in the queue" do
    fantasy = Fabricate(:category)
    superman =Fabricate(:video, title: "Superman", category: fantasy)
    spiderman =Fabricate(:video, title: "Spiderman", category: fantasy)
    ironman =Fabricate(:video, title: "Ironman", category: fantasy)
    sign_in

    find("a[href='/videos/#{superman.id}']").click
    expect(page).to have_content superman.title
    click_link "+ My Queue"
    expect(page).to have_content superman.title
    
    visit home_path(superman)
    expect(page).not_to have_content "+ My Queue"
  
    visit home_path
    find("a[href='/videos/#{spiderman.id}']").click
    click_link "+ My Queue"

    visit home_path
    find("a[href='/videos/#{ironman.id}']").click
    click_link "+ My Queue"

    within(:xpath, "//tr[contains(.,'#{superman.title}')]" ) do
      fill_in "queue_item_positions[][position]", with: 3
    end
    within(:xpath, "//tr[contains(.,'#{spiderman.title}')]" ) do
      fill_in "queue_item_positions[][position]", with: 1
    end
    within(:xpath, "//tr[contains(.,'#{ironman.title}')]" ) do
      fill_in "queue_item_positions[][position]", with: 2
    end

    click_button "Update Instant Queue"
    expect(find(:xpath, "//tr[contains(.,'#{superman.title}')]//input[@type='text']").value).to eq("3")    
    expect(find(:xpath, "//tr[contains(.,'#{spiderman.title}')]//input[@type='text']").value).to eq("1")    
    expect(find(:xpath, "//tr[contains(.,'#{ironman.title}')]//input[@type='text']").value).to eq("2")    

  end
end