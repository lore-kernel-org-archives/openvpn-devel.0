From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 11:16:19 +0000
References: <gerrit.1769512571000.Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <dc3990f5cd4a5bb87c07e83a3629ac172c437ec4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K5e3vnWQa/Q="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K5e3vnWQa/Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail

to review the following change.


Change subject: ssl_openssl: Use correct return type for RSA_size
......................................................................

ssl_openssl: Use correct return type for RSA_size

It returns int, so use that. Avoids a sign-compare
warning.

Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 2 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1493/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c61e4b2..d8c4587 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f
Gerrit-Change-Number: 1493
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--K5e3vnWQa/Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_openssl: Use correct return type for RS=
A_size<br><br>It returns int, so use that. Avoids a sign-compare<br>warning=
.<br><br>Change-Id: Ie8135a31b1f8f70ce0ddf63d7653f3d84a9e983f<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl=
_openssl.c<br>1 file changed, 2 insertions(+), 12 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/93/1493/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl=
_openssl.c</span><br><span>index c61e4b2..d8c4587 100644</span><br><span>--=
- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl=
.c</span><br><span>@@ -1491,17 +1491,11 @@</span><br><span>     return len;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored =
&quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> /* sign arbitrary data */</span><br><span> static int</span><br><sp=
an> rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RS=
A *rsa, int padding)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int len =3D RSA_size(rsa);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int len =3D RSA_size(rsa);</span><b=
r><span> </span><br><span>     if (padding !=3D RSA_PKCS1_PADDING &amp;&amp=
; padding !=3D RSA_NO_PADDING)</span><br><span>     {</span><br><span>@@ -1=
509,15 +1503,11 @@</span><br><span>         return -1;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   ret =3D get_sig_from_man(from, flen, to, len, get_rsa_padding_name(paddi=
ng));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D get_sig_from_man(from, flen, to, len, get_rsa_padding_name(padding));</=
span><br><span> </span><br><span>     return (ret =3D=3D len) ? ret : -1;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><span> tls=
_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)</span><=
br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail">change 1493</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1493?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8135a31b1f8f70ce0ddf63d765=
3f3d84a9e983f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1493 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--K5e3vnWQa/Q=--

