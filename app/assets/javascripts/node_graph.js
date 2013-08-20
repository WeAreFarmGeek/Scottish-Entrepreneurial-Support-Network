$(document).ready(function(){
  $.getJSON('/organisations/tree.json',function(json){
    $('div#vis').height($(document).height())
    .width($(document).width())
    .css('position', 'absolute')
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
      levelDistance: 50,  
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
        width: 100,
        type: 'rectangle',  
        color: '#fff',  
        overridable: true  
      },  

      Edge: {  
        type: 'bezier',
        overridable: true  
      },


      Tips: {
        enable: true,
        onShow: function(tip, node) {
          var html = "";
          html += "<div class='header'>";
            html += "<img src='"+ node.data.logo.thumb +"'/>";
            html += "<h6>"+ node.name +"</h6>";
            html += "<div class='clearfix'></div>";
          html += "</div>";
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
          
          tip.innerHTML = html;
        }
      },

      //This method is called on DOM label creation.  
      //Use this method to add event handlers and styles to  
      //your node.  
      onCreateLabel: function(label, node){  

        var image = $('<img>').attr('width', 100).attr('src', node.data.logo.thumb)[0].outerHTML;

        label.innerHTML  = node.name + ' ' + image;
        label.id         = node.id;              
        label.onclick    = function(){};
        //set label styles  
        var style        = label.style;  
        style.width      = 100 + 'px';  
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


    // When the text changes on the filter input
    $('input#filter').keyup(function(){
      // Capture the context & FilterString
      Self = this;
      FilterString = $(Self).val().toLowerCase();
      // If the string exists (if the user has typed something in)
      if (FilterString) {
        // Make sure that the person had finished
        // typing
        delay(function(){
          // For each node
          $jit.Graph.Util.eachNode(ST.graph, function(node){
            // Collect the node data, join up the tags so we
            // can search them all in one go
            var name  = node.name.toLowerCase();
            var blurb = node.data.blurb.toLowerCase();
            var tags  = node.data.tags.join(", ").toLowerCase();

            // Search through all the data collected, if there's no result on this node
            // then set the alpha to 0.3 (transparent)
            if (name.indexOf(FilterString) == -1 && blurb.indexOf(FilterString) == -1 && tags.indexOf(FilterString) == -1) {
              node.setData('alpha', 0.3);
            // Otherwise, set the alpha to 1 (fully opaque)
            } else {
              node.setData('alpha', 1);
            }
          });
        }, 1000);

      // If there is nothing there (if the user deleted the text previously in there)
      } else {
        $jit.Graph.Util.eachNode(ST.graph, function(node){
          node.setData('alpha', 1);
        });
      }
    });


  });
});
