require 'rails_helper'

RSpec.describe Sections::RemoveService, type: :service do
  let(:student) { create(:student) }
  let(:teacher) { create(:teacher) }
  let(:subject) { create(:subject) }
  let(:classroom) { create(:classroom) }

  let(:section) {
    create(
      :section,
      teacher: teacher,
      subject: subject,
      classroom: classroom,
      days: %w[Monday Wednesday],
      start_time: Time.zone.parse("09:00 AM"),
      end_time: Time.zone.parse("09:50 AM")
    )
  }

  describe '#call' do
    before do
      section.section_students.create(student: student)
    end

    context 'when the section and student exist' do
      it 'remove the section from schedule' do
        result = described_class.new(section_id: section.id, student_id: student.id).call

        expect(result[:success]).to be(true)
        expect(result[:errors]).to be_empty
        expect(SectionStudent.exists?(section: section, student: student)).to be(false)
      end
    end
  end
end
