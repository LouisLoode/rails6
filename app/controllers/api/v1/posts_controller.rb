# frozen_string_literal: true

module Api
  module V1
    class PostsController < Api::V1::BaseController
      before_action :set_post, only: %i[show update destroy]

      # GET /posts
      def index
        @posts = Post.all

        render json: Api::V1::PostSerializer.new(@posts).serializable_hash
      end

      # GET /posts/1
      def show
        render json: Api::V1::PostSerializer.new(@post).serializable_hash
      end

      # POST /posts
      def create
        @post = Post.new(post_params)

        if @post.save
          render json: Api::V1::PostSerializer.new(@post).serializable_hash, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        if @post.update(post_params)
          render json: Api::V1::PostSerializer.new(@post).serializable_hash
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/1
      def destroy
        @post.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.permit(:title, :body, :published)
      end
    end
  end
end
