class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
      new_actor = Actor.new
      
      new_actor.name = params.fetch("actor_name")
      new_actor.dob = params.fetch("actor_dob")
      new_actor.bio = params.fetch("actor_bio")
      new_actor.image = params.fetch("actor_image_url")
      new_actor.save

    redirect_to("/actors")
  end

  def delete
    actor_id = params.fetch("path_id")

    # pull the actor
    the_actor = Actor.where({ :id => actor_id }).first # relation of all actors with the path_id (should be just one) and pull the first one

    the_actor.delete
  
    redirect_to("/actors")
  end

  def update
    # find existing actor
    the_actor = Actor.where({ :id => params.fetch("path_id")}).first

    # update fields
    the_actor.name = params.fetch("actor_name")
    the_actor.dob = params.fetch("actor_dob")
    the_actor.bio = params.fetch("actor_bio")
    the_actor.image = params.fetch("actor_image_url")
    the_actor.save

    redirect_to("/actors/#{params.fetch("path_id")}")
  end
end
