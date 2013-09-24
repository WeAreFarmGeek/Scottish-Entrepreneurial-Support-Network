class Admin::HeadersController < Admin::AdminController 
  #before_action :set_header, only: [:show, :edit, :update, :destroy]
  before_action :set_header, only: [:show, :edit, :destroy]

  # GET /headers
  # GET /headers.json
  def index
    @headers = Header.all
  end

  # GET /headers/1
  # GET /headers/1.json
  def show
  end

  # GET /headers/new
  def new
    @header = Header.new
  end

  # POST /headers
  # POST /headers.json
  def create
    @header = Header.new(header_params)

    respond_to do |format|
      if @header.save
        format.html { redirect_to admin_header_path(@header.id), notice: 'Header was successfully created.' }
        format.json { render action: 'show', status: :created, location: @header }
      else
        format.html { render action: 'new' }
        format.json { render json: @header.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headers/1
  # DELETE /headers/1.json
  def destroy
    @header.destroy
    respond_to do |format|
      format.html { redirect_to admin_headers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_header
      @header = Header.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def header_params
      params.require(:header).permit(:image, :title, :subtitle)
    end
end
