function heatshock() {

// http://blog.thomsonreuters.com/index.php/mobile-patent-suits-graphic-of-the-day/
var links = [
  {source: "Hsp90", target: "HCom", type: "M11"},
  {source: "HSF1", target: "HCom", type: "M11"},
  {source: "MisP", target: "MCom", type: "M21"},
  {source: "Hsp90", target: "MCom", type: "M21"},
  {source: "Sink", target: "NatP", type: "M31"},

  {source: "HCom", target: "Hsp90", type: "M11"},
  {source: "HCom", target: "HSF1", type: "M11"},
  {source: "MCom", target: "MisP", type: "M21"},
  {source: "MCom", target: "Hsp90", type: "M21"},
  {source: "NatP", target: "MisP", type: "M31"},
  {source: "NatP", target: "ROS", type: "M31"},

  {source: "HSF1", target: "DiH", type: "M11"},
  {source: "MCom", target: "Hsp90", type: "M21"},
  {source: "MCom", target: "NatP", type: "M21"},
  {source: "MCom", target: "ADP", type: "M21"},
  {source: "ATP", target: "Hsp90", type: "M21"},
  {source: "ATP", target: "NatP", type: "M21"},
  {source: "ATP", target: "ADP", type: "M21"},
  {source: "MisP", target: "AggP", type: "M31"},

  {source: "HSF1", target: "TriH", type: "M11"},
  {source: "DiH", target: "TriH", type: "M11"},
  {source: "MisP", target: "ADP", type: "M21"},
  {source: "ATP", target: "ADP", type: "M21"},
  {source: "MisP", target: "AggP", type: "M31"},


  {source: "HSETriH", target: "Hsp90", type: "M11"},
  {source: "Hsp90", target: "ADP", type: "M21"},
  {source: "ATP", target: "ADP", type: "M21"},
  {source: "Sink", target: "ROS", type: "M31"},

  {source: "TriH", target: "DiH", type: "M11"},
  {source: "TriH", target: "HSF1", type: "M11"},
  {source: "ADP", target: "ATP", type: "M21"},
  {source: "ROS", target: "Sink", type: "M31"},

  {source: "DiH", target: "HSF1", type: "M11"},
  {source: "ATP", target: "ADP", type: "M21"},
  {source: "Sink", target: "X", type: "M31"},


  {source: "TriH", target: "HSETriH", type: "M11"},
  {source: "HSD", target: "HSETriH", type: "M11"},
  {source: "HSETriH", target: "HSE", type: "M11"},
  {source: "HSETriH", target: "TriH", type: "M11"},

];

var nodes = {};

// Compute the distinct nodes from the links.
links.forEach(function(link) {
  link.source = nodes[link.source] || (nodes[link.source] = {name: link.source});
  link.target = nodes[link.target] || (nodes[link.target] = {name: link.target});
});

var width = 480,
    height = 500;

var force = d3.layout.force()
    .nodes(d3.values(nodes))
    .links(links)
    .size([width, height])
    .linkDistance(60)
    .charge(-300)
    .on("tick", tick)
    .start();

var svg = d3.select("#heatshock").append("svg")
    .attr("width", width)
    .attr("height", height);

// Per-type markers, as they don't inherit styles.
svg.append("defs").selectAll("marker")
    .data(["M11", "M21", "M31"])
  .enter().append("marker")
    .attr("id", function(d) { return d; })
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", -1.5)
    .attr("markerWidth", 6)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
  .append("path")
    .attr("d", "M0,-5L10,0L0,5");

var path = svg.append("g").selectAll("path")
    .data(force.links())
  .enter().append("path")
    .attr("class", function(d) { return "link " + d.type; })
    .attr("marker-end", function(d) { return "url(#" + d.type + ")"; });

var circle = svg.append("g").selectAll("circle")
    .data(force.nodes())
  .enter().append("circle")
    .attr("r", 6)
    .call(force.drag);

var text = svg.append("g").selectAll("text")
    .data(force.nodes())
  .enter().append("text")
    .attr("x", 8)
    .attr("y", ".31em")
    .text(function(d) { return d.name; });

// Use elliptical arc path segments to doubly-encode directionality.
function tick() {
  path.attr("d", linkArc);
  circle.attr("transform", transform);
  text.attr("transform", transform);
}

function linkArc(d) {
  var dx = d.target.x - d.source.x,
      dy = d.target.y - d.source.y,
      dr = Math.sqrt(dx * dx + dy * dy);
  return "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y;
}

function transform(d) {
  return "translate(" + d.x + "," + d.y + ")";
}

}