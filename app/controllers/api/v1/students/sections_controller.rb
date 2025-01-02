module Api
  module V1
    module Students
      class SectionsController < ApplicationController
        # TODO
        def add
          render json: {}, status: :created
        end

        # TODO
        def remove
          render json: {}, status: :ok
        end
      end
    end
  end
end
