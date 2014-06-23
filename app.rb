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

get '/movies.?:format?' do
  unless params[:search].nil?
    headers "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/javascript"
    @movie = Movie.find_by("lower(title) == ?", params[:search].downcase)
    unless @movie.nil?
      params[:callback].nil? ? (@movie.to_json) : "#{params[:callback]}(#{@movie.to_json});"
    else
      params[:callback].nil? ? (jbuilder :error) : "#{params[:callback]}(#{jbuilder :error});"
    end
  else
    case params[:format]
      when 'json'
        headers "Access-Control-Allow-Origin" => "*",
                "Content-Type" => "application/javascript"
        Movie.all.collect {|m| m.title}.to_json
      else
        haml :movies, :layout => :main
    end
  end
end

get '/actors' do
  unless params[:random].nil?
    headers "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/javascript"
    unless params[:bacon].nil? or params[:bacon]=="true"
      actor = Actor.where.not(name: "Kevin Bacon").find(rand(Actor.count))
    else
      actor = Actor.find(rand(Actor.count))
    end
    return params[:callback].nil? ? (actor.to_json) : "#{params[:callback]}(#{actor.to_json});"
  end

  unless params[:search].nil?
    headers "Access-Control-Allow-Origin" => "*",
    "Content-Type" => "application/javascript"
    @actor = Actor.find_by("lower(name) == ?", params[:search].downcase) if @actor.nil?
    unless @actor.nil?
      params[:callback].nil? ? (@actor.to_json) : "#{params[:callback]}(#{@actor.to_json});"
    else
      params[:callback].nil? ? (jbuilder :error) : "#{params[:callback]}(#{jbuilder :error});"
    end
  else
    haml :actors, :layout => :main
  end
end
