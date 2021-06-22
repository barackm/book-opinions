require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user).class_name('User') }
  it { should belong_to(:opinion).class_name('Opinion') }
  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content) }
end
