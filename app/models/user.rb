class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  has_many :user_answers, inverse_of: :user, dependent: :destroy
  validates :username, presence: true,  uniqueness: {case_sensitive: false}

  # TODO
  def admin?
    username == 'admin'
  end

  def player?
    username != 'admin'
  end


  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def participant?(game)
    UserAnswer.where(question: game.questions, user: self).count > 0
    # Game.questions.pluck(:id)
  end

  def played_games
    Game.all.select{|game| participant?(game) }
  end

  def num_games
    played_games.count
  end
  
  def total_score
    played_games.map{|game| game.total_score(self) }.inject(0, &:+)
  end

  def max_score
    played_games.map{|game| game.max_score }.inject(0, &:+)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
