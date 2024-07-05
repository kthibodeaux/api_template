# frozen_string_literal: true

module Admin
  class LinkBlueprint < Blueprinter::Base
    fields :name, :url, :icon
  end
end
