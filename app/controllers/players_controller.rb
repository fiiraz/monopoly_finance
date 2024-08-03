class PlayersController < ApplicationController
  before_action :set_player, only: %i[show edit update destroy transfer withdraw deposit]

  def index
    @players = Player.all
  end

  def show
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully destroyed.' }
    end
  end

  def transfer
    recipient = Player.find(params[:recipient_id])
    amount = params[:amount].to_i

    if @player.balance >= amount
      @player.update(balance: @player.balance - amount)
      recipient.update(balance: recipient.balance + amount)
      flash[:notice] = 'Transfer was successful.'
    else
      flash[:alert] = 'Insufficient balance.'
    end

    redirect_to @player
  end

  def withdraw
    amount = params[:amount].to_i

    if @player.balance >= amount
      @player.update(balance: @player.balance - amount)
      flash[:notice] = 'Withdrawal was successful.'
    else
      flash[:alert] = 'Insufficient balance.'
    end

    redirect_to @player
  end

  def deposit
    amount = params[:amount].to_i
    @player.update(balance: @player.balance + amount)
    flash[:notice] = 'Deposit was successful.'

    redirect_to @player
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :balance)
  end
end
