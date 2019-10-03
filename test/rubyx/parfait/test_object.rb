require_relative "../helper"

module RubyX

  class TestObjectCompile < MiniTest::Test
    include ParfaitHelper
    include Preloader

    def source
      load_parfait(:object)
    end
    def test_load
      assert source.include?("class Object")
      assert source.length > 2000
    end
    def test_vool
      vool = compiler.ruby_to_vool source
      assert_equal Vool::ClassExpression , vool.class
      assert_equal :Object , vool.name
    end
    def test_slot
      slot = compiler.ruby_to_slot source
      assert_equal SlotMachine::SlotCollection , slot.class
    end
    def test_risc
      risc = compiler.ruby_to_risc( get_preload("Space.main") + source)
      assert_equal Risc::RiscCollection , risc.class
    end
    def test_binary
      risc = compiler.ruby_to_binary( get_preload("Space.main") + source , :interpreter)
      assert_equal Risc::Linker , risc.class
    end
  end
end
