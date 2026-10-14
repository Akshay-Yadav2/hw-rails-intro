class Movie < ApplicationRecord
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    return all if ratings_list.blank?

    where('UPPER(rating) IN (?)', ratings_list.map(&:upcase))
  end

  def self.sorted_by(column)
    case column
    when 'title'
      collation = connection.adapter_name.downcase.include?('postgres') ? ' COLLATE "C"' : ''
      order(Arel.sql("title#{collation}"))
    when 'release_date'
      order(:release_date)
    else
      all
    end
  end
end
