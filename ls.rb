# frozen_string_literal: true

require 'debug'

public

argument = ARGV[0].nil? ? '.' : ARGV[0]

if File.directory? argument
  entries = Dir.entries(argument).sort
elsif File.file? argument
  puts ARGV[0]
else
  puts "ls: \'#{ARGV[0]}\' にアクセスできません: そのようなファイルやディレクトリはありません"
end

exit unless File.directory? argument

# -aオプションの場合はこの処理を省く必要があるため、entriesとは別の変数として定義している
entries_normal = entries.reject { |entry| entry.start_with? '.' }

def each_slice_into_rows(max_columns)
  each_slice((length.to_f / max_columns).ceil)
end

columns = entries_normal.each_slice_into_rows(3).to_a

# 各ブロックの要素数を揃える
# 足りない要素を' 'で埋める
columns.each { |column| column.concat([''] * (columns.map(&:length).max - column.length)) }

def hankaku_ljust(width, padding = ' ')
  convert_hankaku = 0

  each_char do |char| # エントリの文字ごとに繰り返し処理
    convert_hankaku += char.bytesize - 2 if char.bytesize > 1
  end

  ljust(width - convert_hankaku, padding) # ljustの第１引数で扱えるのは全半角を区別しない単純な文字数だが、convert_hankakuを引くことで半角文字数としてカウントできるようにしている
end

columns.transpose.each do |row| # 行単位で繰り返し処理
  row.each do |entry| # エントリ単位で繰り返し処理
    print entry.hankaku_ljust(18)
  end

  puts
end
