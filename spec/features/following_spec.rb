require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations', type: :model do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:followed).class_name('User') }

    it 'Returns true if one given user is following another' do
      user1 = User.create(username: 'john', full_name: 'john mark')
      user2 = User.create(username: 'Simon', full_name: 'simon dark')
      following = Following.create(follower_id: user1.id, followed_id: user2.id)

      expect(following.followed_id).to eq(user2.id)
    end

    it 'Returns false if one given user is not following another' do
      user1 = User.create(username: 'john', full_name: 'john mark')
      user2 = User.create(username: 'Simon', full_name: 'simon dark')
      following = Following.create(follower_id: user1.id, followed_id: user2.id)

      expect(following.follower_id == user2.id).to eq(false)
    end

    it 'Returns false if one given user is on the list of another user\'s followers' do
      user1 = User.create(username: 'john', full_name: 'john mark')
      user2 = User.create(username: 'Simon', full_name: 'simon dark')
      Following.create(follower_id: user1.id, followed_id: user2.id)
      follower = user2.followers.where(id: user1.id)

      expect(follower.empty?).to eq(false)
    end

    it 'Returns true if one given user is not on the list of another user\'s followers' do
      user1 = User.create(username: 'john', full_name: 'john mark')
      user2 = User.create(username: 'Simon', full_name: 'simon dark')
      Following.create(follower_id: user1.id, followed_id: user2.id)
      follower = user2.followers.where(id: user2.id)

      expect(follower.empty?).to eq(true)
    end

    it 'should return true is the first user is following the second' do
      user1 = User.create(username: 'john', full_name: 'john mark')
      user2 = User.create(username: 'Simon', full_name: 'simon dark')
      Following.create(follower_id: user1.id, followed_id: user2.id)

      expect(user1.following?(user2)).to eq(true)
    end
  end
end
