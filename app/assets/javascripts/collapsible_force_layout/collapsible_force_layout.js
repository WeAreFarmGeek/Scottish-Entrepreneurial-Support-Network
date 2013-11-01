$(document).ready(function(){
  var w = $(window).width(),
      h = $(window).height(),
      node,
      link,
      root;

  var force = d3.layout.force()
      .on("tick", tick)
      .charge(-5000)
      .linkDistance(100)
      .size([w, h - 160]);

  var vis = d3.select("div#collapsible_force_layout").append("svg:svg")
      .attr("width", w)
      .attr("height", h);

  d3.json("/admin/organisations/tree.json", function(json) {
    root = json;
    root.x = w / 2;
    root.y = h / 2 - 80;
    update();
  });

  function update() {
    var nodes = flatten(root),
        links = d3.layout.tree().links(nodes);

    // Restart the force layout.
    force
        .nodes(nodes)
        .links(links)
        .start();

    // Update the links…
    link = vis.selectAll("line.link")
        .data(links, function(d) { return d.target.id; });

    // Enter any new links.
    link.enter().insert("svg:line", ".node")
        .attr("class", "link")
        .attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    // Exit any old links.
    link.exit().remove();

    // Update the nodes…
    node = vis.selectAll("image.node").data(nodes, function(d) { return d.id; });

    // Enter any new nodes.
    node.enter().append("image")
        .attr("class", "node")
        .attr("xlink:href", function(d) { return d.data.logo.thumb; }) 
        .attr("x", function(d) { return d.x - 25; })
        .attr("y", function(d) { return d.y - 25; })
        .attr("width", 50)
        .attr("height", 50)
        .call(force.drag)
        .on("mouseover", show_info);

    // Exit any old nodes.
    node.exit().remove();
  }

  function tick() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("x", function(d) { return d.x - 25; })
        .attr("y", function(d) { return d.y - 25; });
  }

  // Returns a list of all nodes under the root.
  function flatten(root) {
    var nodes = [], i = 0;

    function recurse(node) {
      if (node.children) node.size = node.children.reduce(function(p, v) { return p + recurse(v); }, 0);
      if (!node.id) node.id = ++i;
      nodes.push(node);
      return node.size;
    }

    root.size = recurse(root);
    return nodes;
  }

    function show_info(d,i) {
        var html = "<div>";
        html += "<h2>" + d.name + "</h2>";
        if (d.data.logo && d.data.logo.thumb && d.data.logo.thumb.length > 0) {
            html += "<img style='float: left; padding: 5px' src='"+ d.data.logo.thumb +"'/>";
        }
        html += "<p>" + d.data.blurb + "</p>";
        if (d.data.tags && d.data.tags.length > 0) {
            html += "<strong>Tags:</strong>";
            html += "<ul>";
            for (var x = 0; x < d.data.tags.length; x++) {
                html += "<li>";
                html += d.data.tags[x];
                html += "</li>";
            }
            html += "</ul>";
        }

        if (d.data.categories && d.data.categories.length > 0) {
            html += "<strong>Categories:</strong>";
            html += "<ul>";
            for (var x = 0; x < d.data.categories.length; x++) {
                html += "<li>";
                html += d.data.categories[x];
                html += "</li>";
            }
            html += "</ul>";
        }

        html += "</div>";
        $('#infobar').html(html);
    }

  function do_filter(context, type) {
    Self = context;
    Type = type;
    FilterString = $(Self).val().toLowerCase();
    var set_width_height = function(d, i){
      var data = "";
      if (Type == "tag")      { data += d.data.tags.join(" ").toLowerCase();       }
      if (Type == "category") { data += d.data.categories.join(" ").toLowerCase(); }

      w = 50;

      if (data.indexOf(FilterString) == -1) {
        return w * 2;
      } else {
        return w;
      }
    };

    vis.selectAll('.node')
       .transition()
       .attr("width", set_width_height)
       .attr('height', set_width_height);
  }

  // When the text changes on the filter input
  $('select#tag_filter').change(function(){
    do_filter(this, 'tag');
  });

  // When the text changes on the filter input
  $('select#category_filter').change(function(){
    do_filter(this, 'category');
  });

});
