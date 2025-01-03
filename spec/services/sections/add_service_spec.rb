require 'rails_helper'

RSpec.describe Sections::AddService, type: :service do
  let(:student) { create(:student) }

  let(:teacher_one) { create(:teacher) }
  let(:teacher_two) { create(:teacher) }

  let(:classroom_one) { create(:classroom) }
  let(:classroom_two) { create(:classroom) }

  let(:subject_one) { create(:subject) }
  let(:subject_two) { create(:subject) }

  let(:section_one) {
    create(
      :section,
      teacher: teacher_one,
      subject: subject_one,
      classroom: classroom_one,
      days: %w[Monday Wednesday],
      start_time: Time.zone.parse("09:00 AM"),
      end_time: Time.zone.parse("09:50 AM")
    )
  }

  let(:section_overlap) {
    create(
      :section,
      teacher: teacher_two,
      subject: subject_two,
      classroom: classroom_two,
      days: %w[Monday Friday],
      start_time: Time.zone.parse("09:30 AM"),
      end_time: Time.zone.parse("10:20 AM")
    )
  }

  describe '#call' do
    context 'when the section and student exist' do
      it 'adds the section to schedule' do
        result = described_class.new(section_id: section_one.id, student_id: student.id).call

        expect(result[:success]).to be(true)
        expect(result[:errors]).to be_empty
        expect(
          ActiveRecord::Base
            .connection.execute("SELECT COUNT(*) FROM sections_students WHERE section_id = #{section_one.id} AND student_id=#{student.id}")
            .first["count"]
        ).to eq(1)
      end
    end

    context "student coudn't add section to schedule" do
      before do
        section_overlap.students << student
      end

      it 'returns an error' do
        result = described_class.new(section_id: section_one.id, student_id: student.id).call

        expect(result[:success]).to be(false)
        expect(result[:errors]).to include({ message: "Section overlaps with another section" })
      end
    end
  end
end
