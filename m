From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:44:06 +0000
In-Reply-To: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
References: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3fa45cad9b25bdf424d70f6c5f9e14461dd132aa-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YlGTYY5qD00="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YlGTYY5qD00=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1493/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Gerrit-Change-Number: 1493
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YlGTYY5qD00=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl_ope=
nssl: Use correct return type for RSA_size<br><br>It returns int, so use th=
at. Avoids a sign-compare<br>warning.<br><br>Change-Id: Ie8135a31b1f8f70ce0=
ddf63d7653f3d84a9e983f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1493<br>Message-Id: &lt;20260304144028.2459-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg35890.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 2 insertions(+=
), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/93/1493/6</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 095f893..84=
0d9a0 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><spa=
n>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -1491,17 +1491,11 @@</=
span><br><span>     return len;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> /* sign arbitrary data */</span><br>=
<span> static int</span><br><span> rsa_priv_enc(int flen, const unsigned ch=
ar *from, unsigned char *to, RSA *rsa, int padding)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int len =3D R=
SA_size(rsa);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
len =3D RSA_size(rsa);</span><br><span> </span><br><span>     if (padding !=
=3D RSA_PKCS1_PADDING &amp;&amp; padding !=3D RSA_NO_PADDING)</span><br><sp=
an>     {</span><br><span>@@ -1509,15 +1503,11 @@</span><br><span>         =
return -1;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ret =3D get_sig_from_man(from, flen, to=
, len, get_rsa_padding_name(padding));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int ret =3D get_sig_from_man(from, flen, to, len, ge=
t_rsa_padding_name(padding));</span><br><span> </span><br><span>     return=
 (ret =3D=3D len) ? ret : -1;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
static int</span><br><span> tls_ctx_use_external_rsa_key(struct tls_root_ct=
x *ctx, EVP_PKEY *pkey)</span><br><span> {</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1493?us=
p=3Demail">change 1493</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1493?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--YlGTYY5qD00=--

