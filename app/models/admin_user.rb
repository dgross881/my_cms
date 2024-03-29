class AdminUser < ActiveRecord::Base
 
  has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits  
	has_many :sections, :through => :section_edits 
 
  
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary']

  # shortcut validations, aka "sexy validations"
  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 },
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  #validate :username_is_allowed
  #validate :no_new_users_on_saturday, :on => :create 
  
  scope :sorted, lambda{order('last_name ASC', 'first_name ASC')}

  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name].join(' ')
  end 
  
  private
  
  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use.")
    end
  end 

end
