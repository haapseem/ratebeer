require 'rails_helper'

include Helpers

describe "Beer page" do
  before :each do
    FactoryBot.create :user
    FactoryBot.create :brewery
  end

  describe "Create beer" do
    it "Can be added if name is valid" do
      visit new_beer_path
      fill_in('beer_name', with: 'test')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "Cannot be added if name is not valid" do
      visit new_beer_path
      fill_in('beer_name', with: '')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(page).to have_content "Name can't be blank"
    end
  end
end
