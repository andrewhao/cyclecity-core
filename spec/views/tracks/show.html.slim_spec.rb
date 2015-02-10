require 'rails_helper'

RSpec.describe "tracks/show", :type => :view do
  before(:each) do
    @track = assign(:track, Track.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
