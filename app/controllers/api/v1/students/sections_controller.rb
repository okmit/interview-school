module Api
  module V1
    module Students
      class SectionsController < ApplicationController
        def add
          result = Sections::AddService.new(section_id: params[:section_id], student_id: params[:student_id]).call

          if result[:success]
            render json: result[:data], status: :created
          else
            render json: { errors: result[:errors] }, status: :unprocessable_entity
          end
        end

        # TODO
        def remove
          render json: {}, status: :ok
        end
      end
    end
  end
end
