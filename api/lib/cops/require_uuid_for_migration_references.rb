# frozen_string_literal: true

class RequireUuidForMigrationReferences < RuboCop::Cop::Base
  MESSAGE = 'Use `type: :uuid` for references in migrations.'

  def on_send(node)
    return unless migration?

    _, method_name, *arg_nodes = *node
    return unless method_name == :references

    arg_nodes.each do |arg_node|
      next unless arg_node.hash_type?

      arg_node.pairs.each do |pair_node|
        key, value = *pair_node

        next if key && key.sym_type? && key.value == :type && value && value.sym_type? && value.value == :uuid
      end
    end

    add_offense(node, message: MESSAGE)
  end

  private

  def migration?
    processed_source.buffer.name.include?('db/migrate/')
  end
end
