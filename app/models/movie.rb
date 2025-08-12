class Movie < ApplicationRecord
  RATINGS = %w[G PG PG-13 R NC-17].freeze

  def self.all_ratings
    RATINGS
  end

  def self.with_ratings(ratings_list)
    return all if ratings_list.blank?
    where('upper(rating) IN (?)', ratings_list.map(&:upcase))
  end

  def self.sorted(scope, sort_by)
    return scope if sort_by.blank? || !%w[title release_date].include?(sort_by)
    scope.order(sort_by => :asc)
  end
end
