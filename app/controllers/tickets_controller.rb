class TicketsController < ApplicationController
  before_action :check_logged_in, only: [:destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = current_user.tickets.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = current_user.tickets.new(ticket_params)
    @event = @ticket.event
    #@event.update(seats_taken:3)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @event, notice: 'Ticket was successfully created.' }
        format.json { render :event_details, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :event_details, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def check_logged_in
      authenticate_or_request_with_http_basic("Ads") do |username, password|
        username == "admin" && password == "admin"
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :seat_id_seq, :address, :price, :email_address, :phone, :event_id)
    end

    def correct_user
      @ticket = current_user.tickets.find_by(id: params[:id])
      redirect_to tickets_path, notice: "Nie jesteś uprawniony do edycji tego biletu" if @ticket.nil?
    end
end