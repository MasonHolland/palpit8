class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @streams = GameStream.new("vmgryl3yotuzd472lqye7m96nwhtyn", params[:id])
    @chatroom = Chatroom.find_by(topic: @game.name.parameterize)
    @message = Message.new
  end
end
