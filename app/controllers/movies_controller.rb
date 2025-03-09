class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def insert
    new_movie = Movie.new

    new_movie.title = params.fetch("movie_title")
    new_movie.year = params.fetch("movie_year")
    new_movie.duration = params.fetch("movie_duration")
    new_movie.description = params.fetch("movie_desc")
    new_movie.image = params.fetch("movie_image_url")
    new_movie.director_id = params.fetch("movie_director_id")
    new_movie.save

    redirect_to("/movies")
  end

  def delete
    movie_id = params.fetch("path_id")

    # pull movie from database
    the_movie = Movie.where({ :id => movie_id}).first

    the_movie.delete

    redirect_to("/movies")
  end

  def update
    movie_id = params.fetch("path_id")
    
    # pull movie from database
    the_movie = Movie.where({ :id => movie_id}).first
    
    the_movie.title = params.fetch("movie_title")
    the_movie.year = params.fetch("movie_year")
    the_movie.duration = params.fetch("movie_duration")
    the_movie.description = params.fetch("movie_desc")
    the_movie.image = params.fetch("movie_image_url")
    the_movie.director_id = params.fetch("movie_director_id")
    the_movie.save

    redirect_to("/movies/#{movie_id}")
  end
end
