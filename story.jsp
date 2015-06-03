
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<!DOCTYPE html>
<html>
    <meta charset="utf-8">
    <script src="d3.v3.min.js"></script>
    <script src="jquery-ui-1.11.4/jquery-2.1.3.min.js"></script>
    <script src="jquery-ui-1.11.4/jquery-ui.js"></script>
    <link href="jquery-ui-1.11.4/jquery-ui.css" rel="Stylesheet">
    <script type="text/javascript" src="jquery-ui-1.11.4/jquery.contextmenu.js"></script>
    <link rel="stylesheet" type="text/css" href="jquery-ui-1.11.4/jquery.contextmenu.css" media="all">
    <!--
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css">
    -->
    <script>
        $(function () {
            $("#tabs").tabs();
        });
    </script>
    <style>
        .node {
            stroke: #fff;
            stroke-width: 1.5px;
        }
        .link {
            stroke: #999;
            stroke-opacity: .6;
        }

        .node text {
            font: 9px helvetica;
            stroke-width: 0.5px;
        }
        body {
            overflow:hidden;
            margin:0;
        }

        text {
            font-family: sans-serif;
            pointer-events: none;
        }
        span.whiteit{
            color:white;
        }
        .browse{
            float: left;
        }
    </style>
    <script language="javascript" type="text/javascript">

        $(document).ready(function () {
            var change = <s:property value="%{uid}"></s:property>
            //alert(change);
            document.getElementById("idd").setAttribute("value", change);
        });
        </script>
        <body>
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Concept Map</a></li>
                    <li><a href="#tabs-3">Home</a></li>
                    <li><a href="#tabs-2">Chapter Graph</a></li>
                </ul>
                <div id="tabs-3">
                    <div class="browse">
                        <a href="/Concepto/home.jsp">Home</a>
                    </div>
                </div>
                <div id="tabs-1">
                    <div class="ui-widget">
                        <input id="search">
                        <button type="button" onclick="searchNode()">Search</button>
                    </div>

                    <script>


                        var graph; // a global

                        d3.json("new_graph.json", function (json) {
                            graph = json;
                            //  if(graph == json)
                            //	alert("YES!");
                            //  if(graph != undefined)
                            //	alert("Yo!"); 
                        });
                        if (graph == undefined)
                            alert("Your Graph is Ready.");
                        console.log(graph);

                        var menu1 = [{'Highlight': function (menuItem, menu) {
                                    mark();
                                }}, $.contextMenu.separator, {'Delete this node': function (menuItem, menu) {
                                    alert("You clicked Option 2!");
                                }}];
                        $(function () {
                            $('.node').contextMenu(menu1, {theme: 'vista'});
                        });
                        //Constants for the SVG
                        var margin = {top: -15, right: -15, bottom: -5, left: -15};
                        var width = 1920 - margin.left - margin.right,
                                height = 800 - margin.top - margin.bottom;

                        //Set up the colour scale
                        var color = d3.scale.category20();

                        //Set up the force layout
                        var force = d3.layout.force()
                                .charge(-120)
                                .linkDistance(40)
                                .size([width + margin.left + margin.right, height + margin.top + margin.bottom]);


                        var zoom = d3.behavior.zoom()
                                .scaleExtent([1, 10])
                                .on("zoom", zoomed);

                        var drag = d3.behavior.drag()
                                .origin(function (d) {
                                    return d;
                                })
                                .on("dragstart", dragstarted)
                                .on("drag", dragged)
                                .on("dragend", dragended);


                        //Append a SVG to the body of the html page. Assign this SVG as an object to svg
                        var svg = d3.select("body").append("svg")
                                .attr("width", width + margin.left + margin.right)
                                .attr("height", height + margin.top + margin.bottom)
                                .append("g")
                                .attr("transform", "translate(" + margin.left + "," + margin.right + ")")
                                .call(zoom);
                        //Read the data from the mis element 
                        //var mis = document.getElementById('mis').innerHTML;
                        //graph = JSON.parse(mis);
                        var rect = svg.append("rect")
                                .attr("width", width)
                                .attr("height", height)
                                .style("fill", "none")
                                .style("pointer-events", "all");

                        var container = svg.append("g");

                        //Creates the graph data structure out of the json data
                        force.nodes(graph.nodes)
                                .links(graph.links)
                                .start();

                        //Create all the line svgs but without locations yet
                        var link = container.append("g")
                                .selectAll(".link")
                                .data(graph.links)
                                .enter().append("line")
                                .attr("class", "link")
                                .style("stroke-width", function (d) {
                                    return Math.sqrt(d.value);

                                });

                        var linkText = container.append("g")
                                .selectAll(".text")
                                .data(force.links())
                                .enter().append("text")
                                .attr("x", 5)
                                .attr("y", "1em")
                                .style("opacity", 0.5)
                                .attr("class", "text")
                                .style("font-size", 6 + "px")
                                .text(function (d) {
                                    return d.rel;
                                });

                        //Do the same with the circles for the nodes - no 
                        var node = container.append("g")
                                .selectAll(".node")
                                .data(graph.nodes)
                                .enter().append("g")
                                .attr("class", "node")
                                .on('click', connectedNodes);

                        node.append("circle")
                                .attr("r", 8)
                                .attr("class", "circle")
                                .style("fill", "#48d1cc")

                                .call(force.drag)
                        node.append("text")
                                .attr("dx", 10)
                                .attr("dy", ".35em")
                                .text(function (d) {
                                    return d.id
                                })
                                .style("stroke", "gray");


                        var padding = 1, // separation between circles
                                radius = 8;

                        function collide(alpha) {
                            var quadtree = d3.geom.quadtree(graph.nodes);
                            return function (d) {
                                var rb = 2 * radius + padding,
                                        nx1 = d.x - rb,
                                        nx2 = d.x + rb,
                                        ny1 = d.y - rb,
                                        ny2 = d.y + rb;
                                quadtree.visit(function (quad, x1, y1, x2, y2) {
                                    if (quad.point && (quad.point !== d)) {
                                        var x = d.x - quad.point.x,
                                                y = d.y - quad.point.y,
                                                l = Math.sqrt(x * x + y * y);
                                        if (l < rb) {
                                            l = (l - rb) / l * alpha;
                                            d.x -= x *= l;
                                            d.y -= y *= l;
                                            quad.point.x += x;
                                            quad.point.y += y;
                                        }
                                    }
                                    return x1 > nx2 || x2 < nx1 || y1 > ny2 || y2 < ny1;
                                });
                            };
                        }
                        var optArray = [];
                        for (var i = 0; i < graph.nodes.length - 1; i++) {
                            optArray.push(graph.nodes[i].id);
                        }
                        optArray = optArray.sort();

                        $(function () {
                            $("#search").autocomplete({
                                source: optArray
                            });
                        });

                        function searchNode() {
                            //find the node
                            var selectedVal = document.getElementById('search').value;
                            var node = svg.selectAll(".node");
                            if (selectedVal == "none") {
                                node.style("stroke", "white").style("stroke-width", "1");
                            } else {
                                var selected = node.filter(function (d, i) {
                                    return d.id != selectedVal;
                                });
                                selected.style("opacity", "0");
                                var link = svg.selectAll(".link")
                                link.style("opacity", "0");
                                var linktext = svg.selectAll(".text")
                                linktext.style("opacity", "0");
                                d3.selectAll(".node, .link, .text").transition()
                                        .duration(5000)
                                        .style("opacity", 1);
                            }
                        }

                        //Toggle stores whether the highlighting is on
                        var toggle = 0;
                        //Create an array logging what is connected to what
                        var linkedByIndex = {};
                        for (i = 0; i < graph.nodes.length; i++) {
                            linkedByIndex[i + "," + i] = 1;
                        }
                        ;
                        graph.links.forEach(function (d) {
                            linkedByIndex[d.source.index + "," + d.target.index] = 1;
                        });
                        //This function looks up whether a pair are neighbours
                        function neighboring(a, b) {
                            return linkedByIndex[a.index + "," + b.index];
                        }

                        function connectedNodes() {
                            if (toggle == 0) {
                                //Reduce the opacity of all but the neighbouring nodes
                                d = d3.select(this).node().__data__;
                                console.log(d.index);
                                node.style("opacity", function (o) {
                                    return neighboring(d, o) | neighboring(o, d) ? 1 : 0.1;
                                });
                                link.style("opacity", function (o) {
                                    return d.index == o.source.index | d.index == o.target.index ? 1 : 0.1;
                                });
                                var linktext = svg.selectAll(".text")
                                linktext.style("opacity", function (o) {
                                    return d.index == o.source.index | d.index == o.target.index ? 1 : 0.1;
                                });
                                //Reduce the op
                                toggle = 1;
                            } else {
                                //Put them back to opacity=1
                                node.style("opacity", 1);
                                link.style("opacity", 1);
                                var linktext = svg.selectAll(".text")
                                linktext.style("opacity", 0.5);
                                toggle = 0;
                            }
                        }

                        function mark()
                        {
                            d = d3.select(this).node()._data_;
                            console.log(d.index);
                            //circle.style("fill", "red");
                        }

                        //Now we are giving the SVGs co-ordinates - the force layout is generating the co-ordinates which this code is using to update the attributes of the SVG elements
                        force.on("tick", function () {
                            node.attr("transform", function (d) {
                                return "translate(" + d.x + "," + d.y + ")";
                            });

                            linkText.attr('transform', linkTransform);

                            link.attr("x1", function (d) {
                                return d.source.x;
                            })
                                    .attr("y1", function (d) {
                                        return d.source.y;
                                    })
                                    .attr("x2", function (d) {
                                        return d.target.x;
                                    })
                                    .attr("y2", function (d) {
                                        return d.target.y;
                                    });

                            node.attr("cx", function (d) {
                                return d.x;
                            })
                                    .attr("cy", function (d) {
                                        return d.y;
                                    });

                            node.each(collide(0.5)); //Added 
                        });


                        function linkTransform(d) {
                            var t1 = d.target.x;
                            var t2 = d.target.y;
                            var dx = (d.target.x) - (d.source.x),
                                    dy = (d.target.y) - (d.source.y);
                            return "translate(" + (d.source.x + t1) / 2 + "," + (d.source.y + t2) / 2 + ")";
                        }

                        function zoomed() {
                            container.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
                        }

                        function dragstarted(d) {
                            d3.event.sourceEvent.stopPropagation();

                            d3.select(this).classed("dragging", true);
                            force.start();
                        }

                        function dragged(d) {

                            d3.select(this).attr("cx", d.x = d3.event.x).attr("cy", d.y = d3.event.y);

                        }

                        function dragended(d) {

                            d3.select(this).classed("dragging", false);
                        }


                    </script>
                </div>
                <div id="tabs-2">
                <s:form class="browse" action="showchaptermap">
                    <s:hidden name="idd" label="idd" id="idd" value=""></s:hidden>
                    <s:submit value="Generate Chapter Graph"></s:submit>
                </s:form>
            </div>
        </div>
    </body>
</html>