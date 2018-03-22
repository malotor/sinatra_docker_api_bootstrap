class Article < ActiveRecord::Base

    attr_reader :published,:published_on,:title,:content

    validates :title, presence: true, length: { maximum: 100 }
    validates :content, presence: true

    def initialize(title, content)
      @title = title
      @content = content
      @published  = false
      @likes = 0
    end

    def have_been_published?
      @published
    end

    def publish
      raise ArticlesHasAlreadyPublishedError if @published
      @published = true
      @published_on = Time.now
    end


end

class ArticlesHasAlreadyPublishedError < StandardError
end
