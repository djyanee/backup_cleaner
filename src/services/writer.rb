# frozen_string_literal: true

require 'csv'
require './src/models/response_message'

class Writer
  def initialize(response_messages:)
    @response_messages = response_messages
  end

  def call
    File.write('cleanup_log.txt', output)
  end

  private

  attr_reader :response_messages

  def output
    CSV.generate(col_sep: '  ', quote_char: '') do |csv|
      response_messages.each do |response_message|
        csv << response_message.deconstruct
      end
    end
  end
end
