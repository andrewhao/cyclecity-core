require 'rails_helper'

RSpec.describe "tracks/edit", :type => :view do
  before(:each) do
    @track = assign(:track, Track.create!())
  end

  it "renders the edit track form" do
    render

    assert_select "form[action=?][method=?]", track_path(@track), "post" do
    end
  end
end
