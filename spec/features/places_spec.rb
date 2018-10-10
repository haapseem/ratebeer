require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  describe "Amount of places places" do
    it "No places in city" do
      canned_answer = <<-END_OF_STRING
        <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*holynpoly/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
      visit places_path
      fill_in('city', with: 'holynpoly')
      click_button "Search"
      expect(page).to have_content "No locations in holynpoly"
    end

    it "Every place is shown" do
      canned_answer = <<-END_OF_STRING
        <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>https://beermapping.com/location/12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location><location><id>21108</id><name>Captain Corvus</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/21108</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21108&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21108&amp;d=1&amp;type=norm</blogmap><street>Suomenlahdentie 1</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02230</zip><country>Finland</country><phone>+358 50 4441272</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21496</id><name>Olarin panimo</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21496</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21496&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21496&amp;d=1&amp;type=norm</blogmap><street>Pitkäniityntie 1</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02810</zip><country>Finland</country><phone>045 6407920</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21516</id><name>Fat Lizard Brewing</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21516</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21516&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21516&amp;d=1&amp;type=norm</blogmap><street>Lämpömiehenkuja 3</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02150</zip><country>Finland</country><phone>09 23165432</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21545</id><name>Simapaja</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21545</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21545&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21545&amp;d=1&amp;type=norm</blogmap><street>Kipparinkuja 2</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02320</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
      END_OF_STRING

      stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

      arr = BeermappingApi.places_in("espoo")


      visit places_path
      fill_in('city', with: 'espoo')
      click_button "Search"

      arr.size.times do |i|
        expect(page).to have_content arr[i].name
      end
    end
  end
end
