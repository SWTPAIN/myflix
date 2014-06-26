require 'spec_helper'

feature "User interact with the queue" do 
 
  scenario "user adds and reorders videos in the queue" do

    fantasy = Fabricate(:category)
    superman =Fabricate(:video, title: "Superman", category: fantasy)
    spiderman =Fabricate(:video, title: "Spiderman", category: fantasy)
    ironman =Fabricate(:video, title: "Ironman", category: fantasy)
    sign_in

    click_on_video_on_home_page(superman)
    expect(page).to have_content superman.title

    click_link "MyQueue"
    expect(page).to have_content superman.title
    
    visit video_path(superman)
    expect_link_not_to_be_seen("MyQueue")
  
    add_video_to_queue(spiderman)
    add_video_to_queue(ironman)

    set_video_postion(superman, 3)
    set_video_postion(spiderman, 1)
    set_video_postion(ironman, 2)
    click_button "Update Instant Queue"

    expect_video_position(superman, 3)
    expect_video_position(spiderman, 1)
    expect_video_position(ironman, 2)

  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).not_to have_content link_text
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "MyQueue"
  end

  def set_video_postion(video, position)
    within(:xpath, "//input[@name='queue_items[][queue_item_id]' and 
@value='#{video.id}']/ancestor::tr[1]" ) do
      fill_in "queue_items[][position]", with: position
    end    
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)    
  end

end