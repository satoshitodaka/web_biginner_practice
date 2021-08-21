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
  body = "<html><head><meta charset='utf-8'></head><body>クエリパラメータは#{data}です。<br>こんにちは#{data['username']}さん。あなたの年齢は#{data['age']}歳ですね。</body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc('/form_post') do | req, res|
  data = req.query
  body = "<html><head><meta charset='utf-8'></head><body>クエリパラメータは#{data}です。<br>こんにちは#{data['username']}さん。あなたの年齢は#{data['age']}歳ですね。</body></html>"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.start
