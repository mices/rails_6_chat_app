class UsersController < ApplicationController
   before_action :authenticate_user!, only: [:profile, :edit_profile, :edit_blog_settings, :account]
   before_action :authenticate_admin!, only: [:show, :index, :destroy, :new, :create]
   before_action :set_user, only: [:show, :edit, :update, :destroy]  
   before_action :validate_user, only: [:profile, :edit_profile]
   before_action :count_addresses, only: [:profile, :edit_profile]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
          format.html { redirect_to users_path, notice: (t 'user_was_successfully_created') }
          format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    respond_to do |format|
      if @user.update(user_params)
        if admin_signed_in?
          format.html { redirect_to users_path, notice: (t 'user_was_successfully_updated') }
          format.json { render :index, status: :created, location: @user }
        else
          if(request.referrer=~/edit_blog_settings/)
                      format.html { redirect_to blog_settings_path, notice: (t 'blog_settings_were_successfully_updated') }
                      format.json { render :show, status: :created, location: @user }
          else
                      format.html { redirect_to profile_path, notice: (t 'profile_was_successfully_updated') }
                      format.json { render :show, status: :created, location: @user }
          end
        end
      else
        if(request.referrer=~/edit_blog_settings/)
          format.html { render :edit_blog_settings }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        else
          format.html { render :edit_profile }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def profile
 end
  
  def edit_profile
    @user=current_user
    render '_profile_form'
  end
 
  
  def account
  end
  
  private

    def set_user
      @user = User.find(params[:id])
    end
  
    def validate_user
    if user_signed_in?
      if(current_user.restrictions.where("cleared_at is null").count >= 1)
        redirect_to '/pages/restricted/', notice: 'Account restricted'
      end
    end
  end


  def count_addresses
    if(current_user.addresses.count < 1)
      redirect_to addresses_path, notice: 'You don\'t have any addresses Please add at least one address'
    end
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
     params.require(:user).permit(:name, :first_name, :middle_name, :last_name, :gender, :age, :birth_date, :birth_place_country, :birth_place_state, :birth_place_city, :country, :city, :state, :living_there_since, :status, :interests, :description, :restricted, :restricted_reason, :band, :genre, :blog_title, :blog_description, :subdomain,  :blog_about_the_author)
    end
end
