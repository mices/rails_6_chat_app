class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'room_channel', msg_time: Time.now, recipients: @message.recipients, sender: @message.sender, sender_name: User.find(@message.sender).name, content: @message.content
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  def chats
   @chats=Message.where("recipients = ?", current_user.id).group(:sender)
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
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender, :recipients, :content, :read_at, :name)
    end
end
