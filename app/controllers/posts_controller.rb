class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.build
  end

  def create
    @user = current_user
    @post = Post.new(
      author: @user,
      title: params[:post][:title],
      text: params[:post][:text],
      commentsCounter: 0,
      likesCounter: 0
    )

    if @post.save
      flash.now[:error] = 'Post was successfully created.'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Oops, something went wrong'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post was Deleted seccesufuly'
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
