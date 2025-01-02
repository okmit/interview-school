require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:teacher) { FactoryBot.create(:teacher) }
  let(:classroom) { FactoryBot.create(:classroom) }
  let(:subject) { FactoryBot.create(:subject) }

  describe 'validations' do
    context "with valid attributes" do
      it "is valid" do
        section = Section.new({
          teacher: teacher,
          subject: subject,
          classroom: classroom,
          start_time: Time.zone.parse("7:30 AM"),
          end_time: Time.zone.parse("8:20 AM"),
          days: [ "Monday", "Friday" ]
        })

        expect(section).to be_valid
      end
    end

    context "with invalid attributes" do
      it 'duration is invalid' do
        section = Section.new({
          teacher: teacher,
          subject: subject,
          classroom: classroom,
          start_time: Time.zone.parse("7:30 AM"),
          end_time: Time.zone.parse("8:21 AM"),
          days: [ "Monday" ]
        })

        expect(section).not_to be_valid
        expect(section.errors[:duration]).to include("Section duration must be either 50 or 80 minutes")
      end

      it 'start time and end time is invalid' do
        section = Section.new({
          teacher: teacher,
          subject: subject,
          classroom: classroom,
          start_time: nil,
          end_time: '',
          days: [ "Monday" ]
        })

        expect(section).not_to be_valid
        expect(section.errors[:start_time]).to include("can't be blank")
        expect(section.errors[:end_time]).to include("can't be blank")
      end


      it 'is invalid' do
        section = Section.new({
          teacher: nil,
          subject: nil,
          classroom: nil,
          start_time: Time.zone.parse("6:30 AM"),
          end_time: Time.zone.parse("22:20"),
          days: [ "Fr", "Someday" ]
        })

        expect(section).not_to be_valid
        expect(section.errors[:teacher]).to include("must exist")
        expect(section.errors[:subject]).to include("must exist")
        expect(section.errors[:classroom]).to include("must exist")
        expect(section.errors[:start_time]).to include("must be between 7:30 AM and 10:00 PM")
        expect(section.errors[:end_time]).to include("must be between 7:30 AM and 10:00 PM")
        expect(section.errors[:days]).to include("contains invalid days: Fr, Someday")
      end
    end
  end
end
