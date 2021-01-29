require_relative "inhelint/version"

module Inhelint
  class Error < StandardError; end

  class Lint < Module
    def initialize(level: 2, handler: nil)
      super()
      @level = level
      @handler = handler
    end

    def included(base)
      level = @level
      handler = @handler || proc { raise Error, "Inheritance level too deep: #{level}" }
      inherited = proc do |klass|
        if klass.ancestors.count { |a| a.is_a?(Class) && a <= base } > level
          handler.call(klass)
        else
          klass.define_singleton_method(:inherited, inherited)
        end
      end
      inherited[base]
    end
    alias prepended included
  end

  Default = Lint.new.freeze # Shortcut
end
