class ApplicationController < ActionController::Base
  before_action(:load_current_club_member)
  
  # Uncomment this if you want to force club_members to sign in before any other actions
  # before_action(:force_club_member_sign_in)
  
  def load_current_club_member
    the_id = session[:club_member_id]
    @current_club_member = ClubMember.where({ :id => the_id }).first
  end
  
  def force_club_member_sign_in
    if @current_club_member == nil
      redirect_to("/club_member_sign_in", { :notice => "You have to sign in first." })
    end
  end

end
