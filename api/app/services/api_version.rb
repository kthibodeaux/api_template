# frozen_string_literal: true

module ApiVersion
  module_function

  def version
    # This is very basic and will not work if there is more than one server running puma.
    # We can cross that bridge when we get there
    @version ||= Time.zone.now.to_i.to_s
  end
end
