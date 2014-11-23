require 'sinatra/base'

class MarketBotAPI < Sinatra::Base

  VERSION = '0.1.0'

  get '/' do
    content_type :json

    {
      app:     self.name,
      version: VERSION
    }.to_json
  end

  get '/app/:id' do
    content_type   :json
    getApplication params[:id]

    {
      market_id:          @appID,
      title:              @app.title,
      category:           @app.category,
      developer:          @app.developer,
      installs:           @app.installs,
      price:              @app.price,
      votes:              @app.votes,
      stars:              @app.stars,
      stars_distribution: @app.stars_distribution,
      updated:            @app.updated,
      content_rating:     @app.content_rating,
      icon_url:           @app.banner_icon_url,
      image_url:          @app.banner_image_url,
    }.to_json
  end

  get '/developer/:id' do
    content_type :json
    getDeveloper params[:id]

    {
      developer_id: @devID,
      apps:         @dev.results
    }.to_json
  end

  helpers do

    def getApplication(id)
      @appID ||= id
      throw ArgumentError unless @appID.match(/^\w+\.\w+\.\w+/)

      @app ||= MarketBot::Android::App.new(@appID).update
      throw ArgumentError unless @app.title
    rescue ArgumentError
      halt 500
    end

    def getDeveloper(id)
      @devID ||= id
      throw ArgumentError unless @devID.match(/^[\w ]+/)

      @dev ||= MarketBot::Android::Developer.new(@devID).update
      throw ArgumentError unless @dev.results.count > 0
    end

  end # helpers

end # class
