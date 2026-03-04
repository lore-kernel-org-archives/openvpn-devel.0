From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:44:08 +0000
In-Reply-To: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
References: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3fa45cad9b25bdf424d70f6c5f9e14461dd132aa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UB/FOUR1++8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: Use
 correct return type for RSA_size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UB/FOUR1++8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
93?usp=3Demail )

Change subject: ssl_openssl: Use correct return type for RSA_size
......................................................................

ssl_openssl: Use correct return type for RSA_size

It returns int, so use that. Avoids a sign-compare
warning.

Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1493
Message-Id: <20260304144028.2459-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
890.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 12 deletions(-)




diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 095f893..840d9a0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1491,17 +1491,11 @@
     return len;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /* sign arbitrary data */
 static int
 rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa, int padding)
 {
-    unsigned int len =3D RSA_size(rsa);
-    int ret =3D -1;
+    int len =3D RSA_size(rsa);

     if (padding !=3D RSA_PKCS1_PADDING && padding !=3D RSA_NO_PADDING)
     {
@@ -1509,15 +1503,11 @@
         return -1;
     }

-    ret =3D get_sig_from_man(from, flen, to, len, get_rsa_padding_name(pad=
ding));
+    int ret =3D get_sig_from_man(from, flen, to, len, get_rsa_padding_name=
(padding));

     return (ret =3D=3D len) ? ret : -1;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Gerrit-Change-Number: 1493
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UB/FOUR1++8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1493?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_openssl: Use correct return type for RSA_siz=
e<br><br>It returns int, so use that. Avoids a sign-compare<br>warning.<br>=
<br>Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;ar=
ne-openvpn@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1493<br>Message-Id: =
&lt;20260304144028.2459-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg35890.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_openssl.c=
<br>1 file changed, 2 insertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span=
><br><span>index 095f893..840d9a0 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><sp=
an>@@ -1491,17 +1491,11 @@</span><br><span>     return len;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-com=
pare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* sign =
arbitrary data */</span><br><span> static int</span><br><span> rsa_priv_enc=
(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padd=
ing)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    unsigned int len =3D RSA_size(rsa);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int ret =3D -1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int len =3D RSA_size(rsa);</span><br><span> </span>=
<br><span>     if (padding !=3D RSA_PKCS1_PADDING &amp;&amp; padding !=3D R=
SA_NO_PADDING)</span><br><span>     {</span><br><span>@@ -1509,15 +1503,11 =
@@</span><br><span>         return -1;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D get_s=
ig_from_man(from, flen, to, len, get_rsa_padding_name(padding));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D get_sig_from_m=
an(from, flen, to, len, get_rsa_padding_name(padding));</span><br><span> </=
span><br><span>     return (ret =3D=3D len) ? ret : -1;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> static int</span><br><span> tls_ctx_use_external_=
rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)</span><br><span> {</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1493?usp=3Demail">change 1493</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1493?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8135a31b1f8f70ce0ddf63d765=
3f3d84a9e983f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1493 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--UB/FOUR1++8=--

