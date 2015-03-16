class Article < ActiveRecord::Base

  has_many :comments, dependent: :destroy

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/images/:style/missing.png'
  validates_attachment :avatar,
                       :content_type => { :content_type => %w(image/jpeg image/gif image/png)}
  validates :title, presence: true,
            length: {minimum: 5}

end
