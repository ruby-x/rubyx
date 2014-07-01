require_relative "virtual_helper"

class TestBasic < MiniTest::Test
  # include the magic (setup and parse -> test method translation), see there
  include VirtualHelper

  def test_number
    @string_input    = '42 '
    @output = [Virtual::IntegerConstant.new(42)]
    check
  end

  def test_true
    @string_input    = 'true '
    @output = [Virtual::TrueValue.new()]
    check
  end
  def test_false
    @string_input    = 'false '
    @output = [Virtual::FalseValue.new()]
    check
  end
  def test_nil
    @string_input    = 'nil '
    @output = [Virtual::NilValue.new()]
    check
  end

  def test_name
    @string_input    = 'foo '
    @output = [nil]
    check
  end

  def test_instance_variable
    @string_input    = '@foo_bar '
    @parse_output = {:instance_variable=>{:name=>"foo_bar"}}
    @output = Ast::VariableExpression.new(:foo_bar)
    check
  end

  def test_module_name
    @string_input    = 'FooBar '
    @parse_output = {:module_name=>"FooBar"}
    @output = Ast::ModuleName.new("FooBar")
    check
  end

  def test_comment
    out = "# i am a comment \n"
    @string_input    =  out.dup #NEEDS the return, which is what delimits the comment
    @parse_output = out
    @output = @parse_output #dont transform
    check
  end

  def test_string
    @string_input    = "\"hello\""
    @parse_output =  {:string=>[{:char=>"h"}, {:char=>"e"}, {:char=>"l"}, {:char=>"l"}, {:char=>"o"}]}
    @output =  Ast::StringExpression.new('hello')
    check
  end

end