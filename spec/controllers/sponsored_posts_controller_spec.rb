require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) { Topic.create!(
    name:  RandomData.random_sentence,
    description: RandomData.random_paragraph
  )}

  let(:my_sponsored_post) {my_topic.sponsored_posts.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )}

  describe "GET new" do
    it "returns https success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "instantiates @sponsored_post" do
      get :new, params: {topic_id: my_topic.id}
      expect(assigns(:sponsored_post)).not_to be_nil
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :edit
    end


  end

  describe "GET show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :show
    end
  end

  describe "PUT update" do
    it "updates sponsored posts with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: {
        topic_id: my_topic.id,
        id: my_sponsored_post.id,
        sponsored_post: {title: new_title, body: new_body, price: rand(1..99) }
      }

      updated_sponsored_post = assigns(:sponsored_post)
      expect(updated_sponsored_post.title).to eq new_title
      expect(updated_sponsored_post.body).to eq new_body
      expect(updated_sponsored_post.id).to eq my_sponsored_post.id
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: {
        topic_id: my_topic.id,
        id: my_sponsored_post.id,
        sponsored_post: { title: new_title, body: new_body, price: rand(1..99)}
      }
      expect(response).to redirect_to [my_topic, my_sponsored_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsored_post" do
      delete :destroy, params: {
        topic_id: my_topic.id,
        id: my_sponsored_post.id
      }
      count = SponsoredPost.where( { id: my_sponsored_post.id }).size
      expect(count).to eq 0
    end

    it "redirects to the topic show" do
      delete :destroy, params: {
        topic_id: my_topic.id,
        id: my_sponsored_post.id
      }

      expect(response).to redirect_to my_topic
    end
  end

  describe "POST create" do
    it "changes the count by 1" do
      expect{ post :create, params: {
        topic_id: my_topic.id, sponsored_post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
        }
      }
    }.to change(SponsoredPost,:count).by(1)
  end

  it "assigns it to sponsored posts" do
    post :create, params: { topic_id: my_topic.id, sponsored_post: {title:RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..99)}}
    expect(assigns(:sponsored_post)).to eq SponsoredPost.last
  end

  it "redirects to topic show" do
    post :create, params: {
      topic_id: my_topic.id, sponsored_post: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: rand(1..99)
      }
    }

    expect(response).to redirect_to [my_topic, SponsoredPost.last]
  end
end

end
