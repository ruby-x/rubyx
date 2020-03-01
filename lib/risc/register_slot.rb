module Risc

  # A RegisterSlot is a description of a slot into an object in a register.
  #
  # In many ways, it is like a variable in programming it can be a value, or it
  # can be assigned a value. An l-value or r-value, and since we don't know at
  # the time they are created (because of the dsl nature) we delay.
  #
  # RegisterSlots are created trough the array operator on a register.
  # ie message[:caller], and this can either be further indexed, assigned
  # something or assigned to something. So we overload those operators here.
  #
  # Ultimately SlotToReg or RegToSlot instructions are created for the l-value
  # or r-vlalue respectively.

  class RegisterSlot
    attr_reader :register , :index , :builder

    def initialize(register, index , builder)
      @register , @index , @builder = register , index , builder
    end

    # fullfil the objects purpose by creating a RegToSlot instruction from
    # itself (the slot) and the register given
    def <<( reg )
      raise "not reg #{reg}" unless reg.is_a?(RegisterValue)
      reg_to_slot = Risc.reg_to_slot("#{reg.class_name} -> #{register.class_name}[#{index}]" , reg , register, index)
      builder.add_code(reg_to_slot) if builder
      reg_to_slot
    end

    # similar to above (<< which produces reg_to_slot), this produces reg_to_byte
    # from itself (the slot) and the register given
    def <=( reg )
      raise "not reg #{reg}" unless reg.is_a?(RegisterValue)
      reg_to_byte = Risc.reg_to_byte("#{reg.class_name} -> #{register.class_name}[#{index}]" , reg , register, index)
      builder.add_code(reg_to_byte) if builder
      reg_to_byte
    end

  end
end
