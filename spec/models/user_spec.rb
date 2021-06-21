require 'rails_helper'
describe 'the sign up process', type: :feature do
  it 'should not save user without username' do
    user = User.new(full_name: 'John Doe')
    expect(user.save).to be(false)
  end

  it 'should not save user full name' do
    user = User.new(username: 'john')
    expect(user.save).to be(false)
  end

  it 'should not save user username less than 3 characters' do
    user = User.new(username: 'jo', full_name: 'john doe')
    expect(user.save).to be(false)
  end

  it 'should save user with all fields' do
    user = User.new(username: 'john', full_name: 'john doe')
    user.save
    expect(user.username).to eq('john')
  end
end