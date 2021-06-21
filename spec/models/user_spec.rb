RSpec.describe User, type: :model do
    
    it { should have_many(:followings).class_name('Following') }
    it { should have_many(:following_users).class_name('User') }
    it { should have_many(:comments).class_name('Comment') }
    it { should have_many(:votes).class_name('Vote') }
    it { should have_one_attached(:photo)}
    it { should have_one_attached(:cover_image)}
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name) }
    it { should validate_length_of(:username) }
end