require 'rails_helper'

RSpec.describe Comment, type: :feature do
    before :each do
        User.create(username: 'john', full_name: 'john doe')
    end

  it 'Should add a comment an opinion if logged in ' do
    visit '/sessions/new'
    fill_in 'Username', with: 'john'
    click_button 'Login'
    visit '/'
    fill_in 'Compose new review', with: 'this is a review'
    click_button 'Post'
    fill_in 'Leave a comment', with: 'this is a comment'
    click_button 'Comment'
    expect(page).to have_text('Comment added successfully ✨')
  end
end
