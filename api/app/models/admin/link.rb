# frozen_string_literal: true

module Admin
  class Link
    attr_reader :name, :url, :icon

    def initialize(name:, url:, icon:)
      @name = name
      @url = url
      @icon = icon
    end
  end
end
