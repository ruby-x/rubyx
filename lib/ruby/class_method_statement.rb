module Ruby
  class ClassMethodStatement < MethodStatement

    def to_vool
      Vool::ClassMethodExpression.new( @name , @args.dup , @body.to_vool)
    end

    def to_s(depth = 0)
      arg_str = @args.collect{|a| a.to_s}.join(', ')
      at_depth(depth , "def self.#{name}(#{arg_str})" , @body.to_s(depth + 1) , "end")
    end

  end
end
