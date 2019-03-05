class SponsoredPostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    if @sponsored_post.save
      flash[:notice] = "Sponsored Post was updated"
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving, please try again"
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored_post"
      render :show
    end
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @topic = Topic.find(params[:topic_id])

    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:notice] = "Sponsored post was saved."
      redirect_to [@topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving. Please try again."
      render :new
    end
  end

  private

  def post_params
    params.require(:sponsored_post).permit(:title, :body)
  end

  def authorize_user
    sponsored_post = SponsoredPost.find(params[:id])

    unless current_user == post.user || current_user.admin? || current_user.moderator?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [sponsored_post.topic, sponsored_post]
    end
  end
end
