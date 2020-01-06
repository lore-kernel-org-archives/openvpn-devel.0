From: Tom Yan <tom.ty89@...277...>
Date: Mon, 6 Jan 2020 08:48:00 +0000
Message-ID: <BN7PR04MB5251B27BE1C62779CA7B4876FD3C0@...2532...>
References: <20200106080426.40701-1-list@...1798...>
In-Reply-To: <20200106080426.40701-1-list@...1798...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BN7PR04MB5251B27BE1C62779CA7B4876FD3C0BN7PR04MB5251namp_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>

--_000_BN7PR04MB5251B27BE1C62779CA7B4876FD3C0BN7PR04MB5251namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

How about printenv (without grep)?
________________________________
From: Christian Hesse <list@...1798...>
Sent: Monday, January 6, 2020 4:04:26 PM
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with env

From: Christian Hesse <mail@...1798...>

The shell builtin `set` produces different output for different shells:

bash$ set | grep '^TERM=3D'
TERM=3Dxterm
dash$ set | grep '^TERM=3D'
TERM=3D'xterm'

This may break reproducible builds depending on what shell is used.

Let's replace `set` with `env`, which is a real command and always
produces identical output.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a47e0a06..f13ff7b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1326,7 +1326,7 @@ if test "${enable_async_push}" =3D "yes"; then
         )
 fi

-CONFIGURE_DEFINES=3D"`set | grep '^enable_.*=3D' ; set | grep '^with_.*=3D=
'`"
+CONFIGURE_DEFINES=3D"`env | grep '^enable_.*=3D' ; env | grep '^with_.*=3D=
'`"
 AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [=
Configuration settings])

 TAP_WIN_COMPONENT_ID=3D"PRODUCT_TAP_WIN_COMPONENT_ID"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--_000_BN7PR04MB5251B27BE1C62779CA7B4876FD3C0BN7PR04MB5251namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
How about printenv (without grep)?</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian Hesse &lt=
;list@...1798...&gt;<br>
<b>Sent:</b> Monday, January 6, 2020 4:04:26 PM<br>
<b>To:</b> OpenVPN Development &lt;openvpn-devel@lists.sourceforge.net&gt;<=
br>
<b>Cc:</b> Christian Hesse &lt;mail@...1798...&gt;<br>
<b>Subject:</b> [Openvpn-devel] [PATCH 1/1] configure.ac: replace set with =
env</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">From: Christian Hesse &lt;mail@...1798...&gt;<br>
<br>
The shell builtin `set` produces different output for different shells:<br>
<br>
bash$ set | grep '^TERM=3D'<br>
TERM=3Dxterm<br>
dash$ set | grep '^TERM=3D'<br>
TERM=3D'xterm'<br>
<br>
This may break reproducible builds depending on what shell is used.<br>
<br>
Let's replace `set` with `env`, which is a real command and always<br>
produces identical output.<br>
<br>
Signed-off-by: Christian Hesse &lt;mail@...1798...&gt;<br>
---<br>
&nbsp;configure.ac | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/configure.ac b/configure.ac<br>
index a47e0a06..f13ff7b6 100644<br>
--- a/configure.ac<br>
&#43;&#43;&#43; b/configure.ac<br>
@@ -1326,7 &#43;1326,7 @@ if test &quot;${enable_async_push}&quot; =3D &quo=
t;yes&quot;; then<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
&nbsp;fi<br>
&nbsp;<br>
-CONFIGURE_DEFINES=3D&quot;`set | grep '^enable_.*=3D' ; set | grep '^with_=
.*=3D'`&quot;<br>
&#43;CONFIGURE_DEFINES=3D&quot;`env | grep '^enable_.*=3D' ; env | grep '^w=
ith_.*=3D'`&quot;<br>
&nbsp;AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], [&quot;`echo ${CONFIGURE_DEFI=
NES}`&quot;], [Configuration settings])<br>
&nbsp;<br>
&nbsp;TAP_WIN_COMPONENT_ID=3D&quot;PRODUCT_TAP_WIN_COMPONENT_ID&quot;<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">http=
s://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><br>
</div>
</span></font>
</body>
</html>

--_000_BN7PR04MB5251B27BE1C62779CA7B4876FD3C0BN7PR04MB5251namp_--

