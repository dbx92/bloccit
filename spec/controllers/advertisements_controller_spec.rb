require 'rails_helper'
require 'random_data'

# all of the controllers and routes are plural
# all of the models are singular
# all of the table names in the database are plural

RSpec.describe AdvertisementsController, type: :controller do

  let!(:my_advertisement) {Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: rand(1..99))}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: my_advertisement.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "AD #create" do
    it "increases the number of ADS by 1" do
      expect {
        post :create, params: {
          advertisement: {
            title: RandomData.random_sentence,
            copy: RandomData.random_paragraph,
            price: rand(1..99)
          }
        }
      }.to change(Advertisement,:count).by(1)
    end
    it "assigns the new AD to @advertisement" do
      post :create, params: {advertisement: {
            title: RandomData.random_sentence,
            copy: RandomData.random_paragraph,
            price: rand(1..99) }
        }
       expect(assigns(:advertisement)).to eq Advertisement.last
    end
  end

end
