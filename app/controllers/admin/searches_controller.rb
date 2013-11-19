class Admin::SearchesController < Admin::AdminController
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  before_action :set_search_type

  # GET /searches
  # GET /searches.json
  def index
    @searches = @search_type.searches
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = @search_type.searches.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = @search_type.searches.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to admin_search_type_search_path(@search_type, @search), notice: 'Search was successfully created.' }
        format.json { render action: 'show', status: :created, location: @search }
      else
        format.html { render action: 'new' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to admin_search_type_search_path(@search_type, @search), notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to admin_search_type_searches_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = SearchType.find(params[:search_type_id]).searches.find(params[:id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_search_type
      @search_type = SearchType.find(params[:search_type_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:search)
    end
end
