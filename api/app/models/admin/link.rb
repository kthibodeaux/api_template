# frozen_string_literal: true

class Admin::Link
  attr_reader :name, :url, :icon

  def initialize(name:, url:, icon:)
    @name = name
    @url = url
    @icon = icon
  end
end
