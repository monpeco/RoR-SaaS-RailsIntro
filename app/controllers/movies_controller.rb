class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end






  def index
    
    @all_ratings = Movie.get_all_ratings

    params[:ratings] ||= session[:ratings]
    params[:sort] ||= session[:sort]

    if params[:ratings] == nil
      @already_checked = Movie.get_all_ratings
    else
      logger.debug "CONTROLLER 2- params[:ratings]: [#{params[:ratings]}]"

      @already_checked = Movie.get_selected_ratings(params[:ratings])
    end
    
    #logger.debug "CONTROLLER - params: [#{params}]"
    #logger.debug "CONTROLLER - @already_checked: [#{@already_checked}]"

    @sort = params[:sort]
    @movies = Movie.sorting(params[:sort], @already_checked)
    
    session[:ratings] = params[:ratings]
    session[:sort] = params[:sort]

  end
  








  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
