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
  </head>
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
      <%=model.rtxt %>
      <% } %>
  </body>
</html>
