module Tokens
  class ParamsService
    def self.build(token)
      new(token)
    end

    def initialize(token)
      @token = token
      @number_of_repeats_in_files = 0
    end

    def call
      UploadedFile.all.map do |file|
        {
          uploaded_file_id: file.id,
          weight: weight_in_file(file),
          name: @token.name,
          term_inverse_frequency: term_inverse_frequency
        }
      end
    end

    private

    def term_inverse_frequency
      UploadedFile.count / number_of_repeats_in_files.to_f
    end

    def number_of_repeats_in_files
      return @number_of_repeats_in_files unless @number_of_repeats_in_files.zero?

      UploadedFile.all.each do |file|
        @number_of_repeats_in_files += 1 if File.read(file.file.path).downcase.match(@token.name.downcase)
      end

      @number_of_repeats_in_files
    end

    def weight_in_file(file)
      repats_in_file = File.read(file.file.path).downcase.scan(Regexp.new(@token.name.downcase + '\b'))&.size || 0

      return repats_in_file if ::Token.count.zero?

      ((repats_in_file * Math.log(term_inverse_frequency)) / Math.sqrt(::Token.where(uploaded_file_id: file.id).pluck(:term_inverse_frequency).map { |t| t * t }.sum + term_inverse_frequency).to_f)
    end
  end
end
