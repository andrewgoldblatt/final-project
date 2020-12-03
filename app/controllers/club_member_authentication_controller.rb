class ClubMemberAuthenticationController < ApplicationController
  # Uncomment this if you want to force club_members to sign in before any other actions
  skip_before_action(:force_club_member_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "club_member_authentication/sign_in.html.erb" })
  end

  def create_cookie
    club_member = ClubMember.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if club_member != nil
      are_they_legit = club_member.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/club_member_sign_in", { :alert => "Incorrect password." })
      else
        session[:club_member_id] = club_member.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/club_member_sign_in", { :alert => "No club_member with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "club_member_authentication/sign_up.html.erb" })
  end

  def create
    @club_member = ClubMember.new
    @club_member.email = params.fetch("query_email")
    @club_member.password = params.fetch("query_password")
    @club_member.password_confirmation = params.fetch("query_password_confirmation")
    @club_member.first_name = params.fetch("query_first_name")
    @club_member.last_name = params.fetch("query_last_name")
    @club_member.year = params.fetch("query_year")
    @club_member.phone_number = params.fetch("query_phone_number")
    @club_member.rentals_count = params.fetch("query_rentals_count")

    save_status = @club_member.save

    if save_status == true
      session[:club_member_id] = @club_member.id
   
      redirect_to("/", { :notice => "Club member account created successfully."})
    else
      redirect_to("/club_member_sign_up", { :alert => "Club member account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "club_member_authentication/edit_profile.html.erb" })
  end

  def update
    @club_member = @current_club_member
    @club_member.email = params.fetch("query_email")
    @club_member.password = params.fetch("query_password")
    @club_member.password_confirmation = params.fetch("query_password_confirmation")
    @club_member.first_name = params.fetch("query_first_name")
    @club_member.last_name = params.fetch("query_last_name")
    @club_member.year = params.fetch("query_year")
    @club_member.phone_number = params.fetch("query_phone_number")
    @club_member.rentals_count = params.fetch("query_rentals_count")
    
    if @club_member.valid?
      @club_member.save

      redirect_to("/", { :notice => "Club member account updated successfully."})
    else
      render({ :template => "club_member_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_club_member.destroy
    reset_session
    
    redirect_to("/", { :notice => "ClubMember account cancelled" })
  end
 
end
