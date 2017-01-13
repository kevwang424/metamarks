class BookmarksController < ApplicationController
  before_action :authenticate_user
  before_action :set_bookmark, only: [:edit, :update, :show, :destroy]

  def index
    @bookmarks = current_user.bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def generate_suggested_tags
    if params[:bookmark][:url].blank?
      redirect_to new_bookmark_path
    else
      @bookmark = Bookmark.new(bookmark_params)
      generate_tags
      collect_meta_data
    end
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    if @bookmark.save
      redirect_to bookmark_path(@bookmark)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to bookmark_path(@bookmark)
    else
      render 'edit'
    end
  end

  def show
    @bookmark = Bookmark.where(id: params[:id]).where(user_id: current_user.id).first
  end

  def destroy
    BookmarkTag.where(bookmark_id: @bookmark.id).each { |bookmarktag| bookmarktag.destroy }
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  private
  def set_bookmark
    @bookmark = Bookmark.where(id: params[:id]).where(user_id: current_user.id).first
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :user_id, :all_tags, :title, :notes, :description, :image_url)
  end

  def generate_tags
     @bookmark.suggested_tags = TagSuggester.new(@bookmark.url)
  end

  def collect_meta_data
    meta_data = LinkThumbnailer.generate(@bookmark.url, redirect_limit: 25)
    @bookmark.title = meta_data.title
    @bookmark.description = meta_data.description
    @bookmark.image_url = meta_data.images.first.src.to_s unless meta_data.images.blank?
  end
end
