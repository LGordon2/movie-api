# myapp.rb
require ::File.expand_path('../config/application',__FILE__)
Bundler.require(:default)
require ::File.expand_path('../models/movie',__FILE__)

get '/' do
  unless params[:search].nil?
    @movie = Movie.find_by(title: params[:search].split(" ").collect {|w| w.capitalize}.join(" "))
    jbuilder :index unless @movie.nil?
  else
    erb :index
  end
end
