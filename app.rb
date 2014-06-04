# app.rb
require ::File.expand_path('../config/application',__FILE__)

Bundler.require(:default)
require ::File.expand_path('../models/movie',__FILE__)

#config
configure do
  enable :sessions

  set :haml, layout_options: {views: 'views/layouts'}
  set :sessions, :domain => 'orasi.com'
end

get '/' do
  unless params[:search].nil?
    headers "Access-Control-Allow-Origin" => "*"
    @movie = Movie.find_by(title: params[:search].split(" ").collect {|w| w.capitalize}.join(" "))
    unless @movie.nil?
      params[:callback].nil? ? (jbuilder :index) : "#{params[:callback]}(#{jbuilder :index});"
    end
  else
    haml :index, :layout => :main
  end
end
