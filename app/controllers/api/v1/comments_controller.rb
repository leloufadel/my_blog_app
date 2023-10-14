module Api
  module V1
    class CommentsController < ApplicationController
      load_and_authorize_resource
      before_action :set_post

      def new
        @comment = Comment.new
      end

      def create
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.user = current_user

        respond_to do |format|
          if @comment.save
            format.html do
              flash[:notice] = 'Comment was successfully created.'
              redirect_to user_post_path(@comment.post.author_id, @comment.post.id)
            end
            format.json { render json: @comment, status: :created }
          else
            format.html do
              flash.now[:error] = 'Oops, something went wrong'
              render :new
            end
            format.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @comment = @post.comments.find(params[:id])
        authorize! :destroy, @comment

        respond_to do |format|
          if @comment.destroy
            format.html { flash.now[:success] = 'Comment was successfully deleted' }
            format.json { head :no_content }
          else
            format.html { flash.now[:error] = 'Oops! Cannot delete your comment.' }
            format.json { render json: { errors: 'Could not delete the comment' }, status: :unprocessable_entity }
          end

          format.html { redirect_to user_post_path(@post.author_id, @post.id), notice: 'Comment was deleted.' }
          format.json { head :no_content }
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
end