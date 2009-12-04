require 'spec'
require 'customer'
require 'movie'
require 'rental'

describe Customer do
  before(:each) do
    @customer = Customer.new("Test Man")
  end
  
  it "should have an empty statement" do
    expected_statement = <<STATEMENT_END
Rental Record for Test Man
Amount owed is 0
You earned 0 frequent renter points
STATEMENT_END

    @customer.statement.should == expected_statement
  end

  it "should have statement with 1 Regular movie for 1 day" do  
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(RegularPrice.new, 2, 1)
  end

  it "should have statement with 1 Regular movie for 3 days" do
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(RegularPrice.new, 3.5, 3)
  end

  it "should have a statement with a new release" do
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(NewReleasePrice.new, 3, 1)
  end

  it "should have a statement for a childrens movie for 1 day" do
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(ChildrensPrice.new, 1.5, 1)
  end

  it "should have a statement for a childrens movie for 4 days" do
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(ChildrensPrice.new, 3.0, 4)
  end

  it "should give an additional frequent renter point for new release rented for 2 days" do
    rental = verifyStatementForMovieTypeAndAmountOwedAndRentalLength(NewReleasePrice.new, 6, 2, 2)
  end

  def verifyStatementForMovieTypeAndAmountOwedAndRentalLength movie_type, amount_owed, rental_length, frequent_renter_points=1
    expected_statement = <<STATEMENT_END
Rental Record for Test Man
	A New Smash hit	#{amount_owed}
Amount owed is #{amount_owed}
You earned #{frequent_renter_points} frequent renter points
STATEMENT_END

    movie = Movie.new("A New Smash hit", movie_type)
    rental = Rental.new(movie, rental_length)

    @customer.add_rental(rental)

    @customer.statement.should == expected_statement
  end
  
end