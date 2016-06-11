<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    twi.Model model = new twi.Model();
    String token="";
    String stoken="";
    String tweeet="";
    token = request.getParameter("oauth_token");
    stoken = request.getParameter("oauth_verifier");
    tweeet = request.getParameter("tweeet");
%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Twitter OAuth認証開始</title>
    <script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
  </head>
  <style type="text/css">
  <!--
  .axis path,
  .axis line{
    fill: none;
    stroke: black;
  }
  .tick text{
    font-size: 12px;
  }
  .line{
    fill: none;
    stroke: blue;
    stroke-width: 2px;
  }
  -->
  </style>
  <body>
      <% if (token==null || stoken==null){ %>
      <p><a href="<%=model.getAuth()%>">Twitter OAuth認証開始</a></p>
      <% }else if(tweeet != null){%>
      <% model.twi4j();
         model.tweet4(tweeet);%>
            <a class="twitter-timeline" href="https://twitter.com/Umeco_co" data-widget-id="737534269157842944">@Umeco_coさんのツイート</a>
            <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
      <% }else{ %>
      <dt>Access Token</dt><dd><%=token%></dd>
      <dt>Token Secret</dt><dd><%=stoken%></dd>
      <% model.registerToken(token, stoken);
      model.twi4j();
      model.getTimeline();
      model.printUser();%>
      <Div Align="center">
          <h6>★あなたと仲の良いユーザーランキング★</h6><br><br>
          <% for(int i=0;i<5;i++){%>
          <font size=<%=7-i%> color="#99ff00">
          <%=i+1%>位：
          <img src=<%=model.pics[i]%> />
          <%=model.ranking[i]+"      "%>
          Score：<%=model.ranknum[i]%><br></font>
      <% }model.kaiseki(model.text); %>
      <form action="example.cgi">
          <p><input type="submit" value="結果をツイートする！"></p>
      </form>
      </Div>
      <form action="http://127.0.0.1:8080/exp_app/view.jsp" method="get">
          <p>ついーとする<input type="text" name="tweeet"></p>
          <input name="secret" value="<%=model.consumer.getTokenSecret()%>">
          <p><input type="submit" value="送信する"></p>
      </form>
          あなたのぼっち度: <%=model.getBotti()%><br>
      <script>//円グラフ
         var dataset = [
          {graphLegend:"", graphValue:63, graphColor:"darkblue"},
          {graphLegend:"", graphValue:37, graphColor:"transparent"}
         ];
        var width = 960,
          height = 500,
          radius = Math.min(width, height) / 2;
        var arc = d3.svg.arc()
          .outerRadius(radius - 10)
          .innerRadius(0);
        var pie = d3.layout.pie()
          .sort(null)
          .value(function(d) { return d.graphValue; });
        var tooltip = d3.select("body")
          .append("div")
          .style("position", "absolute")
          .style("z-index", "20")
          .style("visibility", "hidden");
        var svg = d3.select("body").append("svg")
          .attr("width", width)
          .attr("height", height)
          .append("g")
          .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
        var g = svg.selectAll(".arc")
          .data(pie(dataset))
          .enter().append("g")
          
        g.append("path")
          .attr("d", arc)
          .style("fill", function(d) { return d.data.graphColor; })
          // アニメーション効果
          .transition()
          .duration(1000) // 1秒間でアニメーションさせる
          .attrTween("d", function(d){
            var interpolate = d3.interpolate(
              { startAngle : 0, endAngle : 0 },
              { startAngle : d.startAngle, endAngle : d.endAngle }
            );
            return function(t){
              return arc(interpolate(t));
          }
        });
        g.append("text")
          .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
          .attr("dy", ".35em")
          .style("text-anchor", "middle")
          .text(function(d) { return d.data.graphLegend; });
      </script>
      <script>//棒グラフ
        var dataSet = [
          {name:"a", val1: 1000},
          {name:"a", val1: 2000},
          {name:"a", val1: 3000},
          {name:"a", val1: 4000},
          {name:"a", val1: 5000}  
        ];
        var svgW = 300; 	//ステージの幅
        var svgH = 200;	//ステージの高さ

        var svg = d3.select('body')
          .append('svg') //svg要素をbody要素の中に追加
          .attr({
            width: svgW,
            height: svgH,
          });
        var scale = d3.scale.linear()
          .domain([0, d3.max(dataSet, function(d){ return d.val1 })])	//正規化される値の範囲を指定(0〜val1の最大値)
          .range([0, svgH]);	//出力値の範囲を指定(0〜ステージの高さ)
        var barchart = svg.selectAll('rect')	//rect要素を選択
          .data(dataSet)	//データセットを束縛
          .enter()	//データセットの数に対して選択された要素がいくつ足りないかチェック
          .append('rect')	//足りない分のrect要素を追加
          .attr({
            x: 0,
            y: function(d, i){ return i * 30 },			//データのインデックス数をy属性に反映
            width: function(d){ return scale(d.val1) },	//データの値(val1)を正規化してwidth属性に反映
            height: 20,
            fill: "blue"
          });
      </script>
      <script>//折れ線グラフ
        var margin = {top: 20, right: 100, bottom: 30, left: 100},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;

        var dataset = [
          {x: 0, y: 5},
          {x: 1, y: 8},
          {x: 2, y: 13},
          {x: 3, y: 12},
          {x: 4, y: 16},
          {x: 5, y: 21},
          {x: 6, y: 18},
          {x: 7, y: 23},
          {x: 8, y: 24},
          {x: 9, y: 28},
          {x: 10, y: 35},
          {x: 11, y: 30},
          {x: 12, y: 32},
          {x: 13, y: 36},
          {x: 14, y: 40},
          {x: 15, y: 38},
          {x: 16, y: 38},
          {x: 17, y: 38},
          {x: 18, y: 38},
          {x: 19, y: 38},
          {x: 20, y: 38},
          {x: 21, y: 38},
          {x: 22, y: 38},
          {x: 23, y: 38},
          {x: 24, y: 38},
        ];

        var xScale = d3.scale.linear()
          .domain([0, d3.max(dataset, function(d){ return d.x; })])
          .range([0, width]);

        var yScale = d3.scale.linear()
          .domain([0, d3.max(dataset, function(d){ return d.y; })])
          .range([height, 0]);

        var xAxis = d3.svg.axis()
          .scale(xScale)
          .orient("bottom");

        var yAxis = d3.svg.axis()
          .scale(yScale)
          .orient("left");

        var line = d3.svg.line()
          .x(function(d) { return xScale(d.x); })
          .y(function(d) { return yScale(d.y); });

        var svg = d3.select("body").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
        .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis)

        svg.append("g")
          .attr("class", "y axis")
          .call(yAxis)

        svg.append("path")
          .datum(dataset)
          .attr("class", "line")
          .attr("d", line(dataset));
      </script>
      <% for(int i=0;i<24;i++){ %>
      <%=i+1%>時：
      <svg viewBox="0 0 300 8">
      <title>tweet数！</title>
    <desc>circle要素の属性値が同じ点に注目</desc>
    <rect x="2" y="2" width="<%=model.timetwi[i]/2%>" height="5" stroke-width="1" stroke="red" fill="pink"/>
    </svg>

      <% } %>
      <% } %>
  </body>
</html>
