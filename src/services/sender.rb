# frozen_string_literal: true

require 'net/http'
require './src/models/backup'
require './src/models/response_message'

class Sender
  STATUSES = Hash.new('Error').merge({ '200' => 'Removed' })
  TIMEOUT_SECONDS = 15

  def initialize(backup:)
    @backup = backup
  end

  def call
    response_message(response.code, response.body)
  rescue Errno::EHOSTUNREACH => e
    response_message('500', e.message)
  end

  private

  attr_reader :backup

  def response
    @response ||= Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: TIMEOUT_SECONDS) do |http|
      http.request(request)
    end
  end

  def request
    Net::HTTP::Put.new(uri)
  end

  def uri
    @uri ||= URI("https://www.example.com/remove-backup?backup_id=#{backup.id}")
  end

  def response_message(code, body)
    ResponseMessage.new(
      id: backup.id,
      created_at: backup.created_at,
      status: STATUSES[code],
      code:,
      body: body.to_s.empty? ? '' : "\"#{body.gsub(/\n/, ' ')}\""
    )
  end
end
