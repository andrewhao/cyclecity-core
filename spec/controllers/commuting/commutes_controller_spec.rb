require 'rails_helper'

describe Commuting::CommutesController do

  # This should return the minimal set of attributes required to create a valid
  # Commuting::Commute. As you add validations to Commuting::Commute, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for :commute
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

  describe "GET #edit" do
    it "assigns the requested commuting_commute as @commuting_commute" do
      commute = Commuting::Commute.create! valid_attributes
      get :edit, { id: commute.to_param }, valid_session
      expect(assigns(:commuting_commute)).to eq(commute)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Commuting::Commute" do
        expect {
          post :create, {:commuting_commute => valid_attributes}, valid_session
        }.to change(Commuting::Commute, :count).by(1)
      end

      it "assigns a newly created commuting_commute as @commuting_commute" do
        post :create, {:commuting_commute => valid_attributes}, valid_session
        expect(assigns(:commuting_commute)).to be_a(Commuting::Commute)
        expect(assigns(:commuting_commute)).to be_persisted
      end

      it "redirects to the created commuting_commute" do
        post :create, {:commuting_commute => valid_attributes}, valid_session
        expect(response).to redirect_to(Commuting::Commute.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved commuting_commute as @commuting_commute" do
        post :create, {:commuting_commute => invalid_attributes}, valid_session
        expect(assigns(:commuting_commute)).to be_a_new(Commuting::Commute)
      end

      it "re-renders the 'new' template" do
        post :create, {:commuting_commute => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested commuting_commute" do
        commute = Commuting::Commute.create! valid_attributes
        put :update, { id: commute.to_param, :commuting_commute => new_attributes }, valid_session
        commute.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested commuting_commute as @commuting_commute" do
        commute = Commuting::Commute.create! valid_attributes
        put :update, { id: commute.to_param, :commuting_commute => valid_attributes }, valid_session
        expect(assigns(:commuting_commute)).to eq(commute)
      end

      it "redirects to the commuting_commute" do
        commute = Commuting::Commute.create! valid_attributes
        put :update, { id: commute.to_param, :commuting_commute => valid_attributes }, valid_session
        expect(response).to redirect_to(commute)
      end
    end

    context "with invalid params" do
      it "assigns the commuting_commute as @commuting_commute" do
        commute = Commuting::Commute.create! valid_attributes
        put :update, { id: commute.to_param, :commuting_commute => invalid_attributes }, valid_session
        expect(assigns(:commuting_commute)).to eq(commute)
      end

      it "re-renders the 'edit' template" do
        commute = Commuting::Commute.create! valid_attributes
        put :update, { id: commute.to_param, :commuting_commute => invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested commuting_commute" do
      commute = Commuting::Commute.create! valid_attributes
      expect {
        delete :destroy, { id: commute.to_param }, valid_session
      }.to change(Commuting::Commute, :count).by(-1)
    end

    it "redirects to the commuting_commutes list" do
      commute = Commuting::Commute.create! valid_attributes
      delete :destroy, { id: commute.to_param }, valid_session
      expect(response).to redirect_to(commuting_commutes_url)
    end
  end

end
