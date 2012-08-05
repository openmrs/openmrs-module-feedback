var $j = jQuery.noConflict();

$j(document).ready(function(){

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

    $j("#next").click(function () {
                var $step = $j(".step:visible");
                var stepIndex = $j(".step").index($step);
                if(stepIndex == 3) {
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
                    message: '<h1>Please wait a moment..</h1>'
                    });
                    setTimeout($j.unblockUI, 2000);

                    captureScreen();
                }
    });

    function captureScreen() {

        // Setting values for the Last step - Feedback Summary
        $j('#feedbackSummary_feedback').html($j('#feedback').val());
        $j('#feedbackSummary_stack').html($j('#stack').val());

        $j('#feedbackSummary_subject').html($j('#subject option:selected').val());
        $j('#feedbackSummary_severity').html($j('#severity option:selected').val());
        $j('#feedbackSummary_receiver').html($j('#fdbk_receiver option:selected').val());

        $j('#feedbackSummary_attach').html($j('#file').val());

        try {
            if(overlayBlackout !== undefined ) {
                var overlayChildrenBlackout = overlayBlackout.children();
            }
            if(overlayHighlight !== undefined ) {
                var overlayChildrenHighlight = overlayHighlight.children();
            }
        } catch(err) {
        }

      window.setTimeout(function(){
          var canvas = html2canvas([document.getElementById("pageBody")], {
              logging: true,
              onrendered:
              function(canvas){

                  console.log(overlayChildrenHighlight);
                  console.log(overlayChildrenBlackout);

                  var ctx = canvas.getContext('2d');

              if (overlayChildrenBlackout !== undefined && overlayChildrenBlackout.length >= 1) {
                  var canvasElement = canvas[0];
                  ctx.fillStyle = "black";

                  $j.each(overlayChildrenBlackout,function(i,e){
                      ctx.moveTo(0,0);
                      var left = parseInt($j(e).css('left'));
                      var top = parseInt($j(e).css('top'));
                      var width = $j(e).width();
                      var height = $j(e).height();

                       console.log(left);
                       console.log(top);
                       console.log(width);
                       console.log(height);

                      ctx.fillRect(left,top,width,height);

                  });
                }

                  if (overlayChildrenHighlight !== undefined && overlayChildrenHighlight.length >= 1) {
                      ctx.strokeStyle = "rgb(255,0,0)";
                      ctx.lineWidth = 4;

                      $j.each(overlayChildrenHighlight,function(i,e){
                          ctx.moveTo(0,0);
                          var left = parseInt($j(e).css('left'));
                          var top = parseInt($j(e).css('top'));
                          var width = $j(e).width();
                          var height = $j(e).height();

                          console.log(left);
                          console.log(top);
                          console.log(width);
                          console.log(height)

                          ctx.strokeRect(left,top,width,height);

                      });
                  }

                  var imageURL = canvas.toDataURL();

                  try {
                      if(overlayBlackout !== undefined ) {
                          overlayBlackout.remove();
                      }
                      if(overlayHighlight !== undefined ) {
                          overlayHighlight.remove();
                      }
                      overlayShade.remove();
                  } catch(err) { }

                  var img_screen = document.getElementById('fdbk_processed_screenshot');
                  img_screen.src = imageURL;

                  $j("#screenshotFile").val(imageURL);

                  var ref_thumbnail = document.getElementById('screenshot_thumbnail');
                  ref_thumbnail.href = imageURL;

                  var snap_final = document.getElementById('fdbk_screenshot_final');
                  snap_final.src = imageURL;
              }
          });
      },1000);
    }

$j('#fdbk_blackout').click(

        function() {
            $j("span:contains('Submit Feedback')").css("background-color", "yellow");
            var closeButton = $j("#dialog").parent().find('.ui-dialog-titlebar a');
            closeButton.click();

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
          $j("span:contains('Submit Feedback')").css("background-color", "yellow");
          var closeButton = $j("#dialog").parent().find('.ui-dialog-titlebar a');
          closeButton.click();

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
