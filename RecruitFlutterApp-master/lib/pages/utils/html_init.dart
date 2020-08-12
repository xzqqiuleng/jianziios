class HtmlInit{
  static String initHtml(String html){
    List<String> htmls =["{","}",'"公司信息":',"&nbsp;","\\n","<br>"];
    for(int i = 0;i <htmls.length;i++){
      if(html.contains(htmls[i])){
      html= html.replaceAll(htmls[i], "");
      }
    }
    return html;
  }
}