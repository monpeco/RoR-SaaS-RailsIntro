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
    
      logger.debug "CONTROLLER - params[:ratings]: [#{params[:ratings]}]"
      logger.debug "CONTROLLER - params[:sort]: [#{params[:sort]}]"

    if params[:ratings] == nil 
      redirect_ratings = session[:ratings] != nil ? session[:ratings] : Movie.get_all_ratings.keys ;
      logger.debug "CONTROLLER - redirect_to"
      redirect_to movies_path(:ratings => redirect_ratings)
    end

     # redirect_sort = session[:sort] != nil ? session[:sort] : 'title'

 
    params[:ratings] ||= session[:ratings]
    params[:sort] ||= session[:sort]
    

    if params[:ratings] == nil
      @already_checked = Movie.get_all_ratings
    else

      @already_checked = Movie.get_selected_ratings(params[:ratings])
    end

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
