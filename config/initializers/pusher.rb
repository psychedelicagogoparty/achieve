# railsアプリケーションをpusherアカウントに接続できるようにするファイル
require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["PUSHER_KEY"]
Pusher.secret = ENV["PUSHER_SECRET"]
# Pusher.app_id = '330294'
# Pusher.key = 'a8ee3669aa5ed9345239'
# Pusher.secret = 'e2a345858f812285f911'
Pusher.logger = Rails.logger
Pusher.encrypted = true
