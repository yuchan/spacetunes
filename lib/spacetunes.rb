require "spacetunes/version"
require "spaceship"
require "redcarpet"

module Spacetunes
  class Review
    attr_accessor :app
    attr_accessor :ratings

    def initialize()
      Spaceship::Tunes.login
      all_apps = Spaceship::Tunes::Application.all
      @app = all_apps[0]
    end

    def generate(rate)
      ratings = []
      5.times do
        ratings.push(Rating.new)
      end

      @app.ratings.versions.sort{|(k1,v1), (k2,v2)| k2.to_i <=> k1.to_i }.each do |k, v|
        reviews = @app.ratings.reviews("JP", k)

        ratings.each do |rating|
          rating.prepareVersion(v)
        end

        reviews.each do |review|
          ratings[review["rating"].to_i - 1].process(v, review["rating"], review["title"], review["review"])
        end
      end

      ratings[rate].generate(rate)
    end

    private

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
          text += "## <a name=\"#{k}\"></a>" + k + "'s #{rate + 1}-star reviews\n"
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
        stars = ""
        rating.to_i.times do
          stars += "\u{1f4a9} "
        end

        @rating = stars
        @text = text
        @title = title
      end
    end
  end
end
