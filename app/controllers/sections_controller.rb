class SectionsController < ApplicationController

  layout 'admin'

  def index
    @sections = Section.newest_first
  end

  def show
    @section = Section.find params[:id]
  end

  def new
    @section = Section.new :name => "Default Section"
    @section_count = Section.count + 1
    @pages = Page.newest_first
  end

  def create
    @section = Section.new section_params
    if @section.save
      flash[:notice] = "The section - #{@section.name} has been created successfully."
      redirect_to sections_path
    else
      @section_count = Section.count + 1
      @pages = Page.newest_first
      render 'new'
    end
  end

  def edit
    @section = Section.find params[:id]
    @section_count = Section.count
    @pages = Page.newest_first
  end

  def update
    @section = Section.find params[:id]
    if @section.update_attributes section_params
      flash[:notice] = "The section - #{@section.name} has been updated successfully."
      redirect_to section_path @section
    else
      @section_count = Section.count
      @pages = Page.newest_first
      render 'edit'
    end
  end

  def delete
    @section = Section.find params[:id]
    @section.destroy
    flash[:notice] = "The section - #{@section.name} has been deleted successfully."
    redirect_to sections_path
  end

  private
  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
