# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

      private

      def resource_not_found
        render json: { code: 404, error: 'Record Not Found' }, status: :not_found
      end
    end
  end
end
