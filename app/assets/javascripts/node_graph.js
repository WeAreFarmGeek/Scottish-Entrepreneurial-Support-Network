$(document).ready(function(){
  $.getJSON('/admin/organisations/tree.json',function(json){
    $('div#vis').height($(window).height())
    .width($(window).width())
    .css('position', 'absolute')
    .css('top', 0)
    .css('z-index', '-1');

    //Create a new ST instance  
    ST = new $jit.ST({
      //id of viz container element  
      injectInto: 'vis',  
      //set duration for the animation  
      duration: 300,  
      //set animation transition type  
      transition: $jit.Trans.Quart.easeInOut,  
      //set distance between node and its children  
      constrained: false,
      levelDistance: 50,  
      levelsToShow: 999,

      //enable panning  
      Navigation: {  
        enable:  true,  
        panning: true  
      },  
      //set node and edge styles  
      //set overridable=true for styling individual  
      //nodes or edges  
      Node: {  
        height: 120,
        width: 150,
        type: 'rectangle',  
        color: '#fff',  
        overridable: true  
      },  

      Edge: {  
        type: 'bezier',
        overridable: true  
      },

      Events: {
        enable: true,
        onClick: function(node, eventInfo, e){
          window.location.href = node.data.url;
        }
      },


      Tips: {
        enable: true,
        onShow: function(tip, node) {
          var html = "<div>";
          html += "<h2>"+ node.name +"</h2>";
          html += "<img style='float: left; padding: 5px' src='"+ node.data.logo.thumb +"'/>";
          html += "<p>"+ node.data.blurb +"</p>";


          if (node.data.tags && node.data.tags.length > 0) {
            html += "<strong>Tags:</strong>";
            html += "<ul>";
            for (var x = 0; x < node.data.tags.length; x++) {
              html += "<li>";
                html += node.data.tags[x];
              html += "</li>";
            }
            html += "</ul>";
          }

          if (node.data.categories && node.data.categories.length > 0) {
            html += "<strong>Categories:</strong>";
            html += "<ul>";
            for (var x = 0; x < node.data.categories.length; x++) {
              html += "<li>";
                html += node.data.categories[x];
              html += "</li>";
            }
            html += "</ul>";
          }

          html += "</div>";
          
          
          // Delete the tip that infovis want's to show.
          tip.parentElement.removeChild(tip);
          // Show our own one instead
          $("#infobar").html(html);
        }
      },

      //This method is called on DOM label creation.  
      //Use this method to add event handlers and styles to  
      //your node.  
      onCreateLabel: function(label, node){  
        var image = $('<img>').attr('width', 101).css('margin-left', '-1px').attr('src', node.data.logo.thumb)[0].outerHTML;

        label.innerHTML  = node.name + '<br/>' + image;
        label.id         = node.id;              
        label.onclick    = function(){};
        //set label styles  
        var style        = label.style;  
        style.width      = 150 + 'px';  
        style.height     = 100  + 'px';              
        style.cursor     = 'pointer';  
        style.color      = '#333';  
        style.fontSize   = '0.8em';  
        style.textAlign  = 'center';  
        style.paddingTop = '3px';  
      },  

      //This method is called right before plotting  
      //a node. It's useful for changing an individual node  
      //style properties before plotting it.  
      //The data properties prefixed with a dollar  
      //sign will override the global node style properties.  
      onBeforePlotNode: function(node){
        if (!node.data.$color) {
          var random = Math.floor((Math.random()*7));
          node.data.$color = [
            '#7fc2e8',
            '#f09552', 
            '#9da6bd',
            '#22b9c6',
            '#ffd43a',
            '#ffd43a',
            '#e5502d',
            '#e5502d'
          ][random];
        }
      }
    });  

    //load json data  
    ST.loadJSON(json);  
    //compute node positions and layout  
    ST.compute();
    //emulate a click on the root node.  
    ST.onClick(ST.root);

    // Tag filtering functionality:
    // After the user stops typing in the
    // textbox for more than a second, then
    // we filter the graph by making translucent
    // all nodes which don't match the search.
    
    // Lets define a way for us to delay after
    // the keyup:
    var delay = (function(){
      var timer = 0;
      return function(callback, ms) {
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
      };
    })();


    function do_filter(context, type) {
      Self = context;
      Type = type;
      FilterString = $(Self).val().toLowerCase();

      // Reset the selection
      $jit.Graph.Util.eachNode(ST.graph, function(node){
        node.setData('alpha', 1);
      });

      // If the string exists (if the user has typed something in)
      if (FilterString) {
        // For each node
        $jit.Graph.Util.eachNode(ST.graph, function(node){
          // Collect the node data, join up the tags so we
          // can search them all in one go
          //var data = node.name.toLowerCase() + " " + node.data.blurb.toLowerCase() + " ";
          var data = "";
          if (Type == 'tag') {
            data += node.data.tags.join(" ").toLowerCase();
          }

          if (Type == 'category') {
            data += node.data.categories.join(" ").toLowerCase();
          }


          // Search through all the data collected, if there's no result on this node
          // then set the alpha to 0.3 (transparent)
          if (data.indexOf(FilterString) == -1) {
            node.setData('alpha', 0.3);
          }
        });
      }
      ST.refresh();
    }

    // When the text changes on the filter input
    $('select#tag_filter').change(function(){
      do_filter(this, 'tag');
    });

    // When the text changes on the filter input
    $('select#category_filter').change(function(){
      do_filter(this, 'category');
    });


    ScaleX = ST.canvas.scaleOffsetX;
    ScaleY = ST.canvas.scaleOffsetY;

    function setLabelScaling() {
      $(".node").css("-moz-transform",    "scale(" + ST.canvas.scaleOffsetX + "," +  ST.canvas.scaleOffsetY + ")");
      $(".node").css("-webkit-transform", "scale(" + ST.canvas.scaleOffsetX + "," +  ST.canvas.scaleOffsetY + ")");
      $(".node").css("-ms-transform",     "scale(" + ST.canvas.scaleOffsetX + "," +  ST.canvas.scaleOffsetY + ")");
      $(".node").css("-o-transform",      "scale(" + ST.canvas.scaleOffsetX + "," +  ST.canvas.scaleOffsetY + ")");
    }

    $('canvas').mousewheel(function(event, delta, deltaX, deltaY){
      if (deltaY > 0) {
        if (ScaleX > 0.5) {
          ScaleX = ScaleX - 0.1;
          ScaleY = ScaleY - 0.1;
          ST.canvas.scale(ScaleX, ScaleY);
          setLabelScaling();
        } 
      } else if (deltaY < 0) {
        if (ScaleX < 1.25) {
          ScaleX = ScaleX + 0.1;
          ScaleY = ScaleY + 0.1;
          ST.canvas.scale(ScaleX, ScaleY);
          setLabelScaling();
        } 
      }

      event.stopPropagation();
      event.preventDefault();
    });

  });
});
