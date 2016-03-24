class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :async, :trackable, :validatable
  
  validate :email_is_unique, on: :create
  after_create :create_account
 
  #Commented because we want confirmation to be sent to gmail account       
  # def confirmation_required?
  #   false
  # end
  
  #Create an account, everytime, a new user is created
  def create_account
    account = Account.new(:email => email)
    account.save!
  end
  
  private
    #Email should be unique in Account model
    def email_is_unique
      return false unless self.errors[:email].empty?
      unless Account.find_by_email(email).nil?
        errors.add(:email, "is already taken")
      end
    end
    
end