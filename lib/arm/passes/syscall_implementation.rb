module Arm

  class SyscallImplementation
    CALLS_CODES = { :putstring => 4 , :exit => 0    }
    def run block
      block.codes.dup.each do |code|
        next unless code.is_a? Register::Syscall
        new_codes = []
        int_code = CALLS_CODES[code.name]
        raise "Not implemented syscall, #{code.name}" unless int_code
        send( code.name , int_code , new_codes )
        block.replace(code , new_codes )
      end
    end

    def putstring int_code , codes
      codes << ArmMachine.mov( :r1 ,  20 ) # String length, obvious TODO
      codes << ArmMachine.ldr( :r0 , Register::RegisterReference.message_reg, Virtual::SELF_INDEX)
      syscall(int_code , codes )
    end

    def exit int_code , codes
      syscall int_code , codes
    end

    private

    # syscall is always triggered by swi(0)
    # The actual code (ie the index of the kernel function) is in r7
    def syscall int_code , codes
      codes << ArmMachine.mov( :r7 ,  int_code )
      codes << ArmMachine.swi( 0 )
    end
  end

  Virtual.machine.add_pass "Arm::SyscallImplementation"
end
