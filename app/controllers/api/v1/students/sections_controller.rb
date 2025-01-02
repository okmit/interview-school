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

        def remove
          result = Sections::RemoveService.new(section_id: params[:section_id], student_id: params[:student_id]).call

          if result[:success]
            render json: { message: "The section was removed from the schedule successfully" }, status: :ok
          else
            render json: { errors: result[:errors] }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
