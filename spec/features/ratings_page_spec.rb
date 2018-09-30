require 'rails_helper'

include Helpers
include ActionView::Helpers::TextHelper

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user, username: "Peksu" }
  let!(:user1) { FactoryBot.create :user, username: "Veksu" }

  before :each do
    sign_in(username:"Peksu", password:"Foobar1")
    FactoryBot.create :rating
    FactoryBot.create :rating, user: user, score: 2, beer: beer2
    FactoryBot.create :rating, user: user1
  end

  describe "Ratings are shown" do
    it "show all ratings" do
      visit ratings_path
      @ratings = Rating.all
      expect(page).to have_content "Number of ratings: #{@ratings.count}"
      @ratings.each do |r|
        expect(page).to have_content "#{r.beer.name} #{r.score}"
      end
    end
  end
end
