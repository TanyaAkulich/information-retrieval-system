class SearchController < ApplicationController
  def index; end

  def upload_file
    UploadedFile.create(file: params.require(:upload)[:datafile].tempfile)
  end

  def search_by_tocken
    Tokens::InitTokenService.build(params[:tocken]).call
  end
end
