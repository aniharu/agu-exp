package twi;

import oauth.signpost.*;
import oauth.signpost.basic.*;
import java.io.*;
import java.net.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.conf.ConfigurationBuilder;
import twitter4j.ResponseList;
import twitter4j.Paging;
import twitter4j.auth.AccessToken;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Date;
import java.util.Calendar;
import org.atilika.kuromoji.Tokenizer;
import org.atilika.kuromoji.Token;
import java.util.HashSet;
import twitter4j.IDs;
import java.util.Iterator;

public class Model {

    private String consumerkey = "coa8pATuhe3T2vYOEOIp214EO";
    private String consumerSecret = "BSFxbPULnAzVTn0MWvtBOkylaCcGu2lJibZo6utuYXPiITxhas";
    private String callback = "http://127.0.0.1:8080/exp_app/view.jsp";
    private String method = "POST";
    final private String Y_id = "dj0zaiZpPUx6ZlZsbzF2ck5GVyZzPWNvbnN1bWVyc2VjcmV0Jng9ZmI-";
    private Twitter twitter;
    public ResponseList<Status> myRes;
    public String text = "";
    private List<String> friend = new ArrayList<String>();
    private List<Integer> fnum = new ArrayList<Integer>();
    public String[] ranking = new String[5];
    public int[] ranknum = new int[5];
    public List<String> words = new ArrayList<String>();
    public List<Integer> wnum = new ArrayList<Integer>();
    public List<Status> favlist = new ArrayList<Status>();
    public String rtxt = "";
    public String[] pics = new String[5];
    private double ronryalone;
    public int[] timetwi = new int[24];
    private double twipday, twimean;
    private User myuser;
    public int kataomoi,kataomoware,ryouomoi,reppnum=0;
    public int favtwinum=0,favallnum=0,getalltwi;

    public Model() {
        for (int i = 0; i < 24; i++) {
            timetwi[i] = 0;
        }
    }

    public OAuthConsumer consumer = new DefaultOAuthConsumer(
            "coa8pATuhe3T2vYOEOIp214EO",
            "BSFxbPULnAzVTn0MWvtBOkylaCcGu2lJibZo6utuYXPiITxhas");

    private OAuthProvider provider = new DefaultOAuthProvider(
            "https://api.twitter.com/oauth/request_token",
            "https://api.twitter.com/oauth/access_token",
            "https://api.twitter.com/oauth/authorize");

    public String getAuth() throws Exception {
        return provider.retrieveRequestToken(consumer, callback);
    }

    public void twi4j() {
        ConfigurationBuilder cb = new ConfigurationBuilder();
        cb.setOAuthConsumerKey(consumer.getConsumerKey());
        cb.setOAuthConsumerSecret(consumer.getConsumerSecret());
        cb.setOAuthAccessToken(consumer.getToken());
        cb.setOAuthAccessTokenSecret(consumer.getTokenSecret());
        TwitterFactory tf = new TwitterFactory(cb.build());
        twitter = tf.getInstance();
    }

    public void twi4jAcc() {
        TwitterFactory factory = new TwitterFactory();
        AccessToken accessToken = new AccessToken(consumer.getToken(), consumer.getTokenSecret());
        twitter = factory.getInstance();
        Twitter twitter = factory.getInstance();
        twitter.setOAuthConsumer(consumer.getConsumerKey(), consumer.getConsumerSecret());
        twitter.setOAuthAccessToken(accessToken);
    }

    public void tweet4(String text) throws Exception {
        Status state = twitter.updateStatus(text);
    }

    public void getTimeline() throws Exception {
        String rep = "@[a-z0-9_]*"; //リプライの正規表現
        String url = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
        Pattern p = Pattern.compile(rep);
        Pattern p2 = Pattern.compile(url);
        Matcher m;
        Matcher m2;
        String tmp;
        int flag = 0;
        Status laststate = null;
        double twilength = 0;
        myuser = twitter.verifyCredentials();

        Calendar now = Calendar.getInstance(), old = Calendar.getInstance();
        double alltwi = 0, repnum = 0;
        for (int i = 1; i < 10; i++) {
            Paging page = new Paging(i, 200);
            myRes = twitter.getUserTimeline(page);
            for (Status state : myRes) {
                if (state.getFavoriteCount()>0 && !state.getText().contains("RT")){
                    System.out.println(state.getText());
                    favlist.add(state);
                    favtwinum+=1;
                    favallnum+=state.getFavoriteCount();
                }
                if (flag == 0) {
                    flag = 1;
                    now.setTime(state.getCreatedAt());
                }
                Date date = new Date();
                Calendar cal = Calendar.getInstance();
                if (state.isRetweet()) {
                    continue;
                }
                date = state.getCreatedAt();
                cal.setTime(date);
                timetwi[date.getHours()] += 1;

                tmp = state.getText();
                m = p.matcher(tmp);
                alltwi += 1;
                twilength += tmp.length();
                if (m.find()) {

                    repnum += 1;
                    if (m.group() == null) {
                        continue;
                    }

                    reppnum+=1;
                    if (friend.contains(m.group())) {
                        fnum.set(friend.indexOf(m.group()), fnum.get(friend.indexOf(m.group())) + 1);

                    } else {
                        friend.add(m.group());
                        fnum.add(1);
                    }
                }

                tmp = m.replaceAll("");
                m2 = p2.matcher(tmp);
                tmp = m2.replaceAll("");
                text = text + "。" + tmp;
                laststate = state;
            }
            old.setTime(laststate.getCreatedAt());
        }
        twipday = 1.0 * alltwi / getDiffDay(now, old);
        twimean = twilength / alltwi;
        ronryalone = (alltwi - repnum) / alltwi * 100.0;
        getalltwi=(int)alltwi;
        
        Status tmplate;
        for (int i=favlist.size();i>1;--i){
            for (int j=0;j<i-1;j++){
                if(favlist.get(j).getFavoriteCount()<favlist.get(j+1).getFavoriteCount()){
                    tmplate=favlist.get(j);
                    favlist.set(j, favlist.get(j+1));
                    favlist.set(j+1, tmplate);
                }
            }
        }
    }

