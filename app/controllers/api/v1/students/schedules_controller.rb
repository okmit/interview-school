module Api
  module V1
    module Students
      class SchedulesController < ApplicationController
        # TODO
        def download
           send_data nil, filename: "schedule.pdf", type: "application/pdf"
        end
      end
    end
  end
end
