require 'rails_helper'

describe PagesController do
  describe "GET 'root'" do
    xit "returns http success" do
      get 'root'
      expect(response).to be_success
    end
  end
end
