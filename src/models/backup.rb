# frozen_string_literal: true

require 'time'

Backup = Struct.new(:id, :created_at, :status, :backup_size, :database, keyword_init: true) do
  def outdated?
    Time.strptime(created_at, '%F %T %z') < Time.now - 2_592_000
  end
end
