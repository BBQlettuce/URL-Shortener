class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :long_url, uniqueness: true
  validates :short_url, presence: true
  validates :short_url, uniqueness: true
end
