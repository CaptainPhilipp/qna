# frozen_string_literal: true

class DailyMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_mailer.digest.subject
  #
  def digest(user, new_questions)
    @new_questions = new_questions
    mail to: user.email, subject: 'Daily digest'
  end
end
