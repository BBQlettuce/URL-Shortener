class Visit < ActiveRecord::Base
  belongs_to :visitors,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id

  belongs_to :visited_urls,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id
end
