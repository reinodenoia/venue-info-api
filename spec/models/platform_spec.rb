require 'rails_helper'

RSpec.describe Platform, type: :model do
  let(:platform) { FactoryBot.build(:platform) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(platform).to be_valid
    end

    context 'is not valid without' do
      %w[name fields].each do |field|
        it "a #{field}" do
          platform.send("#{field}=", nil)
          expect(platform).not_to be_valid
        end
      end

      it 'with wrong fields' do
        platform.fields = '{ "address", "address" }'
        expect(platform).not_to be_valid
      end

      it 'with wrong category_range' do
        platform.category_range = [1, 2, 3]
        expect(platform).not_to be_valid
      end

      it 'with wrong hours_format' do
        platform.hours_format = "Mon:10:00-22:00|Tue:10:00-22:00|Wed:10:00-22:00|Thu:10:00-22:00|Fri:10:00-22:00|Sat:11:00-18:00|Sun:11:00-18:00||"
        expect(platform).not_to be_valid
      end
    end

    it 'is not valid because other with the same name exists' do
      platform.save
      other_platform = FactoryBot.build(:platform, name: platform.name)
      expect(other_platform).not_to be_valid
    end
  end
end
