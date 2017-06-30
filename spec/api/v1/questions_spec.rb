require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  describe 'Questions API' do
    context 'Unauthorized' do
      %i(index show).each do |action|
        describe "GET /#{action}" do
          let!(:question) { create :question }

          it 'returns 401 if have no access_token' do
            get action, params: { id: question.id }, format: :json

            expect(response.status).to eq 401
          end

          it 'returns 401 if access_token is invalid' do
            get action, params: { id: question.id, access_token: '12342' }, format: :json

            expect(response.status).to eq 401
          end
        end
      end
    end

    context 'Authorized' do

      assign_user
      let(:access_token) { create(:access_token, resource_owner_id: user.id ).token }

      describe 'GET /index' do
        let(:questions) { create_list :question, 3 }
        let!(:question) { questions.first }

        before { get :index, params: { access_token: access_token }, format: :json }

        it 'should contains questions' do
          expect(response.body).to have_json_size(3)
        end

        %w(id title body created_at updated_at).each do |field|
          it "questions should contain #{field}" do
            expect(response.body).to be_json_eql(question.send(field).to_json).at_path("0/#{field}")
          end
        end
      end

      describe 'GET /show' do
        let!(:question) { create :question }

        before { get :show, params: { id: question.id, access_token: access_token }, format: :json }

        %w(id title body created_at updated_at).each do |field|
          it "questions should contain #{field}" do
            expect(response.body).to be_json_eql(question.send(field).to_json).at_path(field)
          end
        end
      end
    end
  end
end
