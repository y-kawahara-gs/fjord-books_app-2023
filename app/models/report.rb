# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioner_id', dependent: :destroy, inverse_of: :mentioner
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned

  has_many :mentioning_reports, through: :active_mentions, source: :mentioned
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioner

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def create_mention!
    urls = URI.extract(content, ['http'])
    urls.map do |url|
      next unless url.match?(%r{http://127.0.0.1:3000/reports/})

      target_id = URI.parse(url).path.split('/').last
      next if id == target_id.to_i
      next unless Report.exists?(target_id)

      mentioned_report = Report.find_by(id: target_id)
      active_mentions.create!(mentioned: mentioned_report)
    end
  end
end