    public void printUser() {
        int tmp;
        String stmp = "aaa";
        for (int i = 0; i < 5; i++) {
            tmp = 0;
            for (int j = 0; j < friend.size(); j++) {
                if (tmp < fnum.get(j) && Arrays.asList(ranking).contains(friend.get(j)) == false && friend.get(j).length() > 3) {
                    tmp = fnum.get(j);
                    stmp = friend.get(j);
                }
            }
            ranking[i] = stmp;
            ranknum[i] = tmp;
            try {
                User user = twitter.showUser(stmp.replace("@", ""));
                pics[i] = user.getProfileImageURL();
            } catch (Exception e) {
                pics[i] = "";
            }
        }
    }

    public void registerToken(String token, String stoken) throws Exception {
        consumer.setTokenWithSecret(token, stoken);
        OAuthProvider provide = new DefaultOAuthProvider("https://api.twitter.com/oauth/request_token",
                "https://api.twitter.com/oauth/access_token",
                "https://api.twitter.com/oauth/authorize");
        provide.setOAuth10a(true);
        provide.retrieveAccessToken(consumer, stoken);
    }

    public void tweet(String text) throws Exception {
        text = URLEncoder.encode(text.toString(), "UTF-8");
        URL url = new URL("https://api.twitter.com/1.1/statuses/update.json?status=" + text);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        consumer.sign(connection);
    }

    public void kaiseki(String txt) {
        ArrayList<Integer> nums = new ArrayList<Integer>();
        ArrayList<String> key = new ArrayList<String>();
        String kigou = "^[(´°・`｀；.。、,)（）]*$";
        Pattern p = Pattern.compile(kigou);
        Matcher m;
        int page, flag = 0;
        String tmp = "", toke = "";
        Tokenizer tokenize = Tokenizer.builder().build();
        List<Token> tokens = tokenize.tokenize(txt);
        for (Token token : tokens) {
            if (!token.getAllFeaturesArray()[0].equals("名詞") && !tmp.equals("")) {
                toke = tmp;
                tmp = "";
                toke = toke.replace("ｗ", "");
                if (toke.length() < 3) {
                    continue;
                }
                m = p.matcher(toke);
                if (m.find()) {
                    continue;
                }
                toke = toke.replace("\"", "");
            } else if (!token.getAllFeaturesArray()[0].equals("名詞") && tmp.equals("")) {
                continue;
            } else if (token.getAllFeaturesArray()[0].equals("名詞") && tmp.equals("")) {
                tmp = token.getSurfaceForm();
                continue;
            } else if (token.getAllFeaturesArray()[0].equals("名詞") && !tmp.equals("")) {
                tmp = tmp + token.getSurfaceForm();
                continue;
            }

            if (!key.contains(toke)) {
                key.add(toke);
                nums.add(1);
            } else {
                page = key.indexOf(toke);
                nums.set(page, nums.get(page) + 1);
            }
        }
        for (int i = 0; i < key.size() - 1; i++) {
            for (int j = key.size() - 1; j > i; j--) {
                if (nums.get(j - 1) < nums.get(j)) {
                    int temp = nums.get(j - 1);
                    nums.set(j - 1, nums.get(j));
                    nums.set(j, temp);

                    String stemp = key.get(j - 1);
                    key.set(j - 1, key.get(j));
                    key.set(j, stemp);
                }
            }
        }

        for (int i = 0; i < key.size(); i++) {
            rtxt = rtxt + "</br>" + key.get(i) + " : " + nums.get(i) + "回";
        }
        words = key;
        wnum = nums;
    }

    public String urlc(String txt) throws Exception {
        return URLEncoder.encode(txt, "UTF-8");
    }

    public String getBotti() {
        return String.format("%.2f", ronryalone);
    }
    

