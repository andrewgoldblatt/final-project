class RentalsController < ApplicationController
  def index
    matching_rentals = Rental.all

    @list_of_rentals = matching_rentals.order({ :created_at => :desc })

    render({ :template => "rentals/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_rentals = Gear.where({ :id => the_id })

    @the_rental = matching_rentals.at(0)

    render({ :template => "rentals/show.html.erb" })
  end

  def new_rental
    gear_id = params.fetch("gear_id")

    @gear = Gear.where({ :id => gear_id }).first 

    render({ :template => "rentals/new_rental.html.erb"})

  end 
  
    def my_rentals
    
  
    matching_rentals = @current_club_member.rentals

    @list_of_rentals = matching_rentals.order({ :created_at => :desc })

    render({ :template => "rentals/my_rentals.html.erb" })
  end

  def create
    the_rental = Rental.new
    the_rental.gear_id = params.fetch("query_gear_id")
    the_rental.check_out_date = params.fetch("query_check_out_date")
    the_rental.return_date = params.fetch("query_return_date")
    the_rental.member_id = @current_club_member.id

    if the_rental.valid?
      the_rental.save
      redirect_to("/rentals", { :notice => "Rental created successfully." })
    else
      redirect_to("/rentals", { :notice => "Rental failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_rental = Rental.where({ :id => the_id }).at(0)

    the_rental.gear_id = params.fetch("query_gear_id")
    the_rental.check_out_date = params.fetch("query_check_out_date")
    the_rental.return_date = params.fetch("query_return_date")
    the_rental.member_id = params.fetch("query_member_id")

    if the_rental.valid?
      the_rental.save
      redirect_to("/rentals/#{the_rental.id}", { :notice => "Rental updated successfully."} )
    else
      redirect_to("/rentals/#{the_rental.id}", { :alert => "Rental failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_rental = Rental.where({ :id => the_id }).at(0)

    the_rental.destroy

    redirect_to("/rentals", { :notice => "Rental deleted successfully."} )
  end
end
