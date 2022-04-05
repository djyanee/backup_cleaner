# frozen_string_literal: true

ResponseMessage = Struct.new(:id, :created_at, :status, :code, :body, keyword_init: true)
