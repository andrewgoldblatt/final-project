class GearsController < ApplicationController
  def index
    matching_gears = Gear.all

    @list_of_gears = matching_gears.order({ :created_at => :desc })

    render({ :template => "gears/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_gears = Gear.where({ :id => the_id })

    @the_gear = matching_gears.at(0)

    render({ :template => "gears/show.html.erb" })
  end

  def create
    the_gear = Gear.new
    the_gear.photo = params.fetch("query_photo")
    the_gear.name = params.fetch("query_name")
    the_gear.condition = params.fetch("query_condition")
    the_gear.size = params.fetch("query_size")

    if the_gear.valid?
      the_gear.save
      redirect_to("/gears", { :notice => "Gear created successfully." })
    else
      redirect_to("/gears", { :notice => "Gear failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_gear = Gear.where({ :id => the_id }).at(0)

    the_gear.photo = params.fetch("query_photo")
    the_gear.name = params.fetch("query_name")
    the_gear.condition = params.fetch("query_condition")
    the_gear.size = params.fetch("query_size")

    if the_gear.valid?
      the_gear.save
      redirect_to("/gears/#{the_gear.id}", { :notice => "Gear updated successfully."} )
    else
      redirect_to("/gears/#{the_gear.id}", { :alert => "Gear failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_gear = Gear.where({ :id => the_id }).at(0)

    the_gear.destroy

    redirect_to("/gears", { :notice => "Gear deleted successfully."} )
  end
end
