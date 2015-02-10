require 'rails_helper'

RSpec.describe "tracks/index", :type => :view do
  before(:each) do
    assign(:tracks, [
      Track.create!(),
      Track.create!()
    ])
  end

  it "renders a list of tracks" do
    render
  end
end
