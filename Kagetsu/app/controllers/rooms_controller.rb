class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def show
    @room = Room.includes(:comments).find_by(id: params[:id])
    @comments = Comment.new

  end

  def create
    @rooms = Room.all
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = 'Chat room added!'
      redirect_to rooms_path
    else
      render 'new'
    end
  end

  private

  def room_params
    params.require(:room).permit(:title, :description)
  end
end