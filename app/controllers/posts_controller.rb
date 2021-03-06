class PostsController < ApplicationController
  #before_action :set_post_by_sub_id, only: [:show_by_sub_id]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_tag_cloud, only: [:index, :tag, :show, :new, :edit]

  # GET /posts
  # GET /posts.json
  def index
    if params["keyword"]
      @keywords = params["keyword"].split(" ")
      @posts = find_by_keywords(@keywords)
    else
      @posts = Post.order('created_at DESC').page params[:page]
    end
    @is_index = true
  end

  def route_not_found
    flash[:error] = "Route not found"
    redirect_to action: 'index'
  end

  def tag
    @posts = Post.tagged_with(params['tag']).order('created_at DESC').page params[:page]
    render :template => "posts/index"
  end

  def set_tag_cloud
    @tag_cloud = Post.tags_with_weight[0..20]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    session[:recent_shows] ||= []
    post_hash = {:title => @post.title, :id => @post.id.to_s}

    unless session[:recent_shows].include?(post_hash)
      session[:recent_shows].push(post_hash)
    end

    if session[:recent_shows].length > 3
      # 末尾3つを残す
      length = session[:recent_shows].length
      session[:recent_shows] = session[:recent_shows][length-3..-1]
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.sub_id = @post.default_sub_id
    respond_to do |format|
      if @post.save
        # @post.tag(post_params[:tags], current_user) if post_params[:tags]
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: nil }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    # @post.delete_all_tags
    # @post.tag(post_params[:tags], current_user) if post_params[:tags]
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    # @post.delete_all_tags
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if params[:sub_id]
        @post = Post.find_by(sub_id: params[:sub_id])
      else
        @post = Post.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      if params["post"]["tags"].class == Array
        params["post"]["tags"] = params["post"]["tags"].join(',')
      end
      params.require(:post).permit(:sub_id, :title, :body, :tags, :created_at, :updated_at)
    end

    def create_and_conds(target, keywords)
      and_conds = []
      keywords.each do |keyword|
        and_conds << {target => /#{keyword}/i}
      end
      and_conds
    end

    def find_by_keywords(keywords)
      search_cond = {:$or => [
        {:$and => create_and_conds(:title, keywords)},
        {:$and => create_and_conds(:body,  keywords)}
      ]}
      posts = Post.where(search_cond)
      posts.order('created_at DESC').page(params[:page]).per(100)
    end
end
