require 'rails_helper'

RSpec.describe Subject, type: :model do
  it { should validate_presence_of(:name) }
end
