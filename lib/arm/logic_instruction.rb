require_relative "instruction"
require_relative "logic_helper"

module Arm

  class LogicInstruction < Vm::LogicInstruction
    include Arm::Constants
    include LogicHelper

    def initialize(attributes)
      super(attributes)
      @update_status_flag = 0
      @condition_code = :al
      @opcode = attributes[:opcode]
      @args = [attributes[:left] , attributes[:right] , attributes[:extra]]
      @operand = 0

      @rn = nil
      @i = 0      
      @rd = @args[0]
    end
    attr_accessor :i, :rn, :rd
    # Build representation for source value 
    def build
      @rn = @args[1]
      do_build @args[2] 
    end
  end
end