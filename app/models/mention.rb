class Mention < ApplicationRecord
  belongs_to :mentioner, class_name: "Report", inverse_of: :active_mentions
  belongs_to :mentioned, class_name: "Report", inverse_of: :passive_mentions

  validates :mentioner_id, uniqueness: true
  validates :mentioned_id, uniqueness: true
end
