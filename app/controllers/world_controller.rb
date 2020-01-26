class WorldController < ApplicationController
  before_action :set_user, only: [:show_user, :show_profile, :page]
  respond_to :html, :js
  before_action :authenticate_user!, except: [:index, :set_locale]
  before_action :validate_user
  before_action :count_addresses, except: [:index, :set_locale]
  before_action :check_for_unread_messages

  def index
   if (user_signed_in?)
    @post = current_user.posts.new
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.all_following)
   end
  end

# GET /profiles/1
# GET /profiles/1.json
  def show_profile
   @friended = Friendable.where( ' accepted = true and (from_id = ? OR to_id = ? ) ', current_user.id,  current_user.id)
   @active_friend_request_pending = Friendable.where(' accepted = false and from_id = ? and to_id = ? ', current_user.id,  @user.id)
   @passive_friend_request_pending = Friendable.where(' accepted = false and from_id = ? and to_id = ? ', @user.id, current_user.id)
  end
  
  def show_school
    @school=School.find(params[:id])
  end

  def show_team
    @team=Team.find(params[:id])
  end

  def show_summer_camp
    @summer_camp=SummerCamp.find(params[:id])
  end
 


  
  def page
  @posts=@user.posts.all
  @post=current_user.posts.new
  @events=@user.events.all
  @event=current_user.events.new
  @friended = Friendable.where( ' accepted = true and (from_id = ? OR to_id = ? ) ', current_user.id,  current_user.id)
  @active_friend_request_pending = Friendable.where(' accepted = false and from_id = ? and to_id = ? ', current_user.id,  @user.id)
  @passive_friend_request_pending = Friendable.where(' accepted = false and from_id = ? and to_id = ? ', @user.id, current_user.id)
  
 end    

 def search
  @query = params[:search]
  @users = User.search(params[:search]).records.where("confirmed_at is not null")
 end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def get_button
  end
  
  def chats
   @chats=Message.where("recipients = ?", current_user.id).group(:recipients)
  end
  
  def chat
    @message=Message.new
      if User.find_by(name: params[:name])
		@conversation_with=User.find_by(name: params[:name])
		@messages=Message.where("recipients=#{@conversation_with.id} and sender=#{current_user.id} OR recipients=#{current_user.id} and sender=#{@conversation_with.id}").order(:created_at)
        Message.where("recipients=? and sender=? and read_at is null", current_user.id, @conversation_with.id ).update_all(read_at: Time.now)
        cookies[:current_user_id] = current_user.id      
      end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:name]
        @user = User.find_by_name(params[:name])
      else
        @user = User.find(params[:id])
      end
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

  def check_for_unread_messages
    if user_signed_in?
		if (Message.where("recipients=? and read_at is null", current_user.id).count > 0)
			@unread_messages=Message.where("recipients=? and read_at is null", current_user.id).count
		end
    end
  end
  


end
