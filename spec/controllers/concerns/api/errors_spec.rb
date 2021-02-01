require 'rails_helper'

describe Api::VenuesController do
  describe 'GET show' do
    ERRORS = {
      'NotFound' => { http: 404 },
      'InvalidParameter' => { http: 422 }
    }.freeze

    ERRORS.each do |name, codes|
      context "when #{name} error" do

        subject! do
          allow_any_instance_of(described_class).to receive(:show).and_raise(
            "Api::Errors::#{name}".constantize
          )

          get :show, params: { id: 1 }
        end

        it "Response has #{codes[:http]} HTTP code" do
          expect(response.code.to_i).to eq codes[:http]
        end

        it "Response has #{codes[:code]} code" do
          expect(JSON.parse(response.body)['error']['code']).to(
            eq codes[:code]
          )
        end
      end
    end
  end
end
