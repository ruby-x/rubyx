require_relative "helper"

module Vool
  class TestMethodCompiler < MiniTest::Test
    include CompilerHelper

    def setup
      Risc.machine.boot
    end

    def create_method
      VoolCompiler.compile in_Test("def meth; @ivar ;end")
      test = Parfait.object_space.get_class_by_name(:Test)
      test.get_method(:meth)
    end

    def test_method_has_source
      method = create_method
      assert_equal ScopeStatement ,  method.source.class
      assert_equal InstanceVariable ,  method.source.statements.first.class
    end

    def test_method_has_no_locals
      method = create_method
      assert_equal 1 , method.locals_type.instance_length
    end

    def test_method_has_no_args
      method = create_method
      assert_equal 1 , method.args_type.instance_length
    end

    def test_creates_method_in_class
      method = create_method
      assert method , "No method created"
      assert_equal Parfait::VoolMethod , method.class
    end


    def test_creates_method_statement_in_class
      clazz = VoolCompiler.compile in_Test("def meth; @ivar ;end")
      assert_equal MethodStatement , clazz.body.statements.first.class
    end

    def test_parfait_class_creation
      clazz = VoolCompiler.compile in_Test("def meth; @ivar ;end")
      assert_equal Parfait::Class , clazz.body.statements.first.clazz.class
    end

    def test_method_statement_has_class
      clazz = VoolCompiler.compile in_Test("def meth; @ivar ;end")
      assert clazz.body.statements.first.clazz
    end

    def test_method_statement_has_class_in_main
      clazz = VoolCompiler.compile as_main("def meth; @ivar ;end")
      assert clazz.body.statements.first.clazz
    end

    def test_method_has_one_local
      VoolCompiler.compile in_Test("def meth; local = 5 ;end")
      test = Parfait.object_space.get_class_by_name(:Test)
      method = test.get_method(:meth)
      assert_equal 2 , method.locals_type.instance_length
    end

  end
end