class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :long_url, uniqueness: true
  validates :short_url, presence: true
  validates :short_url, uniqueness: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    until !ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.new(long_url: long_url, short_url: random_code, submitter_id: user.id)
  end

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitors

  def num_clicks
    visits.count("visitor_id")
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques(time_ago)
    visits.where("created_at > ?", time_ago).count("DISTINCT visitor_id")
  end
end
