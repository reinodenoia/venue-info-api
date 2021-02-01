require 'rails_helper'

describe Venue, type: :model do
  let(:venue) { FactoryBot.build(:venue) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(venue).to be_valid

      venue.website = 'http://google.com'
      venue.phone = '+34981823322'
      expect(venue).to be_valid
    end

    context 'is not valid without' do
      %w[name address lat lng closed category].each do |field|
        it "a #{field}" do
          venue.send("#{field}=", nil)
          expect(venue).not_to be_valid
        end
      end

      it 'with wrong category' do
        venue.category = 203
        expect(venue).not_to be_valid
      end

      it 'with wrong total hours' do
        venue.hours = %w[10:00-22:00 10:00-22:00 10:00-22:00]
        expect(venue).not_to be_valid
      end

      it 'with wrong hours format' do
        venue.hours =  %w[10-22 10-22 10-22]
        expect(venue).not_to be_valid
        venue.hours = [1, 2, 3]
        expect(venue).not_to be_valid
      end

      it 'with wrong website format' do
        venue.website = 'wwww.google.com'
        expect(venue).not_to be_valid
      end

      it 'with wrong phone format' do
        venue.phone = '+965675'
        expect(venue).not_to be_valid
      end
    end

    it 'is not valid because other with the same name exists' do
      venue.save
      other_venue = FactoryBot.build(:venue, name: venue.name)
      expect(other_venue).not_to be_valid
    end
  end
end