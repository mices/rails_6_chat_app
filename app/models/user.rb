require 'elasticsearch/model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  GENDER_TYPES =  ['Female', 'Male']
  RACE_TYPES =  ['Caucasian(White)', 'Black', 'Hispaic', 'Asian or Pacific Islander', 'East Asian']
 validates :gender, inclusion: GENDER_TYPES
 validates :birth_place_country, :birth_place_city, presence: true
 validates :birth_place_state, :presence => true, :if =>  Proc.new { |e| e.birth_place_country == "US" }
 validates :country, :city, presence: true
 validates :state, :presence => true, :if =>  Proc.new { |e| e.country == "US" }
 validates :first_name, :last_name, :birth_date, presence: true
 validates :age, presence: true, numericality: { only_integer: true }
 validate :validate_age
 validates :subdomain, uniqueness: true, length: 5..30, allow_blank: true
 validates_format_of  :subdomain, :with => /\A[a-zA-Z0-9\-]*?\z/, :message => 'accepts only letters, numbers and hyphens'
 has_many :friendables_active, class_name: 'Friendable', foreign_key: 'to_id', dependent: :destroy
 has_many :friendables_passive, class_name: 'Friendable', foreign_key: 'from_id', dependent: :destroy
 has_many :users, through: :friendables
 has_many :posts, dependent: :destroy
 has_many :events, dependent: :destroy
 has_many :schools, dependent: :destroy
 has_many :summer_camps, dependent: :destroy
 has_many :teams, through: :schools, dependent: :destroy
 has_many :pictures, as: :imageable
 has_many :addresses, dependent: :destroy
# has_many :comments, through: :commentables
 has_many :restrictions, dependent: :destroy
 has_many :restricted_reasons, through: :restrictions
 has_many :blogs
 acts_as_follower
 acts_as_followable
 acts_as_messageable
 include Elasticsearch::Model
 include Elasticsearch::Model::Callbacks
 User.import force: true
 mount_uploader :avatar_file_name, AvatarUploader, mount_on: :avatar_file_name
 accepts_nested_attributes_for :schools

 
   STATE_TYPES = 
  [
    ['Alabama', 'AL'],
    ['Alaska', 'AK'],
    ['Arizona', 'AZ'],
    ['Arkansas', 'AR'],
    ['California', 'CA'],
    ['Colorado', 'CO'],
    ['Connecticut', 'CT'],
    ['Delaware', 'DE'],
    ['District of Columbia', 'DC'],
    ['Florida', 'FL'],
    ['Georgia', 'GA'],
    ['Hawaii', 'HI'],
    ['Idaho', 'ID'],
    ['Illinois', 'IL'],
    ['Indiana', 'IN'],
    ['Iowa', 'IA'],
    ['Kansas', 'KS'],
    ['Kentucky', 'KY'],
    ['Louisiana', 'LA'],
    ['Maine', 'ME'],
    ['Maryland', 'MD'],
    ['Massachusetts', 'MA'],
    ['Michigan', 'MI'],
    ['Minnesota', 'MN'],
    ['Mississippi', 'MS'],
    ['Missouri', 'MO'],
    ['Montana', 'MT'],
    ['Nebraska', 'NE'],
    ['Nevada', 'NV'],
    ['New Hampshire', 'NH'],
    ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'],
    ['New York', 'NY'],
    ['North Carolina', 'NC'],
    ['North Dakota', 'ND'],
    ['Ohio', 'OH'],
    ['Oklahoma', 'OK'],
    ['Oregon', 'OR'],
    ['Pennsylvania', 'PA'],
    ['Puerto Rico', 'PR'],
    ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'],
    ['South Dakota', 'SD'],
    ['Tennessee', 'TN'],
    ['Texas', 'TX'],
    ['Utah', 'UT'],
    ['Vermont', 'VT'],
    ['Virginia', 'VA'],
    ['Washington', 'WA'],
    ['West Virginia', 'WV'],
    ['Wisconsin', 'WI'],
    ['Wyoming', 'WY']
  ]

  def validate_age
      if birth_date.present? && birth_date > 17.years.ago.to_i
          errors.add(:birth_date, (t 'age_advisory'))
      end
  end
  
 def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
  return self.user.email
  #if false
  #return nil
 end


  
end


