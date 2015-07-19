require 'spec_helper'

feature "User Interacts With Queue" do
  scenario "user reorders queue items " do
    futurama = Fabricate(:video, title: 'Futurama')
    south_park = Fabricate(:video, title: 'South Park')
    monk = Fabricate(:video, title: 'Monk')
    sign_in

    click_link('Futurama')
    expect(page).to have_content(futurama.description)
    expect(page).to_not have_button('Add To Queue')
    click_link('MyFLiX')
    expect(page).to have_content(futurama.categories.first.name)

    add_video_to_queue(south_park)
    click_link('MyFLiX')
    add_video_to_queue(monk)

    find_link(futurama.title).visible? 
    find_link(monk.title).visible? 
    find_link(south_park.title).visible? 

    set_video_position(futurama, 3)
    set_video_position(monk, 2)
    set_video_position(south_park, 1)

    click_button 'Update List Order'

    expect_video_position(futurama, 3)
    expect_video_position(monk, 2)
    expect_video_position(south_park, 1)
  end

  def set_video_position(video, position)
    fill_in "video_#{video.id}", with: position
  end

  def expect_video_position(video, position)
    expect(find("#video_#{video.id}").value).to eq("#{position}")
  end
end

