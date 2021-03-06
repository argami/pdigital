class ArticleComment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :votes
  
  validates :comment, :presence => true
  validates :comment, :length => { :in => 2..700 }
  validates :comment, :uniqueness => { :scope => [:user_id, :article_id, :active] }
  
  def clean
    Sanitize.clean(self.comment, :elements => ['a','b','br'])
  end
  
  def vote(type, ip)
    self.votes.create! :vote_type => type, :ip => ip
  end
  
  def vots_result
    positive = self.votes.where(:vote_type => 1)
    negative = self.votes.where(:vote_type => 2)
    total = positive.count - negative.count
    return total
  end
  
  def voted(ip)
    voted = self.votes.where(:ip => ip)
    if voted.count == 0
      return false
    else
      return true
    end
  end
  
end
