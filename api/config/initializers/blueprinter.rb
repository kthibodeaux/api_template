# frozen_string_literal: true

Blueprinter.configure do |config|
  config.if = lambda do |field_name, object, options|
    return true if options.fetch(:skip_authorization, false)

    key = object.object_id
    method_name = :"blueprint_authorize_#{field_name}?"

    @pundit_policies ||= {}
    @pundit_policies[key] ||= Pundit.policy!(Current.user, object)

    unless @pundit_policies[key].respond_to?(method_name)
      raise "blueprint_authorize missing for :#{field_name} in #{@pundit_policies[key].class}"
    end

    @pundit_policies[key].public_send(method_name)
  end
end
