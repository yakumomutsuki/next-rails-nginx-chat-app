module Api
  module V1
    class SampleController < ApplicationController
      def index
        render json: { status: 'SUCCESS', message: 'success' }
      end
    end
  end
end