# app.rb
require ::File.expand_path('../config/application',__FILE__)
require 'open-uri'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

#config
configure do
  enable :sessions

  set :haml, layout_options: {views: 'views/layouts'}
  set :sessions, :domain => 'orasi.com'
end

get '/movies' do
  unless params[:search].nil?
    headers "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/javascript"
    @movie = Movie.find_by("lower(title) == ?", params[:search].downcase)
    unless @movie.nil?
      params[:callback].nil? ? (@movie.to_json) : "#{params[:callback]}(#{@movie.to_json});"
    else
      jbuilder :error
    end
  else
    haml :movies, :layout => :main
  end
end

get '/actors' do
  headers "Access-Control-Allow-Origin" => "*",
  "Content-Type" => "application/javascript"

  unless params[:random].nil?
    unless params[:bacon].nil? or params[:bacon]=="true"
      actor = Actor.where.not(name: "Kevin Bacon").find(rand(Actor.count))
    else
      actor = Actor.find(rand(Actor.count))
    end
    return params[:callback].nil? ? (actor.to_json) : "#{params[:callback]}(#{actor.to_json});"
  end

  unless params[:search].nil?
    @actor = Actor.find_by("lower(name) == ?", params[:search].downcase) if @actor.nil?
    unless @actor.nil?
      params[:callback].nil? ? (@actor.to_json) : "#{params[:callback]}(#{@actor.to_json});"
    else
      jbuilder :error
    end
  else
    haml :actors, :layout => :main
  end
end
