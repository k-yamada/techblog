$(window).load(() ->
  $ads = $("""
 <div id="adsense">
   <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
   <ins class="adsbygoogle"
        style="display:inline-block;width:320px;height:100px"
        data-ad-client="ca-pub-4800068521558938"
        data-ad-slot="7481760013"></ins>
   <script>
   (adsbygoogle = window.adsbygoogle || []).push({});
   </script>
 <div>
  """)
  $(".adsense-wrapper").first().append($ads)
)
