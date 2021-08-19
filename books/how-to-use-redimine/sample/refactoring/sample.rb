# メソッド名の変更
def hoge(a)
  a.chars
end

hoge("遊戯王").join(' ★ ')

# メソッドの抽出

def greet_and_laugh
  greet
  laugh
end

def greet_hoge
  name = 'hoge'
  puts "Hello, my name is #{name}"
end

def greet_fuga
  name = 'fuga'
  puts "Hello, my name is #{name}"
end
