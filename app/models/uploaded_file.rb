class UploadedFile < ApplicationRecord
  has_attached_file :file

  validates_attachment_content_type :file, content_type: %w[text/plain text/html text/xml]

  after_create :recalculate_all_tokens

  def recalculate_all_tokens
    Token.uniq_names.each do |token|
      parameters = token.create_or_update(ParamsService.build(token).call)

      parameters.each { |parameter| Token.find_by(uploaded_file_id: parameter[:uploaded_file_id]).update(parameter) }
    end
  end
end
