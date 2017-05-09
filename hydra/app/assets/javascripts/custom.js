var facetfun = "";

// If JavaScript Enabled - Setup
$(document).ready(function() {
  $(".wvu-header .list").addClass("destroy"); 
  $(".wvrhc-header .list2").addClass("destroy");   
  $("#wvrhctoggle .fa-chevron-up").addClass("hiding"); 
  $("#wvutoggle .fa-chevron-up").addClass("hiding"); 
  $("#menu-toggle #menu-toggle2").addClass("hiding");
  $("#search-toggle #search-toggle2").addClass("hiding");
  $("#facet-toggle #filter-toggle2").addClass("hiding");  

   facetfun = $('#sidebar').html();
});

//Mobile Facet Move
$(window).bind("load resize", function() {

	$('#facets').remove();

	if( $(window).width() < 768) {
  		$('.sticky-header-filter-sidebar').html(facetfun);
	}
  	else { 
  		$('#sidebar').html(facetfun);
	} 
	$(".sticky-header-filter-sidebar #facets #facet-panel-collapse").removeClass("collapse");
});


// Mobile Facet Setup
$(document).ready(function() {

	var windowh = document.documentElement.clientHeight;
	var tabbar = $('.sticky-header').height();

	var fheight = windowh - tabbar;

    $('.sticky-header-filter-sidebar').css('max-height', fheight);   

});

// Mobile Facet Resize
$(window).resize(function(){

	var windowh = document.documentElement.clientHeight;
	var tabbar = $('.sticky-header').height();

	var fheight = windowh - tabbar;

    $('.sticky-header-filter-sidebar').css('max-height', fheight);   

});

// Mobile WVU Nav
$(function () {
	$("#wvutoggle").click(function(e) {		
		e.preventDefault(); 
		$(".list").slideToggle("fast");
		$("#wvutoggle .fa-chevron-up").toggleClass("hiding");
		$("#wvutoggle .fa-chevron-down").toggleClass("hiding");
	});
});

// Mobile WVRHC Nav
$(function () {
	$("#wvrhctoggle").click(function(e){
		e.preventDefault(); 		
		$(".list2").slideToggle("fast");
		$("#wvrhctoggle .fa-chevron-up").toggleClass("hiding");
		$("#wvrhctoggle .fa-chevron-down").toggleClass("hiding");
	});
});

// Tab Bar Navigation: Menu
$(function () {
	$("#menu-toggle").click(function(e) {
		e.preventDefault(); 		
		$("#sticky-header-nav-menu").toggleClass("tabbarToggle");
		$(".sticky-header-nav").toggleClass("tabbarBlue");
		$("#menu-toggle #menu-toggle1").toggleClass("hiding");
		$("#menu-toggle #menu-toggle2").toggleClass("hiding");

		$(".search-query-form").removeClass("tabbarToggle");
		$(".search-query-form").removeClass("tabbarToggleSearch");
		$(".sticky-header-search").removeClass("tabbarBlue");
		$("#search-toggle #search-toggle1").removeClass("hiding");
		$("#search-toggle #search-toggle2").addClass("hiding");	

		$(".sticky-header-filter-sidebar").removeClass("tabbarToggle2");
		$(".sticky-header-filter").removeClass("tabbarBlue");
		$("#facet-toggle #filter-toggle1").removeClass("hiding");
		$("#facet-toggle #filter-toggle2").addClass("hiding");	
	});
});

