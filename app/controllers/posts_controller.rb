class PostsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
