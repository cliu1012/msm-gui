class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    new_director = Director.new

    new_director.name = params.fetch("director_name")
    new_director.dob = params.fetch("director_dob")
    new_director.bio = params.fetch("director_bio")
    new_director.image = params.fetch("director_image_url")
    new_director.save

    redirect_to("/directors")
  end

  def delete
    director_id = params.fetch("path_id")

    # find existing director
    the_director = Director.where({ :id => director_id}).first

    the_director.delete

    redirect_to("/directors")
  end

  def update
    # find existing director
    the_director = Director.where({ :id => params.fetch("path_id")}).first

    # update fields
    the_director.name = params.fetch("director_name")
    the_director.dob = params.fetch("director_dob")
    the_director.bio = params.fetch("director_bio")
    the_director.image = params.fetch("director_image_url")
    the_director.save

    redirect_to("/directors/#{params.fetch("path_id")}")
  end

end
