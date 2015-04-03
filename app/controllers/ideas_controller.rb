class IdeasController < ApplicationController
  # Each 'def' is an action, inside the ideas_controller. 
  # INDEX IS THE SAME A SHOW
  # CRUD ACTIONS HERE: Create = add, Read = show 
  def showAll
    # These are instance variables, which can be used in the views
    # This is how we display all the Idea(s) in the index view
  	@all_ideas = Idea.all.page(params[:page]).per(15)
  end
  def showAuthorIdea
    # GETS THE IDEAS FOR THE CURRENT USER
    @user_idea = Idea.where(:author => current_user.email).page(params[:page]).per(15)
    @new_idea = Idea.new
  end 

  def showIdea
    @idea = Idea.find(params[:id])
		@comments = @idea.comments.all
		@comment = @idea.comments.build
  end

  def newIdea
    @new_idea = Idea.new
  end

  def delete
    # http://stackoverflow.com/questions/18682914/passing-id-to-controller-through-link-to-in-railsner
    Idea.find(params[:user_id]).destroy
    redirect_to :action => 'showAuthorIdea'
  end

  def deleteLast
    # NEED TO CHANGE THIS TO DELETE ONLY WHERE IDEA IS USER
    Idea.last.delete
    # This will redirect the add action to the index action, which then routes to the index view.
    redirect_to :action => 'showAuthorIdea'
  end

  def add 
  	idea = Idea.create(:name => params[:idea][:name], :author => current_user.email, :description => params[:idea][:description], :picture =>params[:idea][:picture])
  	unless idea.valid?  
   		  flash[:error] = idea.errors.full_messages.join("<br>").html_safe
   	  else 
   		  flash[:success] = "Idea Added!"
    end  
    # This will redirect the add action to the index action, which then routes to the index view.
 		redirect_to :action => 'showAuthorIdea'
  end

  def update
  end

  def current_page(path)
    "active" if current_page?(path)
  end
end
