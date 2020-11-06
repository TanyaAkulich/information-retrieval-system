class SearchController < ApplicationController
  def index; end

  def upload_file
    UploadedFile.create(
      file: params.require(:upload)[:datafile].tempfile,
      file_name: params.require(:upload)[:datafile].original_filename
    )
  end

  def search_by_tocken
    @tocken = params[:tocken]
    Tokens::InitTokenService.build(@tocken).call
    @top_search = SearchService.build(@tocken).call
  end
end
