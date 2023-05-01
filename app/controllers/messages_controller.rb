class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ new edit create update destroy]
  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
    @message = Message.find(params[:id])
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  
  def create
    @message = Message.new(message_params)
    
  
    # Assign the body parameter to the message instance.
    body = message_params[:body]
    subject = message_params[:subject]
    from = message_params[:from]
    to = message_params[:to]
    
    # Encrypt the attributes
    #32-byte key for AES-256-CBC:9683934a8150811a4758c69303097101
    encryptor = BodyEncryptor.new('9683934a8150811a4758c69303097101')
    @message.encrypted_body = encryptor.encrypt(@message.body)
    @message.encrypted_subject = encryptor.encrypt(@message.subject)
    @message.encrypted_from = encryptor.encrypt(@message.from)
    @message.encrypted_to = encryptor.encrypt(@message.to)
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  



  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:from, :to, :subject, :body)
    end
end
