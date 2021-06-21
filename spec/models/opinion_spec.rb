require 'rails_helper'

describe 'the signin process', type: :model do
let(:user) { User.create(username: 'john', full_name: 'john mark') }
 context "Creating an opinion" do
    it "should create an opinion if all the data is given" do
        opinion =  user.opinions.build(text: "This is a test opinion")       
        expect(opinion.save).to eql(true)
    end
      
    it "should not create an opinion if all the data is not given" do 
        opinion =  user.opinions.build()       
        expect(opinion.save).to eql(false)
    end

    it "should not create an opinion if the content length is less than 5 characters." do 
        opinion =  user.opinions.build(text: "abc")       
        expect(opinion.save).to eql(false)
    end
 end
 
end
