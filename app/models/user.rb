class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: true

  has_many :books, dependent: :destroy
  has_many :post_images, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image.jpg'
    end
  end
end
