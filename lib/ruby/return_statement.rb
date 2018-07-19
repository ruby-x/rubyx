module Ruby
  class ReturnStatement < Statement
    include Normalizer

    attr_reader :return_value

    def initialize(value)
      @return_value = value
    end

    def to_vool
      val , rest = *normalize_name(@return_value)
      me = ReturnStatement.new(val)
      return me unless rest
      rest << me
      rest
    end

    def to_s(depth = 0)
      at_depth(depth , "return #{@return_value.to_s}")
    end
  end
end