    public String getTwimean() {
        return String.format("%.2f", twimean);
    }
    public String osha() {
        return String.format("%.2f", 100.0*twimean/144*twipday);
    }

    public String getTwipday() {
        return String.format("%.2f", twipday);
    }

    private int getDiffDay(Calendar cal1, Calendar cal2) {
        long diffTime = cal1.getTimeInMillis() - cal2.getTimeInMillis();
        long timetoday = 1000 * 60 * 60 * 24;
        return (int) (diffTime / timetoday);
    }

    public String botype() {
        String rtSt = "";
        if (ronryalone > 95) {
            rtSt = "パーフェクトぼっち";
        } else if (ronryalone > 90) {
            rtSt = "リアルぼっち";
        } else if (ronryalone > 85) {
            rtSt = "ついったーぼっち";
        } else if (ronryalone > 60) {
            rtSt = "一般人";
        } else if (ronryalone > 40) {
            rtSt = "会話好き";
        } else {
            rtSt = "お話好き";
        }
        return rtSt;
    }

    public String getWords(int i) {
        return words.get(i);
    }

    public String getMyname() {
        return myuser.getName();
    }

    public String getScname() {
        return myuser.getScreenName();
    }

    public String getHist() {
        Calendar today = Calendar.getInstance(), created = Calendar.getInstance();
        created.setTime(myuser.getCreatedAt());
        int days = getDiffDay(today, created);
        return String.valueOf(days);
    }

    public String getAllnum() {
        return String.valueOf(myuser.getStatusesCount());
    }

    public String getFavnum() {
        return String.valueOf(myuser.getFavouritesCount());
    }

    public String getFnum() {
        return String.valueOf(myuser.getFriendsCount());
    }

    public String getFednum() {
        return String.valueOf(myuser.getFollowersCount());
    }

    public void followview() throws Exception {
        IDs ids;
        IDs idFs;
        // IDを全てストックするオブジェクト
        //HashSetを用いることにする
        long page = 1L;
        HashSet<Long> followerIDs = new HashSet<Long>();
        HashSet<Long> friendIDs = new HashSet<Long>();
        List<Long> Kataomoi = new ArrayList<Long>();
        List<Long> Kataomoware = new ArrayList<Long>();
        List<Long> Ryouomoi = new ArrayList<Long>();
        long cursor = -1L;
        do {
            ids = twitter.getFollowersIDs(this.getScname(), cursor);
            // 取得したIDをストックする
            for (long id : ids.getIDs()) {
                followerIDs.add(id);
            }

            // 次のページへのカーソル取得。ない場合は0のようだが、念のためループ条件はhasNextで見る
            cursor = ids.getNextCursor();
        } while (ids.hasNext());
        page = 1L;
        cursor = -1L;

        //フレンドの取得
        do {
            idFs = twitter.getFriendsIDs(this.getScname(), cursor);
            // 取得したIDをストックする
            for (long idF : idFs.getIDs()) {
                friendIDs.add(idF);
            }

            // 次のページへのカーソル取得。ない場合は0のようだが、念のためループ条件はhasNextで見る
            cursor = idFs.getNextCursor();
        } while (idFs.hasNext());

        //一致しないものを抽出
        //反復子iteratorによる取得
        Iterator<Long> ite = followerIDs.iterator();
        Iterator<Long> iteF = friendIDs.iterator();

        //１．片思われの場合
        while (ite.hasNext()) {              //ループ
            Long obj = ite.next();        //該当オブジェクト取得

            //存在しない場合は片思われ
            if (friendIDs.contains(obj) == false) {
                Kataomoware.add(obj);
            }else{
                Ryouomoi.add(obj);
            }
        }

        //２．片思いの場合
        while (iteF.hasNext()) {              //ループ
            Long objF = iteF.next();        //該当オブジェクト取得
            //存在しない場合は片思い
            if (followerIDs.contains(objF) == false) {
                Kataomoi.add(objF);
            }
        }
        kataomoi=Kataomoi.size();
        kataomoware=Kataomoware.size();
        ryouomoi=Ryouomoi.size();
    }
    public String getFavritu(){
        return String.format("%.2f", 100.0*favtwinum/getalltwi);
    }
    public String getNotFav(){
        return String.format("%.2f", 100.0*(getalltwi-favtwinum)/getalltwi);
    }
    public String getRyouomoi(){
        return String.format("%.2f", 100.0*ryouomoi/Integer.parseInt(getFnum()));
    }
    public String ninki(){
        return String.valueOf(100.0*myuser.getFollowersCount()/myuser.getFriendsCount());
    }
    public String kouyu(){
        return String.valueOf(100.0*(reppnum-ranknum[0])/reppnum);
    }
    public void umetwi() throws Exception{
        this.tweet4(myuser.getName()+"の一番よくつぶやく単語は！？\n" +
"\n" +words.get(0)+"\n\n#うめつい https://umetwi.herokuapp.com/view.jsp");
    }
}
