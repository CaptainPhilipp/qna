# frozen_string_literal: true

class CreateOauthAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :oauth_authorizations do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
      t.index %i[provider uid]
    end
  end
end
