class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price

  def initialize(title, price)
    @title = title
    @price= price
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end

class RegularPrice
  def charge(days_rented)
    result = 2
    if days_rented > 2
      result += (days_rented - 2) * 1.5
    end
    result
  end

  def frequent_renter_points(days_rented)
    return 1
  end

end

class NewReleasePrice
  def charge(days_rented)
    (days_rented * 3)
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end

end

class ChildrensPrice
  def charge(days_rented)
    result = 1.5
    if days_rented > 3
      result += (days_rented - 3) * 1.5
    end
    result
  end

  def frequent_renter_points(days_rented)
    return 1
  end

end
