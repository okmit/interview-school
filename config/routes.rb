Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :students, only: [] do
        resources :sections, only: [], controller: "students/sections" do
          post :add
          delete :remove
        end

        resource :schedule, only: [], controller: "students/schedules" do
          get :download
        end
      end
    end
  end
end
