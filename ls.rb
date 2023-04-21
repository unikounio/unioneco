require "debug"

MAX_COLUMN = 3
DIRECTRY_PATH = ARGV[0].nil? ? '.' : ARGV[0]

# 1.引数で渡されたパスのファイルエントリ名を配列として取得（パスのデフォルト値はカレントディレクトリ）
# 2.並び変え
entries = Dir.entries(DIRECTRY_PATH).sort

# '.'と'..'と隠しファイルを消す
# -aオプションの場合はこの処理を省く
entries_normal = entries.reject{|entry| entry =~ /^\./}

# 1.列ごとに括って２次元配列にする
# 2.そのままだとEnumeraterオブジェクトなのでArrayにする
columns = entries_normal.each_slice((entries_normal.count.to_f / MAX_COLUMN).ceil).to_a # each_sliceの引数が表示するときの行の数になる

# 最大の要素数を求める
max_size = columns.map(&:size).max

# 各ブロックの要素数を揃える
columns.each do |column|
  column.concat([''] * (max_size - column.size)) # 足りない要素を' 'で埋める
end

rows = columns.transpose

rows.each do |row| # g行単位で繰り返し処理
  row.each do |entry| # エントリ単位で繰り返し処理
    moji0 = 0
    entry.each_char do |char| # エントリの文字ごとに繰り返し処理
      moji0 += char.bytesize - 2 if char.bytesize > 1
    end
    print entry.ljust(30 - moji0, ' ') # 第１引数で扱えるのは全半角を区別しない単純な文字数だが、moji0を引くことで半角文字数としてカウントできるようにしている
  end
  puts
end
