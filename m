Date: Wed, 10 Nov 2021 12:36:09 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <764146725.499610.1636544169460@...2642...>
In-Reply-To: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
References: <CAAYFXLmcybkvkw0RJ5gPVhkxrYKRr4XkdPUJwB4Cm--jQjdXKQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_499609_728115443.1636544169459"
Subject: Re: [Openvpn-devel] [PATCH] boolean short-circuit auth upon failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>, openvpn-devel@lists.sourceforge.net

------=_Part_499609_728115443.1636544169459
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Pete Nelson <petiepooo@...277...> hat am 09.11.2021 20:47 geschrieben:
> 
> 
> When evaluating authentication plugins, stop further evaluation
> once the first failure is detected.
> 
Since plugin_call is only a thin wrapper around plugin_call_ssl I think this would short-circuit ALL plugin calls. Doesn't sound like you intended that.

Regards,
  Frank

--
  Frank Lichtenheld



------=_Part_499609_728115443.1636544169459
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!doctype html>
<html>
 <head> 
  <meta charset="UTF-8"> 
 </head>
 <body>
  <div class="default-style">
   <br>
  </div>
  <blockquote type="cite">
   <div>
    Pete Nelson &lt;petiepooo@...277...&gt; hat am 09.11.2021 20:47 geschrieben:
   </div>
   <div>
    <br>
   </div>
   <div>
    <br>
   </div>
   <div dir="ltr">
    When evaluating authentication plugins, stop further evaluation
    <br>once the first failure is detected.
    <br>
   </div>
  </blockquote>
  <div class="io-ox-signature">
   <div class="default-style">
    Since plugin_call is only a thin wrapper around plugin_call_ssl I think this would short-circuit ALL plugin calls. Doesn't sound like you intended that.
    <br>
   </div>
   <div class="default-style">
    <br>
   </div>
   <div class="default-style">
    Regards,
    <br>
   </div>
   <div class="default-style">
    &nbsp; Frank
    <br>
   </div>
   <div class="default-style">
    <br>
   </div>
   <div class="default-style">
    --
   </div>
   <div class="default-style">
    &nbsp; Frank Lichtenheld
   </div>
   <div class="default-style">
    <br>
   </div>
  </div>
 </body>
</html>
------=_Part_499609_728115443.1636544169459--