// Tab Bar Navigation: Search
$(function () {
	$("#search-toggle").click(function(e) {
		e.preventDefault(); 		
		$(".search-query-form").toggleClass("tabbarToggle");
		$(".search-query-form").toggleClass("tabbarToggleSearch");
		$(".sticky-header-search").toggleClass("tabbarBlue");
		$("#search-toggle #search-toggle1").toggleClass("hiding");
		$("#search-toggle #search-toggle2").toggleClass("hiding");

		$("#sticky-header-nav-menu").removeClass("tabbarToggle");
		$(".sticky-header-nav").removeClass("tabbarBlue");
		$("#menu-toggle #menu-toggle1").removeClass("hiding");
		$("#menu-toggle #menu-toggle2").addClass("hiding");

		$(".sticky-header-filter-sidebar").removeClass("tabbarToggle2");
		$(".sticky-header-filter").removeClass("tabbarBlue");
		$("#facet-toggle #filter-toggle1").removeClass("hiding");
		$("#facet-toggle #filter-toggle2").addClass("hiding");		
	});
});

// Tab Bar Navigation: Filter
$(function () {
	$("#facet-toggle").click(function(e) {		
		e.preventDefault(); 
		$(".sticky-header-filter-sidebar").toggleClass("tabbarToggle2");
		$(".sticky-header-filter-sidebar").toggleClass("tabbarToggleSearch");
		$(".sticky-header-filter").toggleClass("tabbarBlue");
		$("#facet-toggle #filter-toggle1").toggleClass("hiding");
		$("#facet-toggle #filter-toggle2").toggleClass("hiding");

		$("#sticky-header-nav-menu").removeClass("tabbarToggle");
		$(".sticky-header-nav").removeClass("tabbarBlue");
		$("#menu-toggle #menu-toggle1").removeClass("hiding");
		$("#menu-toggle #menu-toggle2").addClass("hiding");

		$(".search-query-form").removeClass("tabbarToggle");
		$(".search-query-form").removeClass("tabbarToggleSearch");
		$(".sticky-header-search").removeClass("tabbarBlue");
		$("#search-toggle #search-toggle1").removeClass("hiding");
		$("#search-toggle #search-toggle2").addClass("hiding");			
	});
});

// Smooth Scrolling for Anchors
$(function() {
  $('a[href*=\\#]:not([href=\\#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });
});

// Document Column Resizing 
equalheight = function(container){

	var currentTallest = 0,
	currentRowStart    = 0,
	rowDivs            = new Array(),
	$el,
	topPosition        = 0;

	$(container).each(function() {

		$el = $(this);
		$($el).height('auto')
		topPostion = $el.position().top;

		if (currentRowStart != topPostion) {
	
			for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) {
				rowDivs[currentDiv].height(currentTallest);
			}

			rowDivs.length  = 0; // empty the array
			currentRowStart = topPostion;
			currentTallest  = $el.height();
    		rowDivs.push($el);
    	} 
    	else {
    		rowDivs.push($el);
    		currentTallest = (currentTallest < $el.height()) ? ($el.height()) : (currentTallest);
    	}
    	for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) {
    		rowDivs[currentDiv].height(currentTallest);
    	}
    });

}

$(document).ready(function() {
  equalheight('.document');
});

$(window).load(function() {
  equalheight('.document');
});

$(window).resize(function(){
  equalheight('.document');
});

$(document).ready(function() {
  equalheight('.form-section');
});

$(window).load(function() {
  equalheight('.form-section');
});

$(window).resize(function(){
  equalheight('.form-section');
});

// Homepage Help Modal Cookie
$(function () {
  // set the cookie 
  var myCookie = "ModalShown"; 
  var cookieValue = getCookieValue(myCookie); 
  console.log(myCookie.length);
  
  if(cookieValue.length === 0){
    // $('#openModal').modal('show'); 
  } else { 
    $('#openModal').toggleClass("destroy");
  }
  
    $("#openModalbut").click(function () {            
      $("#openModal").toggleClass("destroy");
      document.cookie = "ModalShown=true; expires=Fri, 31 Dec 9999 23:59:59 GMT; path=/";
    });
 
});
function getCookieValue(a, b) {
    b = document.cookie.match('(^|;)\\s*' + a + '\\s*=\\s*([^;]+)');
    return b ? b.pop() : '';
}
