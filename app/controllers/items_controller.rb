class ItemsController < ApplicationController
  before_filter :init_category
  before_filter :init_sub_category
  # GET /items
  # GET /items.json
  def index
    @items = @sub_category.items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @properties = @item.properties

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new(sub_category_id: @sub_category.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    @item.sub_category_id = @sub_category.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to [@category, @sub_category, @item], notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    item_params = params[:item].merge({sub_category_id: @sub_category.id})

    respond_to do |format|
      if @item.update_attributes(item_params)
        format.html { redirect_to category_sub_category_item_path(@category, @sub_category, @item), notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to category_sub_category_items_path(@category, @sub_category) }
      format.json { head :no_content }
    end
  end

  def new_property
    @item = Item.find(params[:id])
    @property = Property.new

    respond_to do |format|
      format.html { render 'new_property' }
      format.json { render json: @property }
    end
  end

  def create_property
    @item = Item.find(params[:id])
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        ItemProperty.create(item_id: @item.id, property_id: @property.id)
        format.html { redirect_to [@category, @sub_category, @item], notice: 'Property was successfully created.' }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: 'new_property' }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def init_category
    @category = Category.find(params[:category_id])
  end

  def init_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end
end
