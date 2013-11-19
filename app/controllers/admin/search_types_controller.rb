class Admin::SearchTypesController < Admin::AdminController
  before_action :set_search_type, only: [:show, :edit, :update, :destroy]

  # GET /search_types
  # GET /search_types.json
  def index
    @search_types = SearchType.all
  end

  # GET /search_types/1
  # GET /search_types/1.json
  def show
  end

  # GET /search_types/new
  def new
    @search_type = SearchType.new
  end

  # GET /search_types/1/edit
  def edit
  end

  # POST /search_types
  # POST /search_types.json
  def create
    @search_type = SearchType.new(search_type_params)

    respond_to do |format|
      if @search_type.save
        format.html { redirect_to admin_search_type_path(@search_type), notice: 'SearchType was successfully created.' }
        format.json { render action: 'show', status: :created, location: @search_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @search_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /search_types/1
  # PATCH/PUT /search_types/1.json
  def update
    respond_to do |format|
      if @search_type.update(search_type_params)
        format.html { redirect_to admin_search_type_path(@search_type), notice: 'SearchType was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @search_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_types/1
  # DELETE /search_types/1.json
  def destroy
    @search_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_search_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search_type
      @search_type = SearchType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_type_params
      params.require(:search_type).permit(:name)
    end
end
