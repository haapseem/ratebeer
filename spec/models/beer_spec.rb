require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "If beer is valid it's saved" do
    let(:brewery){ Brewery.create name: 'brewery', year: 1999 }
    let(:beer){ Beer.create name: 'beer', style: 'beer', brewery: brewery }
    let(:beer1){ Beer.create name: '', style: 'beer', brewery: brewery }
    let(:beer2){ Beer.create name: 'beer', style: '', brewery: brewery }

    it "Beer is valid and saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "Beer is not valid and not saved" do
      expect(beer1).not_to be_valid
      expect(beer2).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
