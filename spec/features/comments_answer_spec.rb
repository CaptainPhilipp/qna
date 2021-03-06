# frozen_string_literal: true

require_relative 'acceptance_helper'

feature 'User can leave comment to a question' do
  assign_user
  let(:question) { create :question, user: user }
  let!(:answer)  { create :answer, user: user, question: question }
  let(:answer_selector) { "#answer_#{answer.id}" }
  let(:comment_body) { attributes_for(:comment)[:body] }

  context 'with multiple sessions', :js do
    scenario 'user comments a question' do
      Capybara.using_session(:guest) { visit question_path(question) }

      Capybara.using_session(:user) do
        login_user user
        visit question_path(question)

        within "#{answer_selector} .comment_form" do
          fill_in Comment.human_attribute_name(:body), with: comment_body
          click_button I18n.t(:create, scope: 'comments.form')
        end

        within "#{answer_selector} .comments" do
          expect(page).to have_content comment_body
        end
      end

      Capybara.using_session(:guest) do
        within "#{answer_selector} .comments" do
          expect(page).to have_content comment_body
        end
      end
    end
  end
end
