# frozen_string_literal: true

require 'csv'

class Parser
  HEADERS = %i[id created_at status backup_size database].freeze

  def initialize(file_path:)
    @file_path = file_path
  end

  def call
    rows.map { |row| Backup.new(row.to_h) }
  end

  private

  attr_reader :file_path

  def rows
    CSV.read(file_path, col_sep: '  ', headers: HEADERS, skip_blanks: true)
  end
end
