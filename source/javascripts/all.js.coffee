$ ->
  feed = new Instafeed
    get: "tagged"
    tagName: "leve1livro"
    limit: 28
    clientId: "2ae004387f59459bad55b05cc9511fbd"
    template: '<a href="{{link}}" target="_blank"><img src="{{image}}" width="80px"/></a>'

  feed.run()
  Grid.init()

  $('.collage').collagePlus()
  $('body').scrollspy({ target: '.list' })

  $('.slider-lazy').slick
    lazyLoad: 'ondemand'
    slidesToShow: 4
    slidesToScroll: 1
    responsive: [
      {
        breakpoint: 1024
        settings:
          slidesToShow: 3
          slidesToScroll: 3
          infinite: true
          dots: true
      }
      {
        breakpoint: 600
        settings:
          slidesToShow: 2
          slidesToScroll: 2
      }
      {
        breakpoint: 480
        settings:
          slidesToShow: 1
        slidesToScroll: 1
      }
    ]

  $(".tip").tooltip()

  $(".send-mail").on "click", (e) ->
    _self = $(@)
    form = $(".contact-form")
    _self.button("loading")
    e.preventDefault()
    $.ajax
      type: "POST"
      url: "http://boxmailer.herokuapp.com"
      data: form.serialize()
      cache: false
      error: (err) ->
        _self.button("reset")
        alert("O envio falhou, tente novamente mais tarde.")
      success: (data) ->
        _self.button("reset")
        form[0].reset()
        $("#contact-modal").modal("show")

  $(".section-nav a[href^=\"#\"]").on "click", (e) ->
    e.preventDefault()
    $(".section-nav a.current").removeClass("current")
    $(@).addClass("current")
    target = @hash
    $target = $(target)
    top = $target.offset().top
    top =  top - parseInt($(@).data("offset")) if $(@).data("offset")
    $("html, body").stop().animate
      scrollTop: top
    , 900, "swing"

  # MARK NAV CURRENT ON WINDOW SCROLL

  aChildren = $("nav.section-nav li").children() # find the a children of the list items
  aArray = [] # create the empty aArray
  i = 0

  while i < aChildren.length
    aChild = aChildren[i]
    ahref = $(aChild).attr("href")
    aArray.push ahref
    i++
  # this for loop fills the aArray with attribute href values
  $(window).scroll ->
    windowPos = $(window).scrollTop() # get the offset of the window from the top of page
    windowHeight = $(window).height() # get the height of the window
    docHeight = $(document).height()
    i = 0

    while i < aArray.length
      theID = aArray[i]
      link = $("a[href^='#{theID}']")
      divPos = $(theID).offset().top # get the offset of the div from the top of page
      divPos = divPos - parseInt(link.data("offset")) if link.data("offset")
      divHeight = $(theID).height() # get the height of the div in question
      if windowPos >= divPos and windowPos < (divPos + divHeight)
        $("a[href='" + theID + "']").addClass "current"
      else
        $("a[href='" + theID + "']").removeClass "current"
      i++
    if windowPos + windowHeight is docHeight
      unless $("nav li:last-child a").hasClass("current")
        navActiveCurrent = $(".current").attr("href")
        $("a[href='" + navActiveCurrent + "']").removeClass "current"
        $("nav li:last-child a").addClass "current"
    return

  return
