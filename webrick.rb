 # webrick.rb
require 'webrick'
require 'webrick/cgi'

server = WEBrick::HTTPServer.new({ 
  :DocumentRoot => './',
  :BindAddress => '127.0.0.1',
  :Port => 8000
})

server.mount_proc('/time') do |req, res|
  # レスポンス内容を出力
  body = "<html><body>#{Time.now}</body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc('/form_get') do |req, res|
  data = req.query
  name = req.query['user_name']
  age = req.query['age']
  body = "<html><head><meta charset='utf-8'></head><body>\n"
  body += "クエリパラメータは#{data}です。<br>こんにちは#{name.force_encoding('utf-8')}さん。あなたの年齢は#{age.to_s}歳ですね。"
  body += "</body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc('/form_post') do | req, res|
  data = req.query
  name = req.query['user_name']
  age = req.query['age']
  body = "<html><head><meta charset='utf-8'></head><body>\n"
  body += "フォームデータは#{data}です。<br>こんにちは#{name.force_encoding('utf-8')}さん。あなたの年齢は#{age}歳ですね。"
  # to_sは使って何か変わるか？
  body += "</body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.start
