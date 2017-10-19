require 'rails_helper'

RSpec.describe Hotel, type: :model do

  describe "validations" do

    it "should have name, description, address, latitude, longitude, and user_id columns" do
      should have_db_column(:hotel_name).of_type(:string)
      should have_db_column(:description).of_type(:string)
      should have_db_column(:price).of_type(:integer)
      should have_db_column(:country).of_type(:string)
      should have_db_column(:city).of_type(:string)
      should have_db_column(:user_id).of_type(:integer)
      should have_db_column(:rating).of_type(:integer)
    end

    describe "validates presence of first name, last name and email" do
      it { is_expected.to validate_presence_of(:hotel_name) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_presence_of(:country) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:rating) }
      it { is_expected.to validate_uniqueness_of(:hotel_name) }
    end

  end

  context "asociations" do
    describe "Hotel belong to a user" do
      it { is_expected.to belong_to(:user)}
    end
  end

  context "search" do
    let(:user) {User.new(first_name: "test1", last_name: "test1", email: "test10@gmail.com", password: "123456")}
    let(:hotel1) { Hotel.new(hotel_name:"one", description:"two", country:"three", city: "four", price:123, user_id: user.id, rating: 5) }
    let(:hotel2) { Hotel.new(hotel_name:"four", description:"five", country:"six", city: "seven", price:123, user_id: user.id, rating: 5) }

    it "it should return nil if no match" do
      user.save
      hotel1.save
      expect(Hotel.search_hotels("five")).to be_empty
    end

    it "it should find a hotel" do
      user.save
      hotel1.save
      expect(Hotel.search_hotels("one")).not_to be_empty
    end

    it "it should find all hotel if no params" do
      user.save
      hotel1.save
      hotel2.save
      expect( Hotel.search_hotels("").count ).to eql(2)
    end

    it "it should find all hotel that have search params in hotel_name, description, country or city" do
      user.save
      hotel1.save
      hotel2.save
      expect( Hotel.search_hotels("four").count ).to eql(2)
    end
  end
end
