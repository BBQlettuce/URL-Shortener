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

end
