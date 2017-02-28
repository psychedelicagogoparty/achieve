#書き始めは以下のおまじない
ready = ->
  $(window).scroll ->
     #変数の定義
    element = $('#page-top-btn') #ボタンの定義(引数はid名)
    visible = element.is(':visible')  #表示　非表示はhidden
    element_blog = $('#blog-page-top-btn') #ブログ投稿ページのボタンの定義(引数はid名)
    visible_blog = element_blog.is(':visible')  #ブログ投稿ページ　表示　非表示はhidden
    height = $(window).scrollTop() #トップページの一番上からのスクロールした量
    
    # ページの一番上から400px以上離れたらある処理を行いそれ以外だったら違う処理
    if height > 400
      element.fadeIn() if !visible #ボタンを表示する(発生条件：visibleではない時)
    else
      element.fadeOut() #ボタンを表示させない
      
    if height > 200
      element_blog.fadeIn() if !visible_blog #ボタンを表示する(発生条件：visibleではない時)
    else
      element_blog.fadeOut() #ボタンを表示させない
     
     
  $(document).on 'click', '#move-page-top', -> #function move-page-top {}と同義
    $('html, body').animate({ scrollTop: 0 }, 'slow')

#coffee scriptのおまじない 
$(document).ready(ready)
$(document).on('page:load', ready)