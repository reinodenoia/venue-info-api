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

    context 'sending data to external service' do
      describe '#transform_category_format' do
        platforms = [
          { factory: FactoryBot.build(:platform),
            category: 2, 
            result: 1002
          },
          {
            factory: FactoryBot.build(:platform, category_range: [3000, 3200]),
            category: 34,
            result: 3034
          }
        ]

        platforms.each do |platform|
          it 'should transform category value' do
            expect(platform[:factory].transform_category(platform[:category])).to eq platform[:result]
          end
        end
      end

      describe '#transform_hours' do
        let (:hours) { 
          ["10:00-22:00",
           "10:00-22:00",
           "10:00-22:00",
           "10:00-22:00",
           "10:00-22:00",
           "11:00-18:00",
           "11:00-18:00"]
        }
        platforms = [
          { 
            factory: FactoryBot.build(:platform),
            result: '10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|11:00-18:00|11:00-18:00'
          },
          {
            factory: FactoryBot.build(:platform, hours_format: 'Mon:hour-hour|Tue:hour-hour|Wed:hour-hour|Thu:hour-hour|Fri:hour-hour|Sat:hour-hour|Sun:hour-hour'),
            result: 'Mon:10:00-22:00|Tue:10:00-22:00|Wed:10:00-22:00|Thu:10:00-22:00|Fri:10:00-22:00|Sat:11:00-18:00|Sun:11:00-18:00'
          },
          {
            factory: FactoryBot.build(:platform, hours_format: 'hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour'),
            result: '10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00'
          }
        ]

        platforms.each do |platform|
          it 'should transform hours value' do 
            expect(platform[:factory].transform_hours(hours)).to eq platform[:result]
          end
        end
      end

      describe '#platform_body' do
        let(:body) {
          {
            name: 'Waelchi-Lindgren',
            address: '9821 Boehm Falls',
            additional_address: 'Apt. 127',
            lat: 15.8928681484,
            lng: 101.3330876089,
            category: 0,
            closed: true,
            website: 'https://localistico.com',
            phone: '+34666999666',
            hours: ['10:00-22:00',
                    '10:00-22:00',
                    '10:00-22:00',
                    '10:00-22:00',
                    '10:00-22:00',
                    '11:00-18:00',
                    '11:00-18:00']
          }
        }

        platforms = [
          { 
            factory: FactoryBot.build(:platform),
            result: {
              name: 'Waelchi-Lindgren',
              address: '9821 Boehm Falls',
              lat: 15.8928681484,
              lng: 101.3330876089,
              category_id: 1000,
              closed: true,
              hours: '10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|10:00-22:00|11:00-18:00|11:00-18:00'
            }
          },
          {
            factory: FactoryBot.build(:platform, 
              {
                name: 'platform_b',
                fields: { name: :name,
                          address: :street_address,
                          additional_address: nil,
                          lat: :lat,
                          lng: :lng,
                          category: :category_id,
                          closed: :closed, 
                          hours: :hours,
                          website: nil,
                          phone: nil
                        },
                category_range: [2000, 2200],
                hours_format: 'Mon:hour-hour|Tue:hour-hour|Wed:hour-hour|Thu:hour-hour|Fri:hour-hour|Sat:hour-hour|Sun:hour-hour'
              }
            ),
            result: {
              name: 'Waelchi-Lindgren',
              street_address: '9821 Boehm Falls',
              lat: 15.8928681484,
              lng: 101.3330876089,
              category_id: 2000,
              closed: true,
              hours: 'Mon:10:00-22:00|Tue:10:00-22:00|Wed:10:00-22:00|Thu:10:00-22:00|Fri:10:00-22:00|Sat:11:00-18:00|Sun:11:00-18:00'
            }
          },
          {
            factory: FactoryBot.build(:platform,
              {
                name: 'platform_c',
                fields: { name: :name,
                  address: :address_line_1,
                  additional_address: :address_line_2,
                  lat: :lat,
                  lng: :lng,
                  category: nil,
                  closed: :closed, 
                  hours: :hours,
                  website: :website,
                  phone: :phone_number
                },
                hours_format: 'hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour,hour-hour'
              }
            ),
            result: {
              name: 'Waelchi-Lindgren',
              address_line_1: '9821 Boehm Falls',
              address_line_2: 'Apt. 127',
              lat: 15.8928681484,
              lng: 101.3330876089,
              website: 'https://localistico.com',
              phone_number: '+34666999666',
              closed: true,
              hours: '10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00'
            }
          }
        ]

        platforms.each do |platform|
          it 'should transform body values' do
            expect(platform[:factory].transform_body(body)).to eq platform[:result]
          end
        end
      end
    end
  end
end
