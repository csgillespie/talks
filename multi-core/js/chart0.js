function heatshock_front() {

// http://blog.thomsonreuters.com/index.php/mobile-patent-suits-graphic-of-the-day/
var links = [
  {source: "Hsp90", target: "HCom", type: "M1"},
  {source: "HSF1", target: "HCom", type: "M1"},
  {source: "MisP", target: "MCom", type: "M2"},
  {source: "Hsp90", target: "MCom", type: "M2"},
  {source: "Sink", target: "NatP", type: "M3"},

  {source: "HCom", target: "Hsp90", type: "M1"},
  {source: "HCom", target: "HSF1", type: "M1"},
  {source: "MCom", target: "MisP", type: "M2"},
  {source: "MCom", target: "Hsp90", type: "M2"},
  {source: "NatP", target: "MisP", type: "M3"},
  {source: "NatP", target: "ROS", type: "M3"},

  {source: "HSF1", target: "DiH", type: "M1"},
  {source: "MCom", target: "Hsp90", type: "M2"},
  {source: "MCom", target: "NatP", type: "M2"},
  {source: "MCom", target: "ADP", type: "M2"},
  {source: "ATP", target: "Hsp90", type: "M2"},
  {source: "ATP", target: "NatP", type: "M2"},
  {source: "ATP", target: "ADP", type: "M2"},
  {source: "MisP", target: "AggP", type: "M3"},

  {source: "HSF1", target: "TriH", type: "M1"},
  {source: "DiH", target: "TriH", type: "M1"},
  {source: "MisP", target: "ADP", type: "M2"},
  {source: "ATP", target: "ADP", type: "M2"},
  {source: "MisP", target: "AggP", type: "M3"},


  {source: "HSETriH", target: "Hsp90", type: "M1"},
  {source: "Hsp90", target: "ADP", type: "M2"},
  {source: "ATP", target: "ADP", type: "M2"},
  {source: "Sink", target: "ROS", type: "M3"},

  {source: "TriH", target: "DiH", type: "M1"},
  {source: "TriH", target: "HSF1", type: "M1"},
  {source: "ADP", target: "ATP", type: "M2"},
  {source: "ROS", target: "Sink", type: "M3"},

  {source: "DiH", target: "HSF1", type: "M1"},
  {source: "ATP", target: "ADP", type: "M2"},
  {source: "Sink", target: "X", type: "M3"},


  {source: "TriH", target: "HSETriH", type: "M1"},
  {source: "HSD", target: "HSETriH", type: "M1"},
  {source: "HSETriH", target: "HSE", type: "M1"},
  {source: "HSETriH", target: "TriH", type: "M1"},

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

var svg = d3.select("#star").append("svg")
    .attr("width", width)
    .attr("height", height);

// Per-type markers, as they don't inherit styles.
svg.append("defs").selectAll("marker")
    .data(["M1", "M2", "M3"])
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

function star_front() {

// http://blog.thomsonreuters.com/index.php/mobile-patent-suits-graphic-of-the-day/
var links = [
  {source: "Gene1", target: "mRNA1", type: "M1"},
  {source: "mRNA1", target: "Protein1", type: "M1"},
  {source: "mRNA1", target: "Sink1", type: "M1"},
  {source: "Protein1", target: "Sink1", type: "M1"},

  {source: "Gene2", target: "mRNA2", type: "M2"},
  {source: "mRNA2", target: "Protein2", type: "M2"},
  {source: "mRNA2", target: "Sink2", type: "M2"},
  {source: "Protein2", target: "Sink2", type: "M2"},
  {source: "Protein1", target: "GeneI2", type: "M2"},
  {source: "Protein2", target: "GeneI2", type: "M2"},
  {source: "GeneI2", target: "mRNA2", type: "M2"},

  {source: "Gene3", target: "mRNA3", type: "M3"},
  {source: "mRNA3", target: "Protein3", type: "M3"},
  {source: "mRNA3", target: "Sink3", type: "M3"},
  {source: "Protein3", target: "Sink3", type: "M3"},
  {source: "Protein1", target: "GeneI3", type: "M3"},
  {source: "Protein3", target: "GeneI3", type: "M3"},
  {source: "GeneI3", target: "mRNA3", type: "M3"},

  {source: "Gene4", target: "mRNA4", type: "M4"},
  {source: "mRNA4", target: "Protein4", type: "M4"},
  {source: "mRNA4", target: "Sink4", type: "M4"},
  {source: "Protein4", target: "Sink4", type: "M4"},
  {source: "Protein1", target: "GeneI4", type: "M4"},
  {source: "Protein4", target: "GeneI4", type: "M4"},
  {source: "GeneI4", target: "mRNA4", type: "M4"},

{source: "Gene5", target: "mRNA5", type: "M5"},
  {source: "mRNA5", target: "Protein5", type: "M5"},
  {source: "mRNA5", target: "Sink5", type: "M5"},
  {source: "Protein5", target: "Sink5", type: "M5"},
  {source: "Protein1", target: "GeneI5", type: "M5"},
  {source: "Protein5", target: "GeneI5", type: "M5"},
  {source: "GeneI5", target: "mRNA5", type: "M5"},

{source: "Gene6", target: "mRNA6", type: "M6"},
  {source: "mRNA6", target: "Protein6", type: "M6"},
  {source: "mRNA6", target: "Sink6", type: "M6"},
  {source: "Protein6", target: "Sink6", type: "M6"},
  {source: "Protein1", target: "GeneI6", type: "M6"},
  {source: "Protein6", target: "GeneI6", type: "M6"},
  {source: "GeneI6", target: "mRNA6", type: "M6"},


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

var svg = d3.select("#star").append("svg")
    .attr("width", width)
    .attr("height", height);

// Per-type markers, as they don't inherit styles.
svg.append("defs").selectAll("marker")
        .data(["M1", "M2", "M3", "M4", "M5", "M6"])
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