require 'event/errors'

# Event notification library
module Event
  # Resolve name to Event name
  class NameResolver
    def initialize(default_namespace)
      @default_namespace = default_namespace
    end

    def transform(event_id)
      case event_id
      when Class
        event_id
      when String
        constantize(event_id)
      else
        constantize("#{@default_namespace}::#{camel_case(event_id)}")
      end
    rescue => e
      raise EventNameResolveError, %(Transforming "#{event_id}" into an event class failed: #{e.message}.\n\n#{e.backtrace.join("\n")})
    end

    private

    def camel_case(underscored_name)
      if RUBY_VERSION < '1.9.3'
        underscored_name.to_s.split('_').map { |word| word.upcase.chars.to_a[0] + word.chars.to_a[1..-1].join }.join
      else
        underscored_name.to_s.split('_').map { |word| word.upcase[0] + word[1..-1] }.join
      end
    end

    # Thanks ActiveSupport
    # (Only needed to support Ruby 1.9.3 and JRuby)
    def constantize(camel_cased_word)
      names = camel_cased_word.split('::')

      # Trigger a built-in NameError exception including the ill-formed constant in the message.
      Object.const_get(camel_cased_word) if names.empty?

      # Remove the first blank element in case of '::ClassName' notation.
      names.shift if names.size > 1 && names.first.empty?

      names.inject(Object) do |constant, name|
        if constant == Object
          constant.const_get(name)
        else
          candidate = constant.const_get(name)

          if RUBY_VERSION < '1.9.3'
            next candidate if constant.const_defined?(name)
          else
            next candidate if constant.const_defined?(name, false)
          end

          next candidate unless Object.const_defined?(name)

          # Go down the ancestors to check if it is owned directly. The check
          # stops when we reach Object or the end of ancestors tree.
          # rubocop:disable Style/EachWithObject
          constant = constant.ancestors.inject do |const, ancestor|
            break const    if ancestor == Object
            break ancestor if ancestor.const_defined?(name, false)
            const
          end
          # rubocop:enable Style/EachWithObject

          # owner is in Object, so raise
          constant.const_get(name, false)
        end
      end
    end
  end
end
