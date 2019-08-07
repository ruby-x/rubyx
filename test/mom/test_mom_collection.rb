require_relative "helper"

module Mom
  class TestMomCollection < MiniTest::Test
    include MomCompile

    def setup
      Parfait.boot!(Parfait.default_test_options)
      @comp = compile_mom( "class Test ; def main(); return 'Hi'; end; end;")
    end

    def test_class
      assert_equal MomCollection , @comp.class
    end
    def test_compilers
      assert_equal 1 , @comp.compilers.length
    end
    def test_boot_compilers
#      assert_equal 22 , @comp.boot_compilers.length
    end
    def test_compilers_bare
      assert_equal 0 , MomCollection.new.compilers.length
    end
    def test_returns_constants
      assert_equal Array , @comp.constants.class
    end
    def test_has_constant_before
      assert_equal  [] , @comp.constants
    end
    def test_has_constant_after
#needs translating
#      assert_equal  "Hi" , @comp.constants[0].to_string
    end
    def test_has_translate
#      assert @comp.translate(:interpreter)
    end
    def test_append_class
      assert_equal MomCollection,  (@comp.append @comp).class
    end
    def test_append_length
      assert_equal 2 ,  @comp.append(@comp).method_compilers.length
    end
  end
end
