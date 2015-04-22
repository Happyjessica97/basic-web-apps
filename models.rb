class Story 
  include DataMapper::Resource

  property :id,         Serial
  property :title,      Text
  property :body,       Text,     required: true
  property :created_at, DateTime, required: true
  property :likes,      Integer,  default: 0
end

class User 
  include DataMapper::Resource 
  property :id,    Serial 
  property :email, String, 
    :format => :email_address,
    :required => true,
    :unique => true, 
    :messages => {
        :format => "you must have a valid email address"
    }

  property :password, BCryptHash, :required => true

  validates_confirmation_of :password

  # Due to the way DataMapper works, we have to add the length
  #   validation to the confirmation field.checking 
  attr_accessor :password_confirmation
  validates_length_of :password_confirmation, :min => 6

  # Given a User object, check whether a given password matches
  #   the password stored in the database.
  def valid_password?(unhashed_password)
    # Note: BCryptHash "overloads" the == operator, so we're actually
    #   comparing a BCrypt-hashed copy of unhashed_password to the hashed
    #   copy stored in our database.   +to check the user input to the database data
    self.password == unhashed_password
  end

  # A small helpers to find Users by email address
  def self.find_by_email(email)
    self.first(:email => email)
  end
end

DataMapper.finalize()
DataMapper.auto_upgrade!()
