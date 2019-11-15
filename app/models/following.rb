class Following < ApplicationRecord
  belongs_to :from, class_name: 'User', foreign_key: 'from_id'
  belongs_to :to, class_name: 'User', foreign_key: 'to_id'

  def self.has_duplicate(following)
    duplicate = find_by(from: following.from, to: following.to)
    return ! (duplicate.nil?)
  end

end
