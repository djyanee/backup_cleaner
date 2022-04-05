# frozen_string_literal: true

require './src/services/parser'
require './src/services/sender'
require './src/services/writer'

backups = Parser.new(file_path: 'spec/fixtures/backups.txt').call

response_messages = backups.map { |backup| Sender.new(backup: backup).call if backup.outdated? }.compact

Writer.new(response_messages: response_messages).call
