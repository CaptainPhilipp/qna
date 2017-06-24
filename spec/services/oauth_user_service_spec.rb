require 'rails_helper'

RSpec.describe OauthUserService do
  let(:email)     { 'example@example.com' }
  let(:provider)  { 'facebook' }
  let(:uid)       { '12341234' }

  let(:user)      { create :user, email: email }
  let(:auth_hash) { OmniAuth::AuthHash.new provider: provider, uid: uid }
  let(:session)   { {} }
  let(:request)   { Struct.new(:env).new('omniauth.auth' => auth_hash) }

  let(:send_get_user) { OauthUserService.new(request, session).get_user }

  context '#get_user' do
    context 'when user exists' do
      before { user }

      context 'and authentication exist' do
        let!(:authentication) { create :oauth_authorization, provider: provider, uid: uid, user: user }

        it 'should find user' do
          expect(send_get_user).to eq user
        end
      end
    end

    context 'when user is not exist' do
      context 'and providers respond have email' do
        let(:auth_hash) { OmniAuth::AuthHash.new provider: provider, uid: uid, info: { email: email } }

        it 'should create user' do
          expect { send_get_user }.to change(User, :count).by(1)
          expect(User.last.oauth_authorizations.last).to eq OauthAuthorization.last
        end

        it 'should create association' do
          expect { send_get_user }.to change(OauthAuthorization, :count).by(1)
          expect(OauthAuthorization.last.user).to eq User.last
        end
      end
    end
  end

  context '.from_session' do
    context '(providers respond have no email)' do
      let(:auth_hash) { OmniAuth::AuthHash.new provider: provider, uid: uid }
      let(:params) { { email: email } }

      it 'should create user' do
        expect { send_get_user }.to_not change(User, :count)
        expect { OauthUserService.from_session(params, session) }.to change(User, :count).by(1)
      end
    end
  end
end
