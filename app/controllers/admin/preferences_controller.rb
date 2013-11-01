class Admin::PreferencesController < Admin::AdminController

  def index
    @graph = Graph.first
    @graphs = Graph.validators.inject([]) { |r,i| r << i.options[:in] }.first
    @graphs = @graphs.inject([]) {|r,i| r << [i.gsub('_', ' ').capitalize, i] }
  end

  def show
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    @graph = Graph.first
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to admin_preferences_path(@graph), notice: 'Graph Setting edited.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def graph_params
    params.require(:graph).permit(:setting)
  end
end
