require "test_helper"

class InhelintTest < Minitest::Test
  class AlreadyInherited
    include Inhelint::Lint.new
    def self.inherited(_subclass)
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::Inhelint::VERSION
  end

  def test_it_checks_two_level_inheritance_without_level_arg
    c1 = Class.new
    c1.include Inhelint::Lint.new
    c2 = Class.new(c1)
    assert_raises(Inhelint::Error) { Class.new(c2) }
  end

  def test_it_checks_arbitrary_level_inheritance_with_level_arg
    c1 = Class.new
    c1.include Inhelint::Lint.new(level: 3)
    c2 = Class.new(c1)
    c3 = Class.new(c2)
    assert_raises(Inhelint::Error) { Class.new(c3) }
  end

  def test_it_checks_module_too_with_include_module_option
    skip 'Will implement in the future'
    c1 = Class.new
    c1.include Inhelint::Lint.new(include_module: true)
    c2 = Class.new(c1)
    assert_raises(Inhelint::Error) { c2.include(Module.new) }
  end

  def test_it_works_with_inherited_defined_class
    skip 'Dealing with this case complicates code'
    c2 = Class.new(AlreadyInherited)
    assert_raises(Inhelint::Error) { Class.new(c2) }
  end
end
