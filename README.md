##decorator

Nifty tool for decorating any onject with module.

```ruby
  require 'decorator'

  class Foo
    attr_accessor :name

    def initialize name
      @name = name
    end

    def some_method
      'Foo#some_method'
    end
  end

  module FooDecorator
    def another_method
      'FooDecorator#another_method'
    end

    def some_method
      "Decorated foo (#{super})"
    end
  end
```

Decorating instance of class
```ruby
  foo = Foo.new('Local variable')
  foo = foo.decorate(FooDecorator)
  puts foo.some_method_undecorated
  puts foo.some_method
  puts foo.name
```

```
  Foo#some_method
  Decorated foo (Foo#some_method)
  Local variable
```

Decorating class itself
```ruby
  foo = Foo.decorate(FooDecorator).new('Local variable')
  puts foo.some_method_undecorated
  puts foo.some_method
  puts foo.name
```

```
  Foo#some_method
  Decorated foo (Foo#some_method)
  Local variable
```

Undecorating
```ruby
  bar = foo.undecorate
  puts bar.some_method
  puts bar.name
```

```
  Local variable
  Foo#some_method
```

##Installation:

Add to your Gemfile:

	git "git://github.com/StrangeMood/toolbox.git" do
	  gem "decorator"
	end