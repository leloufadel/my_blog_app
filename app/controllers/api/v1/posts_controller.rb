module Api
  module V1
    class PostsController < ApplicationController
      load_and_authorize_resource

      def index
        @user = User.includes(posts: :comments).find(params[:user_id])
        @posts = @user.posts.includes(:comments)

        respond_to do |format|
          format.html
          format.json { render json: @posts }
        end
      end

      def show
        @user = User.find(params[:user_id])
        @post = @user.posts.includes(:comments).find(params[:id])

        respond_to do |format|
          format.html
          format.json { render json: @post }
        end
      end

      def new
        @user = current_user
        @post = @user.posts.build

        respond_to do |format|
          format.html
          format.json { render json: @post }
        end
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

        respond_to do |format|
          if @post.save
            format.html do
              flash.now[:error] = 'Post was successfully created.'
              redirect_to user_posts_path(@user)
            end
            format.json { render json: @post, status: :created }
          else
            format.html do
              flash.now[:error] = 'Oops, something went wrong'
              render :new
            end
            format.json { render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @post = Post.find(params[:id])
        @post.destroy
        flash[:notice] = 'Post was Deleted successfully'

        respond_to do |format|
          format.html { redirect_to user_posts_path(current_user) }
          format.json { head :no_content }
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :text)
      end
    end
  end
end