require 'rails_helper'

describe TracksController do

  # This should return the minimal set of attributes required to create a valid
  # Track. As you add validations to Track, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for :track
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TracksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all tracks as @tracks" do
      track = Track.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:tracks)).to eq([track])
    end
  end

  describe "GET #show" do
    it "assigns the requested track as @track" do
      track = Track.create! valid_attributes
      get :show, { id: track.to_param }, valid_session
      expect(assigns(:track)).to eq(track)
    end
  end

  describe "GET #new" do
    it "assigns a new track as @track" do
      get :new, {}, valid_session
      expect(assigns(:track)).to be_a_new(Track)
    end
  end

  describe "GET #edit" do
    it "assigns the requested track as @track" do
      track = Track.create! valid_attributes
      get :edit, { id: track.to_param }, valid_session
      expect(assigns(:track)).to eq(track)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Track" do
        expect {
          post :create, {:track => valid_attributes}, valid_session
        }.to change(Track, :count).by(1)
      end

      it "assigns a newly created track as @track" do
        post :create, {:track => valid_attributes}, valid_session
        expect(assigns(:track)).to be_a(Track)
        expect(assigns(:track)).to be_persisted
      end

      it "redirects to the created track" do
        post :create, {:track => valid_attributes}, valid_session
        expect(response).to redirect_to(Track.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved track as @track" do
        post :create, {:track => invalid_attributes}, valid_session
        expect(assigns(:track)).to be_a_new(Track)
      end

      it "re-renders the 'new' template" do
        post :create, {:track => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested track" do
        track = Track.create! valid_attributes
        put :update, { id: track.to_param, :track => new_attributes }, valid_session
        track.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested track as @track" do
        track = Track.create! valid_attributes
        put :update, { id: track.to_param, :track => valid_attributes }, valid_session
        expect(assigns(:track)).to eq(track)
      end

      it "redirects to the track" do
        track = Track.create! valid_attributes
        put :update, { id: track.to_param, :track => valid_attributes }, valid_session
        expect(response).to redirect_to(track)
      end
    end

    context "with invalid params" do
      it "assigns the track as @track" do
        track = Track.create! valid_attributes
        put :update, { id: track.to_param, :track => invalid_attributes }, valid_session
        expect(assigns(:track)).to eq(track)
      end

      it "re-renders the 'edit' template" do
        track = Track.create! valid_attributes
        put :update, { id: track.to_param, :track => invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested track" do
      track = Track.create! valid_attributes
      expect {
        delete :destroy, { id: track.to_param }, valid_session
      }.to change(Track, :count).by(-1)
    end

    it "redirects to the tracks list" do
      track = Track.create! valid_attributes
      delete :destroy, { id: track.to_param }, valid_session
      expect(response).to redirect_to(tracks_url)
    end
  end

end
