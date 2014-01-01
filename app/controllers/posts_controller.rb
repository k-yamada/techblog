class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_tag_cloud, only: [:index, :tag, :show]

  # GET /posts
  # GET /posts.json
  def index
    if params["keyword"]
      key = params["keyword"]
      @posts = Post.where(:$or => [{:title => /#{key}/}, {:body => /#{key}/}])
    else
      @posts = Post.where()
    end
    @posts = @posts.order('created_at DESC').page params[:page]
    @posts
  end

  def tag
    @posts = Post.where_with_tag(params['tag']).order('created_at DESC').page params[:page]
    render :template => "posts/index"
  end

  def set_tag_cloud
    @tag_cloud = Post.all_tags_with_counts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    @post.page_id = @post._id
    respond_to do |format|
      if @post.save
        @post.tag(post_params[:tags], current_user)
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
    @post.delete_all_tags
    @post.tag(post_params[:tags], current_user)
    respond_to do |format|
      if @post.set(post_params)
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
    @post.delete_all_tags
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      if params["post"]["tags"].class == Array
        params["post"]["tags"] = params["post"]["tags"].join(',')
      end
      params.require(:post).permit(:title, :body, :tags)
    end
end
