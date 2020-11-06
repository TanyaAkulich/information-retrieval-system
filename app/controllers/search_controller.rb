class SearchController < ApplicationController
  def index; end

  def upload_file
    UploadedFile.create(file: params.require(:upload)[:datafile].tempfile)
  end

  def search_by_tocken
    @tocken = params[:tocken]
    Tokens::InitTokenService.build(@tocken).call
    @top_search = SearchService.build(@tocken).call
  end
end
