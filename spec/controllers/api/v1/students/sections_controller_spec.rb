require 'rails_helper'

RSpec.describe Api::V1::Students::SectionsController, type: :controller do
  let(:student) { create(:student) }
  let(:teacher) { create(:teacher) }
  let(:classroom) { create(:classroom) }
  let(:subject) { create(:subject) }
  let(:section) { create(:section, teacher: teacher, subject: subject, classroom: classroom) }

  describe "POST #add" do
      context 'reponse created' do
      it 'return success response' do
        post :add, params: { student_id: student.id, section_id: section.id }, format: :json

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "DELETE #remove" do
    context 'reponse created' do
      before do
        section.section_students.create(student: student)
      end
      it 'return success response' do
        delete :remove, params: { student_id: student.id, section_id: section.id }, format: :json

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
