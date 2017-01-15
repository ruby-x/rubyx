require_relative "helper"

class ToCodeTest < MiniTest::Test
  include AST::Sexp

  def check clazz
    tree = Vm.ast_to_code @statement
    assert_equal tree.class , Vm::Tree.const_get( clazz )
  end

  def test_field_access
    @statement = s(:field_access, s(:receiver, s(:name, :m)), s(:field, s(:name, :index)))
    check "FieldAccess"
  end
  def test_simple_while
    @statement = s(:while_statement, :false, s(:conditional,s(:int, 1)), s(:statements))
    check "WhileStatement"
  end
  def test_l_assignment
    @statement = s(:l_assignment, s(:name, :i), s(:int, 0))
    check "LocalAssignment"
  end
  def test_a_assignment
    @statement = s(:a_assignment, s(:name, :i), s(:int, 0))
    check "ArgAssignment"
  end
  def test_i_assignment
    @statement = s(:i_assignment, s(:name, :i), s(:int, 0))
    check "IvarAssignment"
  end
  def test_nil
    @statement = s(:nil)
    check "NilExpression"
  end
  def test_true
    @statement = s(:true)
    check "TrueExpression"
  end
  def test_false
    @statement = s(:false)
    check "FalseExpression"
  end
  def test_name
    @statement = s(:name,  :foo)
    check "NameExpression"
  end
  def test_class_name
    @statement =s(:class_name, :FooBar)
    check "ClassExpression"
  end
end
