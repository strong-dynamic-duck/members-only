class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  respond_to :html

  def index
    @user = current_user
    @posts = Post.all
    respond_with(@posts)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def create
    data = post_params
    data[:user_id] = current_user.id

    @post = Post.new(data)
    @post.save
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :text)
    end
end
