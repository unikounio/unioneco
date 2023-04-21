require "debug"

def argument
  ARGV[0].nil? ? '.' : ARGV[0]
end

if File.directory?(argument)
  entries = Dir.entries(argument).sort
else
  puts ARGV[0] 
  exit
end

# -aオプションの場合はこの処理を省く必要があるため、entriesとは別の変数として定義している
entries_normal = entries.reject{|entry|entry.start_with? '.'}

MAX_COLUMN = 3 # 1度しか使わないが最大列数の変更に対応しやすいように定数としている
columns = entries_normal.each_slice((entries_normal.count.to_f / MAX_COLUMN).ceil).to_a

# 各ブロックの要素数を揃える
# 足りない要素を' 'で埋める
columns.each { |column| column.concat([''] * (columns.map(&:size).max - column.size)) }

columns.transpose.each do |row| # 行単位で繰り返し処理
  row.each do |entry| # エントリ単位で繰り返し処理
    moji0 = 0
    entry.each_char do |char| # エントリの文字ごとに繰り返し処理
      moji0 += char.bytesize - 2 if char.bytesize > 1
    end
    print entry.ljust(30 - moji0, ' ') # 第１引数で扱えるのは全半角を区別しない単純な文字数だが、moji0を引くことで半角文字数としてカウントできるようにしている
  end
  puts
end
