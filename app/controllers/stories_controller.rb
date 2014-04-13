class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :set_flash_params, only: [:show, :edit, :update, :create, :location_stories]


  # GET /stories
  # GET /stories.json
  def index
    @stories = current_user.stories
  end

  def location_stories
    puts flash[:long]
    puts flash[:lat]
    puts flash[:vicinity]
    puts flash[:storyname]

    # get route params
    lat = flash[:lat]
    long = flash[:long]
    @storyname = unescape flash[:storyname]
    @vicinity = unescape flash[:vicinity]

    #retrieve data from Model
    @stories = current_user.stories.where(:latitude => lat, :longitude => long);
    # @otherstories = Story.where(:latitude => @lat, :longitude => @long);
    @otherstories = Story.all

  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    puts "current user id: #{current_user.id}"
    puts "story user id: #{@story.user_id}"
    # unless current_user.id == @story.user_id
    #   flash[:notice] = "You may only view your own products."
    #   redirect_to root_path
    # end
  end

  # GET /stories/new
  def new
    puts flash[:long]
    puts flash[:lat]
    puts flash[:vicinity]
    puts flash[:storyname]

    @lat = flash[:lat]
    @long = flash[:long]
    @storyname = flash[:storyname]
    @vicinity = flash[:vicinity]

    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  def audio

  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    puts "params: #{story_params}"
    @story.user_id = current_user.id

    puts flash[:long]
    puts flash[:lat]
    puts flash[:vicinity]
    puts flash[:storyname]

    prev_location = "/location/#{@story.longitude}/#{@story.latitude}/#{escape @story.vicinity}/#{escape @story.storyname}"


# u.avatar = params[:file]
# u.avatar = File.open('somewhere')
# u.save!
# u.avatar.url # => '/url/to/file.png'
# u.avatar.current_path # => 'path/to/file.png'
# u.avatar.identifier # => 'file.png'

    respond_to  do |format|
      if @story.save
        format.html { redirect_to prev_location, notice: 'Story was successfully created.' }
        format.json { render action: 'show', status: :created, location: @story }
      else
        format.html { render action: 'new' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    puts flash[:lat]
    puts flash[:long]
    puts flash[:vicinity]
    puts flash[:storyname]
    if @story
      @story.destroy
    end
    respond_to do |format|
      # format.html { redirect_to root_path }

      format.html { redirect_to "/location/#{flash[:lat]}/#{flash[:long]}/#{escape flash[:vicinity]}/#{escape flash[:storyname]}",
                    notice: 'Story was successfully Deleted.'
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      begin
        @story = Story.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        @story = nil
      end
    end

    def set_flash_params
      flash[:vicinity] = params[:vicinity]
      flash[:storyname] = params[:storyname]
      flash[:lat] = params[:lat]
      flash[:long] = params[:long]
    end

    def escape item
      Rack::Utils.escape(item)
    end

    def unescape item
      Rack::Utils.unescape(item)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :storyfile,:storyfile_cache,:latitude, :longitude, :storyname, :vicinity)
    end
end
