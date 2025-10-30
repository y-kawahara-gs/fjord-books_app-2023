# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioner, class_name: 'Report', inverse_of: :active_mentions
  belongs_to :mentioned, class_name: 'Report', inverse_of: :passive_mentions

  validates :mentioner_id, uniqueness: { scope: :mentioned_id }
end
