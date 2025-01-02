require 'rails_helper'

RSpec.describe Api::V1::Students::SchedulesController, type: :controller do
  let!(:student) { create(:student) }

  describe "GET #download" do
    it 'generate PDF with student`s schedule' do
      get :download, params: { student_id: student.id }, format: :pdf

      expect(response.content_type).to eq('application/pdf')
    end
  end
end
