class Visit < ActiveRecord::Base

  def self.record_visit!(shortened_url, user)
    Visit.new(url_id: shortened_url.id, visitor_id: user.id).save
  end

  belongs_to :visitors,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id

  belongs_to :visited_urls,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
end
