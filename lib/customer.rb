class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      result += "\t" + element.movie.title + "\t" + element.charge.to_s + "\n"
    end
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{frequent_renter_points} frequent renter points\n"
    result
  end

  private
  def total_charge
    return @rentals.inject(0) do |sum, rental|
      sum += rental.charge
    end
  end

  def frequent_renter_points
    return @rentals.inject(0) do |sum, rental|
      sum + rental.frequent_renter_points
    end
  end
end
