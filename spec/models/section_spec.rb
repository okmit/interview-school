require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'validations' do
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :days }
  end

  describe 'associations' do
    it { should belong_to(:teacher) }
    it { should belong_to(:subject) }
    it { should belong_to(:classroom) }
  end
end
