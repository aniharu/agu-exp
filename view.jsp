<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    twi.Model model = (twi.Model) request.getAttribute("model");
    model = new twi.Model();
    String token = "";
    String stoken = "";
    String tweeet = "";
    token = request.getParameter("oauth_token");
    stoken = request.getParameter("oauth_verifier");
    tweeet = request.getParameter("tweeet");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>うめつい</title>
        <script src="https://d3js.org/d3.v3.min.js" charset="utf-8"></script>
        <script src="d3.layout.cloud.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="nicoscreen.js"></script>

        <style type="text/css">
            body{
                background:#eeeeee;
            }
            .top{
                background:#F0F5FB;
                font-size:x-large;
                font-family:"メイリオ";
            }
            .col-md-12{
                background: #ffffff;
                padding: 10px;
                text-align: center;
                border-top-left-radius: 2px;
                margin: 30px auto;
                display:inline-block;
            }
            .side{
                width: 100%;
                padding: 20px;
                background: #ffffff;
                text-align: center;
                margin: 30px auto;
            }
            .col1{
                width: 100%;
                margin: 0 auto;
                text-align:center;
            }
            .col1 li{
                display:inline-block;
                border:1px solid #ccc;
                padding:5px 10px;
                text-align:center;
                background: #ffffff;
            }
            .col2{
                width: 100%;
                margin: 0 auto;
                text-align:center;
            }
            .col2 li{
                display:inline-block;
                border:1px solid #ccc;
                padding:5px 10px;
                text-align:center;
                background: #ffffff;
            }
            .rader{
                width: 100%;
                margin: 0 auto;
                text-align:center;
            }
            .rader li{
                display:inline-block;
                border:1px solid #ccc;
                padding:5px 10px;
                background: #ffffff;
            }
            .welcome{
                font-size: 50px;
                text-shadow: 2px 2px 0px #939393,
                    4px 4px 0px #1c1c1c;
                color: #ffb342;
                font-family: 'Century Gothic';
            }
            .friend{
                width: 100%;
                margin: 0 auto;
                text-align:center;
            }
            .friend li{
                display:inline-block;
                border:1px solid #ccc;
                padding:5px 10px;
                text-align:center;
                background: #ffffff;
            }
            .gyo{
                line-height: 200%;
            }
        </style>
    </head>
    <body>
        <% if (token == null || stoken == null) {%>
        <div class="top">
            <p><center><font size=7 color="#FF69B4">
                <div style="border-style: solid ; border-width: 1px; border-color: red; width: 600px">うめついへようこそ！</div>
                </font></center></p>
        <p><a href="<%=model.getAuth()%>"><center><font size=5 face=>>>Twitter認証をする！<<</font></center></a></p>
        <ul>
            <p><li>うめついってなに？
                <ol>
                    あなたのTwitterの行動を分析し、その結果を表示します。<br>
                </ol>
            </li></p>
            <p><li>どうやって使うの？
                <ol>
                    １：Twitter認証のボタンをクリックします。<br>
                    ２：あなたのTwitterアカウントでログインします。<br>
                    ３：自動的にうめついに戻り、あなたのTwitterの解析結果が表示されます。<br>
                </ol>
            </li></p>
            <p><li>どんな情報が表示されるの？
                <ol>
                    ・ワードクラウド：たくさんつぶやいた単語が大きく表示されます。<br>
                    ・仲のいいユーザーランキング：あなたと仲良しなアカウントをランキングにしました。<br>
                    ・ツイートステータス：あなたのツイートにまつわる様々な情報を表示します。<br>
                    ・ぼっち度：あなたはついったーぼっちゃーなのか！？。<br>
                    ・フォロー状況：相互フォローなどの情報を表示します。<br>
                </ol>
            </li></p>
            <p><li>これって安全なの？梅本君に自分のTwitter見られるの嫌なんですけど！
                <ol>
                    今回ログインに使っているoauth認証キーは、アプリ終了時にデータベースに残ることはなく、そのまま破棄されます。<br>
                    よって、管理者であってもキーの取得は一切できないので安心です。<br>
                    通常のサイトでTwitter認証をする場合、一回認証されるとキーはデータベースに保存されてしまいます。認証は注意してください！<br>
                </ol>
            </li></p>
            <p><iframe width="420" height="315" src="https://www.youtube.com/embed/5saz6xHZGas" frameborder="0" allowfullscreen></iframe></p>
            <a class="twitter-timeline" data-height="500" href="https://twitter.com/MartinDurst_bot">Tweets by MartinDurst_bot</a> <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script><img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            <img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            <img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            <img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            <img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            <img src="http://imgur.com/K5aKtIB.png" alt="マーティン" align="bottom">
            </div>
            <% } else if (tweeet != null) {%>
            <% model.twi4j();
                model.tweet4(tweeet);%>
            <a class="twitter-timeline" href="https://twitter.com/Umeco_co" data-widget-id="737534269157842944">@Umeco_coさんのツイート</a>
            <script>!function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
                if (!d.getElementById(id)) {
                js = d.createElement(s);
                js.id = id;
                js.src = p + "://platform.twitter.com/widgets.js";
                fjs.parentNode.insertBefore(js, fjs);
                }
                }(document, "script", "twitter-wjs");</script>
                <% } else {%>
                <% model.registerToken(token, stoken);
                    model.twi4j();
                    model.getTimeline();
                    model.followview();
                    model.printUser();%>
            <div class="side">
                <h1>あなたを分析する。<br>
                    <img  src="dr3eX.png">
                </h1>
            </div>
            <div id="nicoscreen" style="width:sW;height:sH;border: white;">
                <div class="welcome">
                    ようこそ！ <%=model.getMyname()%>@<%=model.getScname()%> !
                </div>
                <div class="rader">
                    <li>
                        <h2>★あなたの基本ステータス★</h2>
                        <span class="gyo">
                            フォロー数：  <%=model.getFnum()%> 人<br>
                            フォロワー数：　<%=model.getFednum()%> 人<br>
                            ついったーを始めてからの総ツイート数：  <%=model.getAllnum()%> 回<br>
                            ついったー歴： <%=model.getHist()%> 日<br>
                            平均文字数: <%=model.getTwimean()%> 字<br>
                            1日のツイート回数: <%=model.getTwipday()%> 回<br>
                        </span>
                        <br><br>
                    </li>
                    <li><canvas id="twiStatus" height="400" width="500"></canvas><br></li>
                    <script>
                        var ctx = document.getElementById("twiStatus");
                        var myRadarChart = new Chart(ctx, {
                        type: 'radar',
                                data: {
                                labels: ["フォロバ率", "人気者度", "ぼっち度", "おしゃべり度", "交友度"],
                                        datasets: [
                                        {
                                        label: "あなたのツイッターステータス",
                                                backgroundColor: "rgba(83,224,255,0.5)",
                                                borderColor: "rgba(83,224,255,1)",
                                                pointBackgroundColor: "rgba(83,224,255,1)",
                                                pointBorderColor: "#fff",
                                                pointHoverBackgroundColor: "#fff",
                                                pointHoverBorderColor: "rgba(83,224,255,1)",
                                                data: [<%=model.getRyouomoi()%>, <%=model.ninki()%>, <%=model.getBotti()%>, <%=model.osha()%>, <%=model.kouyu()%>]
                                        }
                                        ]
                                },
                                options: {
                                scale: {
                                ticks: {
                                scaleOverride: true,
                                        max: 100,
                                        min: 0
                                }
                                },
                                        animation: {
                                        duration:10000
                                        }
                                }

                        });
                    </script>
                </div>
                <div class="col1">
                    <li>
                        <h2>★ワードクラウド★</h2>
                        <svg id="test">
                        </svg>
                    </li>
                    <li>
                        <h2>★ツイート時間帯の傾向★</h2>
                        <canvas id="twiTime" height="500" width="800"></canvas><br>
                        <script>
                            var ctx = document.getElementById("twiTime");
                            var twiTime = new Chart(ctx, {
                            type: 'bar',
                                    data: {
                                    labels: ["1時", "2時", "3時", "4時", "5時", "6時", "7時", "8時", "9時", "10時", "11時", "12時", "13時", "14時", "15時", "16時", "17時", "18時", "19時", "20時", "21時", "22時", "23時", "24時"], //x軸のラベル
                                            datasets: [{
                                            label: "あなたのツイート数",
                                                    data: [<%=model.timetwi[16]%>, <%=model.timetwi[17]%>, <%=model.timetwi[18]%>, <%=model.timetwi[19]%>, <%=model.timetwi[20]%>, <%=model.timetwi[21]%>, <%=model.timetwi[22]%>, <%=model.timetwi[23]%>,<%=model.timetwi[0]%>, <%=model.timetwi[1]%>,<%=model.timetwi[2]%>,<%=model.timetwi[3]%>,<%=model.timetwi[4]%>, <%=model.timetwi[5]%>, <%=model.timetwi[6]%>, <%=model.timetwi[7]%>, <%=model.timetwi[8]%>, <%=model.timetwi[9]%>, <%=model.timetwi[10]%>, <%=model.timetwi[11]%>, <%=model.timetwi[12]%>, <%=model.timetwi[13]%>, <%=model.timetwi[14]%>, <%=model.timetwi[15]%>],
                                                    backgroundColor: [
                                                            'rgba(255, 99, 132, 0.2)',
                                                            'rgba(54, 162, 235, 0.2)',
                                                            'rgba(255, 206, 86, 0.2)',
                                                            'rgba(75, 192, 192, 0.2)',
                                                            'rgba(153, 102, 255, 0.2)',
                                                            'rgba(255, 159, 64, 0.2)',
                                                            'rgba(255, 99, 132, 0.2)',
                                                            'rgba(54, 162, 235, 0.2)',
                                                            'rgba(255, 206, 86, 0.2)',
                                                            'rgba(75, 192, 192, 0.2)',
                                                            'rgba(153, 102, 255, 0.2)',
                                                            'rgba(255, 159, 64, 0.2)',
                                                            'rgba(255, 99, 132, 0.2)',
                                                            'rgba(54, 162, 235, 0.2)',
                                                            'rgba(255, 206, 86, 0.2)',
                                                            'rgba(75, 192, 192, 0.2)',
                                                            'rgba(153, 102, 255, 0.2)',
                                                            'rgba(255, 159, 64, 0.2)',
                                                            'rgba(255, 99, 132, 0.2)',
                                                            'rgba(54, 162, 235, 0.2)',
                                                            'rgba(255, 206, 86, 0.2)',
                                                            'rgba(75, 192, 192, 0.2)',
                                                            'rgba(153, 102, 255, 0.2)',
                                                            'rgba(255, 159, 64, 0.2)'
                                                    ],
                                                    borderColor: [
                                                            'rgba(255,99,132,1)',
                                                            'rgba(54, 162, 235, 1)',
                                                            'rgba(255, 206, 86, 1)',
                                                            'rgba(75, 192, 192, 1)',
                                                            'rgba(153, 102, 255, 1)',
                                                            'rgba(255, 159, 64, 1)',
                                                            'rgba(255,99,132,1)',
                                                            'rgba(54, 162, 235, 1)',
                                                            'rgba(255, 206, 86, 1)',
                                                            'rgba(75, 192, 192, 1)',
                                                            'rgba(153, 102, 255, 1)',
                                                            'rgba(255, 159, 64, 1)',
                                                            'rgba(255,99,132,1)',
                                                            'rgba(54, 162, 235, 1)',
                                                            'rgba(255, 206, 86, 1)',
                                                            'rgba(75, 192, 192, 1)',
                                                            'rgba(153, 102, 255, 1)',
                                                            'rgba(255, 159, 64, 1)',
                                                            'rgba(255,99,132,1)',
                                                            'rgba(54, 162, 235, 1)',
                                                            'rgba(255, 206, 86, 1)',
                                                            'rgba(75, 192, 192, 1)',
                                                            'rgba(153, 102, 255, 1)',
                                                            'rgba(255, 159, 64, 1)'
                                                    ],
                                                    borderWidth: 1
                                            }]
                                    },
                                    options: {
                                    animation: {
                                    duration: 8000
                                    }
                                    }
                            });
                        </script>
                    </li>
                </div>
                <div class='col2'>
                    <li>
                        <h2>★あなたのぼっち度★</h2>
                        <p><font size="5"><%=model.getBotti()%>%</font></p><br>
                        <canvas id="Botti" height="300" width="350"></canvas><br>
                        <script>
                            var ctx2 = document.getElementById("Botti");
                            var botti = new Chart(ctx2, {
                            type: 'pie',
                                    data: {
                                    labels: [
                                            "ひとりごと",
                                            "リプライ"
                                    ], //x軸のラベル
                                            datasets: [
                                            {
                                            data: [<%=model.getBotti()%>, 100 -<%=model.getBotti()%>],
                                                    backgroundColor: [
                                                            "#36A2EB",
                                                            "#FF6384"
                                                    ],
                                                    borderColor: [
                                                            "#36A2EB",
                                                            "#FF6384"
                                                    ]
                                            }]
                                    },
                                    options: {
                                    animation: {
                                    duration: 12000
                                    }
                                    }
                            });
                        </script>
                    </li>
                    <li>
                        <h2>★フォロー状況★</h2>
                        <p><font size="5">フォロバ率：<%=model.getRyouomoi()%>%</font></p><br>
                        <canvas id="Follow" height="300" width="350"></canvas><br>
                        <script>
                            var ctx3 = document.getElementById("Follow");
                            var follow = new Chart(ctx3, {
                            type: 'pie',
                                    data: {
                                    labels: [
                                            "片思い",
                                            "片思われ",
                                            "両思い"
                                    ], //x軸のラベル
                                            datasets: [
                                            {
                                            data: [<%=model.kataomoi%>, <%=model.kataomoware%>, <%=model.ryouomoi%>],
                                                    backgroundColor: [
                                                            "#FFCE56",
                                                            "#ccffcc",
                                                            "#ffb3da"
                                                    ],
                                                    borderColor: [
                                                            "#FFCE56",
                                                            "#ccffcc",
                                                            "#ffb3da"
                                                    ]
                                            }]
                                    },
                                    options: {
                                    animation: {
                                    duration: 12000
                                    }
                                    }
                            });
                        </script>
                    </li>
                    <li>
                        <h2>★ふぁぼツイート率★</h2>
                        <p><font size="5"><%=model.getFavritu()%>%</font></p><br>
                        <canvas id="Favritu" height="300" width="350"></canvas><br>
                        <script>
                            var ctx3 = document.getElementById("Favritu");
                            var follow = new Chart(ctx3, {
                            type: 'pie',
                                    data: {
                                    labels: [
                                            "ふぁぼツイート",
                                            "ふぁぼなしツイート"
                                    ], //x軸のラベル
                                            datasets: [
                                            {
                                            data: [<%=model.getFavritu()%>, <%=model.getNotFav()%>],
                                                    backgroundColor: [
                                                            "#ADFF2F",
                                                            "#afeeee"
                                                    ],
                                                    borderColor: [
                                                            "#ADFF2F",
                                                            "#afeeee"
                                                    ]
                                            }]
                                    },
                                    options: {
                                    animation: {
                                    duration: 12000
                                    }
                                    }
                            });
                        </script>
                    </li>
                </div>

                <div class="friend">
                    <li>
                        <h2>★あなたと仲の良いユーザーランキング★</h2>
                        <% for (int i = 0; i < 5; i++) {%>
                        <font size=<%=7 - i%> color="#99ff00">
                        <%=i + 1%>位：
                        <img src=<%=model.pics[i]%> />
                        <a href='https://twitter.com/<%=model.ranking[i]%>'><%=model.ranking[i]%></a>
                        Score：<%=model.ranknum[i]%><br></font>
                        <% }
                            model.kaiseki(model.text);%>
                    </li>
                    <li>
                        <h2>★ふぁぼ獲得ついーとTOP3★</h2>
                        <blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><%=model.favlist.get(0).getText()%></p>&mdash; <%=model.getMyname()%> (@<%=model.getScname()%>) <a href="https://twitter.com/Umeco_co/status/<%=model.favlist.get(0).getId()%>"><%=model.favlist.get(0).getCreatedAt().getYear()%>年<%=model.favlist.get(0).getCreatedAt().getMonth()%>月<%=model.favlist.get(0).getCreatedAt().getDay()%>日</a></blockquote>
                        <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
                        <blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><%=model.favlist.get(1).getText()%></p>&mdash; <%=model.getMyname()%> (@<%=model.getScname()%>) <a href="https://twitter.com/Umeco_co/status/<%=model.favlist.get(1).getId()%>"><%=model.favlist.get(1).getCreatedAt().getYear()%>年<%=model.favlist.get(1).getCreatedAt().getMonth()%>月<%=model.favlist.get(1).getCreatedAt().getDay()%>日</a></blockquote>
                        <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
                        <blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr"><%=model.favlist.get(2).getText()%></p>&mdash; <%=model.getMyname()%> (@<%=model.getScname()%>) <a href="https://twitter.com/Umeco_co/status/<%=model.favlist.get(2).getId()%>"><%=model.favlist.get(2).getCreatedAt().getYear()%>年<%=model.favlist.get(2).getCreatedAt().getMonth()%>月<%=model.favlist.get(2).getCreatedAt().getDay()%>日</a></blockquote>
                        <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
                    </li>
                </div>
                <br><br>
                <div class="col-md-12">
                    <script>
                            var fill = d3.scale.category20();
                            var words = [
                        <% for (int i = 0; i < model.words.size(); i++) {%>
                            {"text":"<%=model.getWords(i)%>", "size": <%=model.wnum.get(i)%>},
                        <%}%>
                            {"text":"うめつい", "size":1}
                            ];
                            var countMax = d3.max(words, function(d){return d.size});
                            var sizeScale = d3.scale.linear().domain([0, countMax]).range([10, 100]);
                            var colorScale = d3.scale.category20();
                            words = words.map(function(d){
                            return {
                            text:d.text,
                                    size:sizeScale(d.size)
                            };
                            });
                            var layout = d3.layout.cloud()
                                    .size([800, 500])
                                    .words(words)
                                    .rotate(function () {
                                    return ~~(Math.random() * 2) * 90;
                                    })
                                    .font("Impact")
                                    .fontSize(function (d) {
                                    return d.size;
                                    })
                                    .on("end", draw);
                            layout.start();
                            function draw(words) {
                            d3.select("body").select("#test")
                                    .attr("width", layout.size()[0])
                                    .attr("height", layout.size()[1])
                                    .append("g")
                                    .attr("transform", "translate(400,250)")
                                    .selectAll("text")
                                    .data(words)
                                    .enter().append("text")
                                    .style("font-size", function (d) {
                                    return d.size + "px";
                                    })
                                    .style("font-family", "Impact")
                                    .style("fill", function (d, i) {
                                    return fill(i);
                                    })
                                    .attr("text-anchor", "middle")
                                    .attr("transform", function (d) {
                                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                                    })
                                    .text(function (d) {
                                    return d.text;
                                    });
                            }
                            document.getElementsByTagName('svg')
                    </script>
                </div>
            </div>
            <script type="text/javascript">
                        var obj = {
                        //基本情報が設定できます
                        "base": {
                        color: "white", //文字の色を指定します
                                speed: "normal", //文字が流れるスピードを指定します。slow/fast/normal 
                                interval: "normal", //文字が流れる間隔を指定します。slow/fast/normal
                                font_size: "30px", //フォントのサイズを指定します。
                                loop: true //文字が最後まで流れた後に、繰り返すかどうか　true/false
                        },
                                //ここに、重ねるコメントを登録します。個数制限はありません。
                                "comments": [
                <% int comments = 200;
                    if (model.words.size() < comments) {
                        comments = model.words.size() - 1;
                    }
                %>
                <% for (int i = 0; i < comments; i++) {%>
                                "<%=model.getWords(i)%>",
                <%}%>
                                "うめつい"
                                ]
                        };
                nicoscreen.set(obj);
                nicoscreen.start();
                var box = document.getElementById('nicoscreen');
                box.style.border = 'white';
            </script>
            <% }%>
            </body>
            </html>
