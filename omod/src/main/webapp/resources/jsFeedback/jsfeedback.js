var $j = jQuery.noConflict();

$j(document).ready(function(){

    $j("#next").click(function () {

                var $step = $j(".step:visible"); // get current step
                var stepIndex = $j(".step").index($step); //index returns 0 based index so second step would be 1.

                if(stepIndex == 3) //if you are on second step then validate your table
                {
                    $j.blockUI({
                    css: {
                        border: 'none',
                        padding: '15px',
                        backgroundColor: '#000',
                        '-webkit-border-radius': '10px',
                        '-moz-border-radius': '10px',
                         opacity: .5,
                        color: '#fff'
                    },
                    // message: '<h1>Please wait a moment while processing your screen..</h1>'
                    message: '<h1>Please wait a moment..</h1>'
                    });
                    setTimeout($j.unblockUI, 2000);

                    captureScreen();
                }

    });

    /////////////////////////////////

    var self = this;
       var reset = {
           'margin':0
       },
       createDiv,
       createDivLeft,
       createDivTop,
       overlayHighlight,
       overlayBlackout,
       feedbackDiv;
     var isShadedBlackout = false;
     var isShadedHighlight = false;

//$j('#fdbk_capture_screen').click(
    function captureScreen() {

      var overlayChildrenBlackout = overlayBlackout.children().clone();
      var overlayChildrenHighlight = overlayHighlight.children().clone();

      try{
          overlayHighlight.remove();
          overlayBlackout.remove();
          overlayShade.remove();

      } catch(err) {
      }

      window.setTimeout(function(){
          var canvas = html2canvas([document.getElementById("pageBody")], {
              logging: true,
              onrendered:
              function(canvas){
                  var canvasElement = canvas[0];
                  var ctx = canvas.getContext('2d');
                  ctx.fillStyle = "black";
//                  ctx.lineWidth = 4;

                  $j.each(overlayChildrenBlackout,function(i,e){
                      ctx.moveTo(0,0);
                      var left = parseInt($j(e).css('left'));
                      var top = parseInt($j(e).css('top'));
                      var width = $j(e).width();
                      var height = $j(e).height();
                      ctx.fillRect(left,top,width,height);
                  });

                  /////////////////////////

//                      var canvasElement = canvas[0];
//                      var ctx = canvasElement.getContext('2d');
                      ctx.strokeStyle = "rgb(255,0,0)";
                      ctx.lineWidth = 4;

                      $j.each(overlayChildrenHighlight,function(i,e){
                          ctx.moveTo(0,0);
                          var left = parseInt($j(e).css('left'));
                          var top = parseInt($j(e).css('top'));
                          var width = $j(e).width();
                          var height = $j(e).height();
                          ctx.strokeRect(left,top,width,height);
                      });

                      var imageURL = canvas.toDataURL();

                  ////////////////////////

var img_screen = document.getElementById('fdbk_processed_screenshot');
img_screen.src = imageURL;

var ref_thumbnail = document.getElementById('screenshot_thumbnail');
ref_thumbnail.href = imageURL;

//var can = document.getElementById('fdbk_processed_screenshot');
//var ctx = can.getContext('2d');
//
//var img = new Image();
//img.src = imageURL;
//
//img.onload = function(){
//    can.width = 600;
//    can.height = 300;
//    ctx.drawImage(img, 0, 0, can.width, can.height);
//}

//                  var w = window.open();
//                  var canvasDom=w.document;
//                  canvasDom.write("<img src='"+a+"' style='border:1px solid black; width:1000px;' />");

              }
          });
      },1000);
    }
//    )

$j('#fdbk_blackout').click(
        function() {

            if (isShadedBlackout==false){
                overlayShade = $j('<div />')
                    .css(reset)
                    .css({
                        'background-color':'#000',
                        'opacity':0.5,
                        'position':'absolute',
                        'top':0,
                        'left':0,
                        'width':$j(document).width(),
                        'height':$j(document).height(),
                        'margin':0
                    }).appendTo('body')
                isShadedBlackout = true;
            }

    overlayBlackout = $j('<div />')
    .css(reset)
    .css({
//        'background-color':'#000',
//        'opacity':0.5,
        'position':'absolute',
        'top':0,
        'left':0,
        'width':$j(document).width(),
        'height':$j(document).height(),
        'margin':0
    })
    .appendTo('body').mousedown(function(e){
        createDiv = $j('<div />')
        .css(reset)
        .css({
            //    'border':'3px solid black',
            'position':'absolute',
            'left':e.pageX,
            'top':e.pageY,
            'opacity':1,
            'background':'#000',
            'cursor':'pointer'
        }).appendTo(overlayBlackout);

        createDivLeft  = e.pageX;
        createDivTop = e.pageY;
            overlayBlackout.bind('mousemove',function(e){
            createDiv.width(Math.abs(e.pageX-createDivLeft));
            createDiv.height(Math.abs(e.pageY-createDivTop));
            if (e.pageX<createDivLeft){
                createDiv.css('left',e.pageX);
            }
            if (e.pageY<createDivTop){
                createDiv.css('top',e.pageY);
            }
        });
    }).mouseup(function(e){
        var whiteDiv = createDiv;
        var deleteButton;
        var onDelete = false;
        var onWhiteDiv = false;
        createDiv.click(function(){
            $j(this).remove();
        });
            overlayBlackout.unbind('mousemove');
    });
  })

  $j('#fdbk_highlight').click(
      function() {

//      if (isShadedHighlight==false){

        overlayHighlight = $j('<div />')
        .css(reset)
        .css({
            'background-color':'#000',
            'opacity':0.5,
            'position':'absolute',
            'top':0,
            'left':0,
            'width':$j(document).width(),
            'height':$j(document).height(),
            'margin':0
        })
        .appendTo('body').mousedown(function(e){
            createDiv = $j('<div />')
                .css(reset)
                .css({
                    //    'border':'3px solid black',
                    'position':'absolute',
                    'left':e.pageX,
                    'top':e.pageY,
                    'opacity':1,
                    'background':'#fff',
                    'cursor':'pointer'
                }).appendTo(overlayHighlight);


            createDivLeft  = e.pageX;
            createDivTop = e.pageY;

                overlayHighlight.bind('mousemove',function(e){

                createDiv.width(Math.abs(e.pageX-createDivLeft));
                createDiv.height(Math.abs(e.pageY-createDivTop));

                if (e.pageX<createDivLeft){
                    createDiv.css('left',e.pageX);
                }

                if (e.pageY<createDivTop){
                    createDiv.css('top',e.pageY);
                }

            });

        }).mouseup(function(e){

            var whiteDiv = createDiv;
            var deleteButton;
            var onDelete = false;
            var onWhiteDiv = false;

            createDiv.click(function(){
                $j(this).remove();
            });
            overlayHighlight.unbind('mousemove');
        });

//        isShadedHighlight=true;
//     }

     })
});
