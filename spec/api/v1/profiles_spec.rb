require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do
  describe 'Profile API' do
    context 'Unauthorized' do
      let(:controller) { 'api/v1/profiles' }

      %i(me users).each do |action|
        describe "GET /#{action}" do
          it 'returns 401 if have no access_token' do
            get action, format: :json

            expect(response.status).to eq 401
          end

          it 'returns 401 if access_token is invalid' do
            get action, params: { access_token: '12342' }, format: :json

            expect(response.status).to eq 401
          end
        end
      end
    end

    context 'Authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id ).token }
      describe 'GET /me' do
        before do
          get :me, params: { access_token: access_token }, format: :json
        end

        it { expect(response).to be_success }

        %w(id email created_at updated_at).each do |field|
          it "contains #{field}" do
            expect(response.body).to be_json_eql(user.send(field).to_json).at_path(field)
          end
        end

        %w(password password_confirmation).each do |field|
          it "does not contains #{field}" do
            expect(response.body).to_not have_json_path(field)
          end
        end
      end

      describe 'GET /users' do
        let!(:other_users) { create_list :user, 7 }

        before do
          get :users, params: { access_token: access_token }, format: :json
        end

        it { expect(response).to be_success }

        it 'contains users list with right length' do
          expect(response.body).to have_json_size(other_users.size)
        end

        it 'does not contains current resource owner' do
          expect(response.body).to_not include_json(user.to_json)
        end

        %w(id email created_at updated_at).each do |field|
          it "records contains #{field}" do
            expect(response.body).to have_json_path("0/#{field}")
          end
        end

        %w(password password_confirmation).each do |field|
          it "records does not contains #{field}" do
            expect(response.body).to_not have_json_path("0/#{field}")
          end
        end
      end
    end
  end
end
