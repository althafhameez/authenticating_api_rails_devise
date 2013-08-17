require 'grape'
module Api
  class Bookmarks < Grape::API



    ## Retrieving API Calls
    desc "Current Users Bookmarks"
    get :bookmarks, :rabl => "bookmarks" do
      authenticated?
      @bookmarks = current_user.bookmarks
    end

    desc "Current Users Buckets"
    get :buckets, :rabl => "buckets" do
      authenticated?
      @buckets = current_user.buckets
    end

    desc "Readability List"
    get :readlist, :rabl => "bookmarks" do
      authenticated?
      @bookmarks = current_user.bookmarks.where(:bucket_id =>  current_user.buckets.find_by_name("Read Later").id)
    end
    
    desc "Daily Reading List"
    get :dailylist, :rabl => "bookmarks" do
      authenticated?
      @bookmarks = current_user.bookmarks.where(:bucket_id => current_user.buckets.find_by_name("Daily").id)
    end

    desc "Tagged With"
    params do
      requires :tag, type: String
    end
    get :tagged, :rabl => "bookmarks" do
      authenticated?
      @bookmarks = current_user.bookmarks.tagged_with(params[:tag])
    end

    desc "Bucketed As"
    params do
      requires :bucket, type: String
    end
    get :bucketed, :rabl => "bookmarks" do
      authenticated?
      unless current_user.buckets.find_by_name(params[:bucket]).nil?
        @bookmarks = current_user.bookmarks.where(:bucket_id => current_user.buckets.find_by_name(params[:bucket]).id)
      end
    end


    ## Creating API Calls
    desc "Create new Bookmark"
    params do 
      requires :name, type: String
      requires :url, type: String
      requires :bucket, type: String
      optional :tag_list, type: String
    end
    post :bookmarks do 
      authenticated?
      @bookmark = current_user.bookmarks.build({
        name: params[:name],
        url: params[:url]
        })
      foundBucket = Bucket.find_by_name(params[:bucket])
      if foundBucket == nil
        @bookmark.bucket = Bucket.create(name: params[:bucket], user_id: current_user.id)
      else
        @bookmark.bucket = foundBucket
      end
      if params[:tag_list]
        current_user.tag(@bookmark, :with => params[:tag_list], :on => :tags)
      end
      @bookmark.save

    end
    desc "Create new Bucket"
    params do
      requires :name, type: String
      optional :description, type: String
    end
    post :bucket do
      authenticated?
      @bucket = current_user.bucket.build({
        name: params[:name],
        description: params[:description]
        })
    end

    ## Editing API Calls

    desc "Update Bookmark"
    params do 
      requires :id, type: Integer
      optional :name, type: String
      optional :url, type: String
      optional :bucket, type: String
      optional :tag_list, type: String
    end
    put :bookmarks do
      authenticated?
      @bookmark = current_user.bookmarks.find(params[:id])
      if params[:bucket]
        foundBucket = Bucket.find_by_name(params[:bucket])
        if foundBucket == nil
          @bookmark.bucket = Bucket.create(name: params[:bucket], user_id: current_user.id)
        else
          @bookmark.bucket = foundBucket
        end
      end
      if params[:name] 
        @bookmark.update_column(:name, params[:name] )
      end
      if params[:url] 
        @bookmark.update_column(:url, params[:url]) 
      end
      if params[:tag_list]
        current_user.tag(@bookmark, :with => params[:tag_list], :on => :tags)
      end
    end
    
    desc "Update Bucket"
    params do
      requires :id, type: Integer
      optional :name, type: String
      optional :description, type: String
    end
    put :bucket do
      authenticated?
      @bucket = current_user.buckets.find(params[:id])
      if params[:name]
        @bucket.update_column(:name, params[:name])
      end
      if params[:description]
        @bucket.update_column(:description, params[:description])
      end
    end

    ## Destroying API Calls

    desc "Deleting a Bookmark"
    params do
      requires :id, type: Integer
    end
    delete :bookmark do
      authenticated?
      Bookmark.find(params[:id]).destroy
    end

    desc "Deleting a Bucket"
    params do
      requires :id, type: Integer
    end
    delete :bucket do
      authenticated?
      Bucket.find(params[:id]).destroy
    end
  end
end

