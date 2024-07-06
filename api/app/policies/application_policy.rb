# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def self.blueprint_authorize(fields:, with:)
    auth_class_name = name.underscore.gsub(/\W/, '_')
    @authed_fields ||= []

    @next_method_id ||= 0
    memoized_result = "blueprint_authorize_memoization_#{auth_class_name}_#{@next_method_id += 1}"

    fields.each do |field|
      method_name = "blueprint_authorize_#{field}?"

      raise 'already defined' if @authed_fields.include?(field)

      case with
      when Symbol
        define_method method_name do
          if instance_variable_defined?("@#{memoized_result}")
            instance_variable_get("@#{memoized_result}")
          else
            instance_variable_set("@#{memoized_result}", send(with))
          end
        end
      when Proc
        define_method method_name do
          if instance_variable_defined?("@#{memoized_result}")
            instance_variable_get("@#{memoized_result}")
          else
            instance_variable_set("@#{memoized_result}", instance_exec(&with))
          end
        end
      else
        raise 'with must be symbol or lambda'
      end

      @authed_fields << field
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
