class Admin::FootersController < Admin::AdminController 
  #before_action :set_footer, only: [:show, :edit, :update, :destroy]
  before_action :set_footer, only: [:show, :edit, :destroy]

  # GET /footers
  # GET /footers.json
  def index
    @footers = Footer.all
  end

  # GET /footers/1
  # GET /footers/1.json
  def show
  end

  # GET /footers/new
  def new
    @footer = Footer.new
  end

  # POST /footers
  # POST /footers.json
  def create
    @footer = Footer.new(footer_params)

    respond_to do |format|
      if @footer.save
        format.html { redirect_to admin_footer_path(@footer.id), notice: 'Footer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @footer }
      else
        format.html { render action: 'new' }
        format.json { render json: @footer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /footers/1
  # DELETE /footers/1.json
  def destroy
    @footer.destroy
    respond_to do |format|
      format.html { redirect_to admin_footers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footer
      @footer = Footer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def footer_params
      params.require(:footer).permit(:image)
    end
end
