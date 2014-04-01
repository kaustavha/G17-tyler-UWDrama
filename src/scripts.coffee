$ ->
    dom = $('html, body')
    ww = $(window).width()
    
    # fades out the poster on scroll
    scrollAnim = ->    
        $(window).one "scroll", ->
            setTimeout ->
                $('.poster').fadeOut "medium"
                $('.title')
                    .css "position", "fixed"
                    .fadeIn "medium"
                dom.animate scrollTop: 0, 200
                $('.title').fadeIn "medium", ->
                    $('#firstInfo').fadeIn "medium", ->
                        $('.synopsis').fadeIn "medium"
            , 300
        return

    # click handler to show poster
    $('#poster').click (e) ->
        e.preventDefault()       
        $('.poster').fadeIn "fast"
        $('.title').fadeOut "fast"
        dom.scrollTop 0
        setTimeout -> 
                scrollAnim()                
        , 200
        return
            
   #  resizing for different window widths  todo: port to css      
    if ww < 1479
        $('.title').css "font-size", "180%"
    if ww < 900
        $('.title').css "font-size", "150%"
        $('#firstInfo').css "margin-top", "20%"
        $('.cast-holder').css "height", "900px"
        $('.right')
            .css "float", "center"
            .css "margin", "0px"
        $('.left')
            .css "float", "center"
            .css "margin", "0px"
    
    # bg to remove flickering effect due to dom loading before fadeIn exec    
    $('.bg').removeClass "before-dom-ready"
    dom.fadeIn "medium"
    # fixes lag due to background cover css rule in chrome        
    $.backstretch "./assets/boarding-gate.jpg"
    $('.poster img').fadeIn "medium"
    scrollAnim()
    return