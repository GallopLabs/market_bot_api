require 'sinatra/base'

class MarketBotAPI < Sinatra::Base

  VERSION = '0.1.0'

  configure do
    set :dump_errors, false
    set :raise_errors, true
    set :show_exceptions, false
  end

  before do
    content_type :json
  end

  get '/version' do
    { success: true, version: VERSION }.to_json
  end

  # for a cluster demo
  get '/hostname' do
    { success: true, hostname: `hostname`.chomp }.to_json
  end

  get '/app/:id' do
    getApplication params[:id]

    {
      success: true,
      app: {
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
      }
    }.to_json
  end

  get '/developer/:id' do
    getDeveloper params[:id]

    {
      success: true,
      developer: {
        developer_id: @devID,
        apps:         @dev.results
      }
    }.to_json
  end

  get '/search/:query' do
    performSearch params[:query]

    {
      success: true,
      results: @search.results
    }.to_json
  end

  helpers do

    def getApplication(id)
      @appID ||= id
      throw ArgumentError unless @appID.match(/^\w+\.\w+\.\w+/)

      @app ||= MarketBot::Android::App.new(@appID).update
      throw ArgumentError unless @app.title
    rescue ArgumentError, NoMethodError
      halt 400, {
        'Content-Type' => 'application/json'
      }, {
        success: false,
        message: 'invalid application ID'
      }.to_json
    end

    def getDeveloper(id)
      @devID ||= id
      throw ArgumentError unless @devID.match(/^[\w\+-]+/)

      @dev ||= MarketBot::Android::Developer.new(@devID).update
      throw ArgumentError unless @dev.results.count > 0
    rescue ArgumentError, NoMethodError
      halt 400, {
        'Content-Type' => 'application/json'
      }, {
        success: false,
        message: 'invalid developer ID'
      }.to_json
    end

    def performSearch(query)
      @query ||= query
      throw ArgumentError if @query.nil?

      @search ||= MarketBot::Android::SearchQuery.new(@query).update
      throw ArgumentError unless @search.results.count > 0
    rescue ArgumentError, NoMethodError
      halt 400, {
        'Content-Type' => 'application/json'
      }, {
        success: false,
        message: 'invalid search query'
      }.to_json
    end

  end # helpers

end # class
