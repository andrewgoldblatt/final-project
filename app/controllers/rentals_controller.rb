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
      redirect_to("/rentals/my_rentals", { :notice => "Rental created successfully." })
      
      twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
      twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
      twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")  
      twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
      sms_parameters = {
      :from => twilio_sending_number,
      :to => "+13038886814", # Put your own phone number here if you want to see it in action
      :body => @current_club_member.first_name + " " + @current_club_member.last_name + " made a new reservation for " + 
      the_rental.gear.name + ". Check out date is " + the_rental.check_out_date.to_s + ", the return date is " +
     the_rental.return_date.to_s + ""}
      
      twilio_client.api.account.messages.create(sms_parameters)
  
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

    redirect_to("/rentals/my_rentals", { :notice => "Rental deleted successfully."} )
  end
end
