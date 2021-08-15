# メソッドの移動
class Hoge
  def initialize(name)
    @name = name
  end

  def foo
    baz_var = 1
    puts = [1, 2, 3]
  end

  def bar
    if condition
      puts name
    end
  end
end

# コンテキストアクション
def hoge
  array.map(&:to_s)
end
