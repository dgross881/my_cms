class SubjectsController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new ({:name => "Default"})
    @subject_count = Subject.count + 1
  end
  
  def create
    @subject = Subject.new(subject_params) 
    # Save the object
   if @subject.save 
    # if save succeds, redirect to the indext action
    flash[:notice] = "Subject Created Successfuly"
    redirect_to(:action => 'index')
   else
    # If save fails, redisplay the for so user can fix problems
    @subject_count = Subject.count + 1
    render('new')
   end 
  end 

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count 
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params) 
    # Save the object 
    # if save succeds, redirect to the indext action
    flash[:notice] = "Subject Updated Successfuly"
    redirect_to(:action => 'show', :id => @subject.id)
    else
    # If save fails, redisplay the for so user can fix problems
    @subject_count = Subject.count 
    render('edit')
   end 
  end

  def delete
   @subject = Subject.find(params[:id])
  end
  
  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' Destroyed Successfuly"
    redirect_to(:action => 'index')
  end 
 
 private 

  def subject_params
    # same as usine "params[:subject]", ecept that it:
    # -raises an error if :subject is not present
    # -allows listed attributes to be mass-assigned
    params.require(:subject).permit(:name, :position, :visible)
  end 
end
