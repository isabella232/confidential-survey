require 'securerandom'

class SurveyToken < ActiveRecord::Base
  def self.generate(survey_id)
    rec = create(survey_id: survey_id, token: SecureRandom.uuid)
    rec.token
  end

  def self.valid?(survey_id, token)
    where(survey_id: survey_id, token: token).exists?
  end
  
  def self.revoke(survey_id, token)
    t = where(survey_id: survey_id, token: token).first
    t.destroy unless t.nil?
    end
  
  def self.revoke_all_for_survey(survey_id)
    delete_all(survey_id: survey_id)
  end
end
