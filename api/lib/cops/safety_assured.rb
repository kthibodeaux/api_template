# frozen_string_literal: true

class SafetyAssured < RuboCop::Cop::Base
  MESSAGE = '`safety_assured` is a smell and could cause outages if used incorrectly. Do not deprecate and remove columns in the same release. If this line of code is added because of a warning during migrations, you should probably remove this line.'

  def on_send(node)
    return unless migration?

    _, method_name, = *node
    return unless method_name == :safety_assured

    add_offense(node, message: MESSAGE)
  end

  private

  def migration?
    processed_source.buffer.name.include?('db/migrate/')
  end
end
