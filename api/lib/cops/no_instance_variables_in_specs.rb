# frozen_string_literal: true

class NoInstanceVariablesInSpecs < RuboCop::Cop::Base
  MESSAGE = 'Prefer `let` over instance variables in RSpec specs.'

  def on_ivar(*node)
    return unless spec?

    add_offense(node.first, message: MESSAGE)
  end

  def on_ivasgn(node)
    return unless spec?

    add_offense(node, message: MESSAGE)
  end

  private

  def spec?
    processed_source.buffer.name.include?('spec/')
  end
end
