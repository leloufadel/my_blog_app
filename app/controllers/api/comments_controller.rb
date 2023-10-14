module Api
  class CommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_api, except: [:index]

    def index
      @comments = @post.comments
      render json: @comments
    end

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
end
