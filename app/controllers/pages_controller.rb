class PagesController < ApplicationController
  
  layout "admin" 

  before_action :confirm_logged_in 
  before_action :find_subject

  def index
    #@pages = Page.sorted.where(:subject_id => @subject.id).sorted 
    @pages = @subject.pages.sorted
  end
  
  def show
     @page = Page.find(params[:id])
  end
  
  def edit
     @page = Page.find(params[:id])
     @subjects = Subject.order('position ASC')
     @page_count = Page.count
  end

  def new 
     @page = Page.new ({:subject_id => @subject.id, :name => "Default"})
     @subjects = Subject.order('position ASC')
     @page_count = Page.count + 1 
  end 

  def create 
    @page = Page.new(page_params)
    if @page.save
     flash[:notice] = "Subject Created Successfuly"
     redirect_to(:action => "index", :subject_id => @subject.id)
    else 
      @subjects = Subject.order('position ASC')
     @page_count = Page.count + 1 
     render('new')
   end 
  end
  
  def update
    @page = Page.find(params[:id]) 
    if @page.update_attributes(page_params) 
    # Save the object 
    # if save succeds, redirect to the indext action
    flash[:notice] = "Page Updated Successfuly"
    redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
    # If save fails, redisplay the for so user can fix problems
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
    render('edit')
   end
  end 
   
  def delete
    @page = Page.find(params[:id])
  end 
  
  def destroy
    @page = Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed Successfuly" 
    redirect_to(:action => "index", :subject_id => @subject.id)
  end

private 

 def page_params
   params.require(:page).permit(:subject_id, :name, :permalink, :postion, :visible)
 end 

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end

end
