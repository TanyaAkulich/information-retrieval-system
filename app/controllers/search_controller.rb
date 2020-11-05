class SearchController < ApplicationController
  def index; end
  def upload_file
    UploadedFile.create(params.require(:upload)[:datafile].tempfile)
  end
end
