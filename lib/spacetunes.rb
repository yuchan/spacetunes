require "spacetunes/version"

module Spacetunes
  # Your code goes here...
  class Review
    attr_accessor :ratings

    def initialize()
      @ratings = []
      5.times do
        @ratings.push(Rating.new)
      end
    end

    def prepareVersion(version)
      @ratings.each do |rating|
        rating.prepareVersion(version)
      end
    end

    def process(rate, version, rating, title, text)
      @ratings[rate].process(version, rating, title, text)
    end

    def generate(rate)
      @ratings[rate].generate(rate)
    end
    
    class Rating
      attr_accessor :count
      attr_accessor :reviews
      def initialize()
        @count = 0
        @reviews = {}
      end

      def prepareVersion(version)
        @reviews[version] = [] if @reviews[version].nil?
      end

      def process(version, rating, title, text)
        review = ReviewItem.new(rating, title, text)
        if @reviews[version].nil?
          @reviews[version] = [review]
        else
          @reviews[version].push(review)
        end
      end

      def generate(rate)
        text = ""
        links = ""
        @reviews.each do |k, review|
          text += "## <a name=\"#{k}\"></a>" + k + "'s #{rate}-star reviews\n"
          links += "- [#{k}(#{review.count})](##{k})\n"
          review.each do |rev|
            text += "### " + rev.title + "\n\n"
            text += "- " + rev.rating + "\n"
            text += "- " + rev.text + "\n\n"      
          end
        end
        links + "\n" + text
      end
    end

    class ReviewItem
      attr_accessor :rating
      attr_accessor :title
      attr_accessor :text

      def initialize(rating, title, text)
        @rating = rating
        @text = text
        @title = title
      end
    end
  end
end
