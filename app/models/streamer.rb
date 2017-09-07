class Streamer
  include ActionView::Helpers::NumberHelper

  attr_reader :stream_name,
              :channel_name,
              :name,
              :profile_pic,
              :banner_picture,
              :banner_color,
              :followers,
              :game_name,
              :watching_now,
              :total_views

  def initialize(channel_name)
    @twitch_service = TwitchService.new
    @channel_name   = channel_name
    @stream_name    = ""
    @name           = ""
    @profile_pic    = ""
    @banner_picture = ""
    @banner_color   = ""
    @followers      = ""
    @game_name      = ""
    @watching_now   = ""
    @total_views    = ""
    compile_stream_page
  end

  def compile_stream_page
    response = @twitch_service.stream_for_channel(channel_name)
    @stream_name    = response[:stream][:channel][:status]
    @name           = response[:stream][:channel][:display_name]
    @profile_pic    = response[:stream][:channel][:logo]
    @banner_picture = response[:stream][:channel][:profile_banner]
    @banner_color   = response[:stream][:channel][:profile_banner_background_color]
    @followers      = num_cleaner(response[:stream][:channel][:followers])
    @game_name      = response[:stream][:game]
    @watching_now   = num_cleaner(response[:stream][:viewers])
    @total_views    = num_cleaner(response[:stream][:channel][:views])
  end

  private
    attr_reader :user_token

    def num_cleaner(number)
      number_with_delimiter(number, :delimiter => ',')
    end
end
