require 'rails_helper'

describe "View stoplights", type: :request do
  before do
    create_list(:commuting_stop_event, 5)
  end

  it "returns 200" do
    get("/api/v1/commuting/stoplights")
    expect(response).to be_success
  end


  it "returns GeoJSON" do
    get("/api/v1/commuting/stoplights")
    json_body = JSON.parse(response.body)
    expect(json_body.first['centroid']['type']).to eq 'Point'
    expect(json_body.first['geom_collection']['type']).to eq 'GeometryCollection'
  end
end
