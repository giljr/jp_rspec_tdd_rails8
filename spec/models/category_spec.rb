require 'rails_helper'

RSpec.describe Category, type: :model do
  # Associations
  it { should have_many(:products) }

  # Validations
  it { should validate_presence_of(:description) }
  it { should validate_uniqueness_of(:description).case_insensitive }
end
