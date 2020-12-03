Rails.application.routes.draw do


get("/", { :controller => "gears", :action => "index" })

  # Routes for the Rental resource:

  # CREATE
  post("/insert_rental", { :controller => "rentals", :action => "create" })
          
  # READ
  get("/rentals", { :controller => "rentals", :action => "index" })

  get("/rentals/my_rentals", { :controller => "rentals", :action => "my_rentals" })
  
  get("/rentals/:path_id", { :controller => "rentals", :action => "show" })

  get("/rentals/new_rental/:gear_id", { :controller => "rentals", :action => "new_rental" })
  

  # UPDATE
  
  post("/modify_rental/:path_id", { :controller => "rentals", :action => "update" })
  
  # DELETE
  get("/delete_rental/:path_id", { :controller => "rentals", :action => "destroy" })

  #------------------------------

  # Routes for the Club member account:

  # SIGN UP FORM
  get("/club_member_sign_up", { :controller => "club_member_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_club_member", { :controller => "club_member_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_club_member_profile", { :controller => "club_member_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_club_member", { :controller => "club_member_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_club_member_account", { :controller => "club_member_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/club_member_sign_in", { :controller => "club_member_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/club_member_verify_credentials", { :controller => "club_member_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/club_member_sign_out", { :controller => "club_member_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the Gear resource:

  # CREATE
  post("/insert_gear", { :controller => "gears", :action => "create" })
          
  # READ
  get("/gears", { :controller => "gears", :action => "index" })
  
  get("/gears/:path_id", { :controller => "gears", :action => "show" })
  
  # UPDATE
  
  post("/modify_gear/:path_id", { :controller => "gears", :action => "update" })
  
  # DELETE
  get("/delete_gear/:path_id", { :controller => "gears", :action => "destroy" })

  #------------------------------

end
