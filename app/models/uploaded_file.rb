class UploadedFile < ApplicationRecord
  has_attached_file :file

  validates_attachment_content_type :file, content_type: %w[text/plain text/html text/xml]

  after_commit :recalculate_all_tokens

  def recalculate_all_tokens
    Token.uniq_names.each do |token|
      params = Tokens::ParamsService.build(token).call
      params.each do |param|
        Token.find_or_initialize_by(uploaded_file_id: param[:uploaded_file_id]).update(param)
      end
    end
  end
end
