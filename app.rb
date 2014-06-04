# myapp.rb
require ::File.expand_path('../config/application',__FILE__)
Bundler.require(:default)
require ::File.expand_path('../models/movie',__FILE__)

get '/' do
  @movie = Movie.find_by(title: params[:search].split(" ").collect {|w| w.capitalize}.join(" "))
  unless @movie.nil?
    jbuilder :index
  else
    erb :index
  end
end
