class SubCategoriesController < ApplicationController
  # GET /sub_categories
  # GET /sub_categories.json
  before_filter :init_category
  before_filter :init_parent_sub_category, only: [:new_child, :create_child]

  def index
    @sub_categories = SubCategory.where(category_id: @category.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_categories }
    end
  end

  # GET /sub_categories/1
  # GET /sub_categories/1.json
  def show
    @sub_category = SubCategory.find(params[:id])
    @child_categories = @sub_category.children

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_category }
    end
  end

  # GET /sub_categories/new
  # GET /sub_categories/new.json
  def new
    @sub_category = SubCategory.new
    @sub_category.category_id = @category.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_category }
    end
  end

  # GET /sub_categories/1/edit
  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  # POST /sub_categories
  # POST /sub_categories.json
  def create
    @sub_category = SubCategory.new(params[:sub_category])
    @sub_category.category_id = @category.id

    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to [@category, @sub_category], notice: 'Sub category was successfully created.' }
        format.json { render json: @sub_category, status: :created, location: @sub_category }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_categories/1
  # PUT /sub_categories/1.json
  def update
    @sub_category = SubCategory.find(params[:id])

    respond_to do |format|
      if @sub_category.update_attributes(params[:sub_category])
        format.html { redirect_to [@category, @sub_category], notice: 'Sub category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.json
  def destroy
    @sub_category = SubCategory.find(params[:id])
    @sub_category.destroy

    respond_to do |format|
      format.html { redirect_to category_sub_categories_url(@category) }
      format.json { head :no_content }
    end
  end

  def new_child
    @sub_category = SubCategory.new
    @sub_category.category_id = @category.id
    @sub_category.parent_id = @parent_sub_category.id

    respond_to do |format|
      format.html { render 'new' }
      format.json { render json: @sub_category }
    end
  end

  def create_child
    @sub_category = SubCategory.new(params[:sub_category])
    @sub_category.category_id = @category.id
    @sub_category.parent_id = @parent_sub_category.id

    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to [@category, @sub_category], notice: 'Sub category was successfully created.' }
        format.json { render json: @sub_category, status: :created, location: @sub_category }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def init_category
    @category = Category.find(params[:category_id])
  end

  def init_parent_sub_category
    @parent_sub_category = SubCategory.find(params[:sub_category_id])
  end
end
