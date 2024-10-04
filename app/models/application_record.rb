class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #mission、taskコントローラのdestroyアクションで使用してる
  def check_foreign_key(subject_model, foreign_key_name)
    subject_records = subject_model.all
    subject_records.each do |subject_record|
      if subject_record.send(foreign_key_name) == self.id
        return false
      end
    end
    return true
  end
end