require 'rails_helper'

RSpec.describe SectionStudent, type: :model do
  let(:teacher) { create(:teacher) }
  let(:classroom) { create(:classroom) }
  let(:subject) { create(:subject) }
  let(:section) { create(:section, teacher: teacher, subject: subject, classroom: classroom) }
  let(:student) { create(:student) }

  describe 'validations' do
    it 'is valid with unique section and student' do
      section_student = SectionStudent.new(section: section, student: student)
      expect(section_student).to be_valid
    end

    it 'is invalid without section and student' do
      section_student = SectionStudent.new(section: nil, student: nil)
      expect(section_student).not_to be_valid
      expect(section_student.errors[:section]).to include('must exist')
      expect(section_student.errors[:student]).to include('must exist')
    end

    it 'is invalid with duplicate section and student' do
      SectionStudent.create!(section: section, student: student)
      section_student = SectionStudent.new(section: section, student: student)

      expect(section_student).not_to be_valid
      expect(section_student.errors[:student_id]).to include('has already been added to this section')
    end
  end
end
