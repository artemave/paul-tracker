class TrackersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tracker, only: [:show, :edit, :update, :destroy, :track_movement]

  # GET /trackers
  # GET /trackers.json
  def index
    @trackers = current_user.trackers
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
  end

  # GET /trackers/new
  def new
    @tracker = Tracker.new
  end

  # GET /trackers/1/edit
  def edit
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker = current_user.trackers.build(tracker_params)

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to @tracker, notice: 'Tracker was successfully created.' }
        format.json { render :show, status: :created, location: @tracker }
      else
        format.html { render :new }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackers/1
  # PATCH/PUT /trackers/1.json
  def update
    respond_to do |format|
      if @tracker.update(tracker_params)
        format.html { redirect_to @tracker, notice: 'Tracker was successfully updated.' }
        format.json { render :show, status: :ok, location: @tracker }
      else
        format.html { render :edit }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackers/1
  # DELETE /trackers/1.json
  def destroy
    @tracker.destroy
    respond_to do |format|
      format.html { redirect_to trackers_url, notice: 'Tracker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def track_movement
    tracker_api = TrackerAPI.new(@tracker)
    tracker_api.track_movement

    redirect_to @tracker, notice: 'Request sent to tracker.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      @tracker = current_user.trackers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tracker_params
      params.require(:tracker).permit!
    end
end
