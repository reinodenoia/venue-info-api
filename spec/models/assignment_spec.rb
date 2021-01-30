require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:assignment) { FactoryBot.build(:assignment) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(assignment).to be_valid
    end
  
    context 'is not valid without' do
      it "a api_key" do
        assignment.api_key = nil
        expect(assignment).not_to be_valid
      end
    end

    it 'is not valid because other with the same name exists' do
      assignment.assign_attributes(platform_id: 1, venue_id: 1)
      assignment.save
      other_assignment = FactoryBot.build(:assignment, 
                                          platform_id: assignment.platform_id,
                                          venue_id: assignment.venue_id)
      expect(other_assignment).not_to be_valid
    end
  end
end
