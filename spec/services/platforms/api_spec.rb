require 'rails_helper'
require 'httparty'

describe Platforms::Api do
  context 'Validates external API viability' do
    describe 'GET requests' do
      %w[platform_a platform_b platform_c].each do |platform|
        it 'should return OK' do
          host = APP_CONFIG[:platforms][:api][:host]
          response = HTTParty.get("#{host}/#{platform}/venue?api_key=34da2ea215823f4305193cf87b37a9b7")
          expect(response.code).to eql(200)
        end
      end
    end 
  end

  context 'private methods' do
    it { expect(described_class.new.send('host')).not_to be nil }

    it '#build_url' do
      platform = 'platform_a'
      api_key = 'abcdqwerty'
      result = "https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=abcdqwerty"

      expect(described_class.new.send('build_url', *[platform, api_key])).to eq result
    end
  end
end