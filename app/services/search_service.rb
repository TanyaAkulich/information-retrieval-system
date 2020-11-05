require "matrix"

class SearchService
  def self.build(token_name)
    new(token_name)
  end

  def initialize(token_name)
    @token_name = token_name
  end

  def call
    result = UploadedFile.pluck(:id).each_with_object({}) do |file_id, hash|
      hash[file_id] = similarity_measure(file_id)
    end

    sorted_ids = Hash[result.sort_by { |key, value| -value }].keys

    UploadedFile.where(id: sorted_ids)
  end

  private

  def query_vector(file_id)
    InitQueryService.build(file_id, @token_name).call
  end

  def document_vector(file_id)
    Vector.elements(Token.where(uploaded_file_id: file_id).pluck(:weight))
  end

  def similarity_measure(file_id)
    similarity_measure = (document_vector(file_id).inner_product(query_vector(file_id))) / (document_vector(file_id).norm * query_vector(file_id).norm)

    similarity_measure.nan? ? 0 : similarity_measure
  end
end
