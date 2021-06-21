require 'rails_helper'

describe 'the signin process', type: :feature do
  before :each do
  User.create(username: 'john', full_name: 'john mark')
  end
  it 'signs @user in' do
    visit '/sessions/new'
    fill_in 'Username', with: 'john'
    click_button 'Login'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Hi John, Welcome to Book Reviewer ✨')
  end

  it 'Should not signs @user in if not valid' do
    visit '/sessions/new'
    fill_in 'Username', with: 'alain'
    click_button 'Login'
    expect(current_path).to eq('/sessions/new')
    expect(page).to have_text('Invalid username. 😥')
  end
end
