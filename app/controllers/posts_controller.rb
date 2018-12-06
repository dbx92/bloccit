class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index {|post, index| post.title = 'SPAM' if index % 5 === 0}
  end

  def show
  end

  def new
  end

  def edit
  end
end
