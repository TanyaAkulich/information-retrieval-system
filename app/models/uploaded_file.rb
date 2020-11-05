class UploadedFile < ApplicationRecord
  has_attached_file :file
  validates_attachment_content_type :file, content_type: %w[text/plain text/html text/xml]
end