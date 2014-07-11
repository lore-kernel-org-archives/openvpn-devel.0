Message-ID: <53BFA5AA.4070305@...1147...>
Date: Fri, 11 Jul 2014 10:51:54 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <53BF9998.5020906@...1921...>
In-Reply-To: <53BF9998.5020906@...1921...>
Content-Type: multipart/alternative;
	boundary="------------070406050904070709070304"
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
 configuration file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Philipp Hagemeister <phihag@...1921...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070406050904070709070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/14 10:00, Philipp Hagemeister wrote:
> On modern systems, topology subnet should always be set, but it's
> missing in the configuration file.
> Add it with a short explanation.
NACK
There are a few annoying issues with
   topology subnet
esp when using server side things like
   route <remote subnet> <mask>

that will *fail* with 'topology subnet' ; until this is fixed this 
should NOT be considered the default.

JJK


> Signed-off-by: Philipp Hagemeister <phihag@...1921...>
> ---
>   sample/sample-config-files/server.conf | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/sample/sample-config-files/server.conf
> b/sample/sample-config-files/server.conf
> index f483b6b..6a2b4c2 100644
> --- a/sample/sample-config-files/server.conf
> +++ b/sample/sample-config-files/server.conf
> @@ -86,6 +86,13 @@ key server.key  # This file should be kept secret
>   # 2048 bit keys.
>   dh dh1024.pem
>
> +# Network topology
> +# Should be subnet (addressing via IP)
> +# unless Windows clients v2.0.9 and lower have to
> +# be supported (then net30, i.e. a /30 per client)
> +# Defaults to net30 (not recommended)
> +;topology subnet
> +
>   # Configure server mode and supply a VPN subnet
>   # for OpenVPN to draw client addresses from.
>   # The server will take 10.8.0.1 for itself,
>
>
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------070406050904070709070304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 11/07/14 10:00, Philipp Hagemeister
      wrote:<br>
    </div>
    <blockquote cite="mid:53BF9998.5020906@...1921..." type="cite">
      <pre wrap="">On modern systems, topology subnet should always be set, but it's
missing in the configuration file.
Add it with a short explanation.
</pre>
    </blockquote>
    NACK<br>
    There are a few annoying issues with <br>
    &nbsp; topology subnet<br>
    esp when using server side things like<br>
    &nbsp; route &lt;remote subnet&gt; &lt;mask&gt;<br>
    <br>
    that will *fail* with 'topology subnet' ; until this is fixed this
    should NOT be considered the default.<br>
    <br>
    JJK<br>
    <br>
    <br>
    <blockquote cite="mid:53BF9998.5020906@...1921..." type="cite">
      <pre wrap="">
Signed-off-by: Philipp Hagemeister <a class="moz-txt-link-rfc2396E" href="mailto:phihag@...1921...">&lt;phihag@...1921...&gt;</a>
---
 sample/sample-config-files/server.conf | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sample/sample-config-files/server.conf
b/sample/sample-config-files/server.conf
index f483b6b..6a2b4c2 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -86,6 +86,13 @@ key server.key  # This file should be kept secret
 # 2048 bit keys.
 dh dh1024.pem

+# Network topology
+# Should be subnet (addressing via IP)
+# unless Windows clients v2.0.9 and lower have to
+# be supported (then net30, i.e. a /30 per client)
+# Defaults to net30 (not recommended)
+;topology subnet
+
 # Configure server mode and supply a VPN subnet
 # for OpenVPN to draw client addresses from.
 # The server will take 10.8.0.1 for itself,
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/Bonitasoft">http://p.sf.net/sfu/Bonitasoft</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070406050904070709070304--

