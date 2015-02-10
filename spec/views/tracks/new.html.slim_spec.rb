require 'rails_helper'

RSpec.describe "tracks/new", :type => :view do
  before(:each) do
    assign(:track, Track.new())
  end

  it "renders new track form" do
    render

    assert_select "form[action=?][method=?]", tracks_path, "post" do
    end
  end
end
