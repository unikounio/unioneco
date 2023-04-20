require "debug"










# COLUMN = 3

# # 1.カレントディレクトリのファイルエントリ名を取得（配列）
# # 2.'.'と'..'を消す
# # 3.並び変え
# entries = Dir.entries('.').reject{|e| e == '.' || e == '..'}.sort

# # 1.列ごとに括って２次元配列にする
# # 2.そのままだとEnumeraterオブジェクトなのでArrayにする
# columns = entries.each_slice(entries.count / COLUMN + 1).to_a 

# columns[0].each_with_index do |column, i| # 最初の列の処理。インデックスで他の列も同期させる
  
#   column.each do |entry| # 列ごとの処理
#     print entry.nil? ? ' ' : entry.ljust(18, ' ')
#   end
  
# end
