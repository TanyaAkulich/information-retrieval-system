class SearchController < ApplicationController
  def index; end

  def upload_file
    UploadedFile.create(
      file: params.require(:upload)[:datafile].tempfile,
      file_name: params.require(:upload)[:datafile].original_filename
    )
  end

  def search_by_token
    @token = params[:token]
    Tokens::InitTokenService.build(@token).call
    @top_search = SearchService.build(@token).call
  end

  def update_dictionary
    UpdateDictionaryService.build.call
  end
end
