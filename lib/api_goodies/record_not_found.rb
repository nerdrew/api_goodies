module APIGoodies
  class RecordNotFound < ActiveRecord::RecordNotFound
    attr_reader :klass, :attribute, :value

    def initialize(message, klass, finder = {})
      @klass = klass
      raise ArgumentError.new("only one finder pair allowed: #{finder.inspect}") if finder.size > 1
      key = finder.keys.first
      raise ArgumentError.new("finder key must respond to to_sym: #{key}") unless key.respond_to?(:to_sym)
      @attribute = key.to_sym
      @value = finder.values.first
    end
  end
end
