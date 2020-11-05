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
          name: @token.name
        }
      end
    end

    private

    def term_inverse_frequency
      UploadedFile.count / number_of_repeats_in_files
    end

    def number_of_repeats_in_files
      UploadedFile.all.each do |file|
        @number_of_repeats_in_files += 1 if File.read(file.file.path).match(@token.name)
      end

      @number_of_repeats_in_files
    end

    def weight_in_file(file)

      repats_in_file = File.read(file.file.path).scan(Regexp.new(@token.name + '\b')).size

      repats_in_file ? term_inverse_frequency / repats_in_file : 0
    end
  end
end
