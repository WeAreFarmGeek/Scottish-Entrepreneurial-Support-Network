$(document).ready(function(){
  $.getJSON('/organisations/tree.json',function(json){
    $('div#vis').height($(document).height())
    .width($(document).width())
    .css('position', 'absolute')
    .css('z-index', '-1');
    //Create a new ST instance  
    var st = new $jit.ST({
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
    st.loadJSON(json);  
    //compute node positions and layout  
    st.compute();  
    //emulate a click on the root node.  
    st.onClick(st.root);  

    // Tag filtering functionality:


  });
});
