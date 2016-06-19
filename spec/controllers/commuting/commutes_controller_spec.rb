require 'rails_helper'

describe Commuting::CommutesController do

  # This should return the minimal set of attributes required to create a valid
  # Commuting::Commute. As you add validations to Commuting::Commute, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: 'hello', started_at: Time.zone.now }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Commuting::CommutesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all commuting_commutes as @commuting_commutes" do
      commute = Commuting::Commute.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:commuting_commutes)).to eq([commute])
    end
  end

  describe "GET #show" do
    it "assigns the requested commuting_commute as @commuting_commute" do
      commute = Commuting::Commute.create! valid_attributes
      get :show, { id: commute.to_param }, valid_session
      expect(assigns(:commuting_commute)).to eq(commute)
    end
  end

  describe "GET #new" do
    it "assigns a new commuting_commute as @commuting_commute" do
      get :new, {}, valid_session
      expect(assigns(:commuting_commute)).to be_a_new(Commuting::Commute)
    end
  end
end
