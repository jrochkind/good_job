# typed: false

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `sorbet-coerce` gem.
# Please instead update this file by running `bin/tapioca gem sorbet-coerce`.

module TypeCoerce
  class << self
    def [](type); end
  end
end

class TypeCoerce::CoercionError < ::SafeType::CoercionError; end

module TypeCoerce::Configuration
  class << self
    sig { returns(T::Boolean) }
    def raise_coercion_error; end

    # @return [Boolean]
    def raise_coercion_error=(_arg0); end
  end
end

class TypeCoerce::Converter
  # @return [Converter] a new instance of Converter
  def initialize(type); end

  def from(args, raise_coercion_error: T.unsafe(nil)); end
  def new; end
  def to_s; end

  private

  def _build_args(args, type, raise_coercion_error); end
  def _convert(value, type, raise_coercion_error); end
  def _convert_enum(value, type, raise_coercion_error); end
  def _convert_simple(value, type, raise_coercion_error); end
  def _convert_to_a(ary, type, raise_coercion_error); end

  # @return [Boolean]
  def _nil_like?(value, type); end
end

TypeCoerce::Converter::PRIMITIVE_TYPES = T.let(T.unsafe(nil), Set)
class TypeCoerce::ShapeError < ::SafeType::CoercionError; end
