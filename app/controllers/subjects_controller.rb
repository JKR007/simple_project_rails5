class SubjectsController < ApplicationController

  layout 'admin'
  before_action :confirm_logged_in
  before_action :set_subject_count, only: [:new, :create, :edit, :update]
  def index
    @subjects = Subject.sorted_by_position
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new :name => 'Default Subject'
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new subject_params
    # Save the Object
    if @subject.save
      # If save succeds, redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to subjects_path
    else
      # If save fails, redisplay the form so so user can fix problems
      render 'new'
    end
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def update
    # Find a new object using form parameters
    @subject = Subject.find params[:id]
    # Update the Object
    if @subject.update_attributes subject_params
      # If save succeds, redirect to the show action
      flash[:notice] = "Subject #{@subject.name} updated successfully."
      redirect_to subject_path @subject
    else
      # If save fails, redisplay the form so so user can fix problems
      render 'edit'
    end
  end

  def delete
    @subject = Subject.find params[:id]
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject.destroy
    flash[:notice] = "Subject #{@subject.name} - deleted successfully."
    redirect_to subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end
end
