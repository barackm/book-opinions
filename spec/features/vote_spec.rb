require 'rails_helper'
describe 'voting process', type: :feature do
  before :each do
    User.create(username: 'john', full_name: 'john doe')
  end

  it 'Should upvote an opinion if logged in ' do
    visit '/sessions/new'
    fill_in 'Username', with: 'john'
    click_button 'Login'
    visit '/'
    fill_in 'Compose new review', with: 'this is a review'
    click_button 'Post'
    click_link 'Upvote'
    expect(page).to have_text('You upvoted successfully ✨')
  end

  it 'Should downvote an opinion if logged in and has already upvoted the opinion' do
    visit '/sessions/new'
    fill_in 'Username', with: 'john'
    click_button 'Login'
    visit '/'
    fill_in 'Compose new review', with: 'this is a review'
    click_button 'Post'
    click_link 'Upvote'
    click_link 'Downvote'
    expect(page).to have_text('You downvoted successfully')
  end
end
