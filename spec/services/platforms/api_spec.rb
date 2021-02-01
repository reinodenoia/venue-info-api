require 'rails_helper'

describe Platforms::Api do
  context 'private methods' do
    it { expect(described_class.new.send('host')).not_to be nil }

    it '#build_url' do
      platform = 'platform_a'
      api_key = 'abcdqwerty'
      result = "https://rails-code-challenge.herokuapp.com/platform_a/venue?api_key=abcdqwerty"

      expect(described_class.new.send('build_url', *[platform, api_key])).to eq result
    end

    describe '#build_request_params' do
      it 'should return params without body' do
        result = { headers: { 'Content-type' => 'application/json' }}
        expect(described_class.new.send('build_request_params')).to eq result
      end

      it 'should return params with body' do
        body = { name: 'name', address: 'address' }
        result = { headers: { 'Content-type' => 'application/json' }, body: body }
        expect(described_class.new.send('build_request_params', body)).to eq result
      end
    end
  end
end