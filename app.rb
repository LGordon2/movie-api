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
    @movie = Movie.find_by(title: params[:search].split(" ").collect {|w| w.capitalize}.join(" "))
    jbuilder :index unless @movie.nil?
  else
    haml :index, :layout => :main
  end
end
