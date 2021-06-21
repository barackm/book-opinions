require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user).class_name('User') }
  it { should belong_to(:opinion).class_name('Opinion') }
end
