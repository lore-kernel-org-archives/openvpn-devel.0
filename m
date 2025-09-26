From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Sep 2025 20:50:39 +0000
In-Reply-To: <gerrit.1758719391000.I9ea87531afb553f789289787403900a4758b8e1c@...2715...>
References: <gerrit.1758719391000.I9ea87531afb553f789289787403900a4758b8e1c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <63934d2131c53f0b4a1b75451dd0493c919e89cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UO3186VvLjg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_openssl: Use
 uint16_t internally for TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UO3186VvLjg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
12?usp=3Demail )

Change subject: ssl_openssl: Use uint16_t internally for TLS versions
......................................................................

ssl_openssl: Use uint16_t internally for TLS versions

libressl changed the API for the involved functions. Since
uint16_t is a true subset of int it should be safe to switch
to that for all OpenSSL variants.

One trivial drive-by fix in unrelated code to be able
to enable -Wconversion fully for the file. This just
adds a cast where the comment says we intend a cast.

Change-Id: I9ea87531afb553f789289787403900a4758b8e1c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1212
Message-Id: <20250924150300.29318-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59238230/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 7 insertions(+), 25 deletions(-)




diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 89deeaa..434df7d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -235,8 +235,8 @@
 }

 /** Convert internal version number to openssl version number */
-static int
-openssl_tls_version(int ver)
+static uint16_t
+openssl_tls_version(unsigned int ver)
 {
     if (ver =3D=3D TLS_VER_1_0)
     {
@@ -272,23 +272,18 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
-    int tls_ver_min =3D
+    uint16_t tls_ver_min =3D
         openssl_tls_version((ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SS=
LF_TLS_VERSION_MIN_MASK);
-    int tls_ver_max =3D
+    uint16_t tls_ver_max =3D
         openssl_tls_version((ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SS=
LF_TLS_VERSION_MAX_MASK);

     if (!tls_ver_min)
     {
         /* Enforce at least TLS 1.0 */
-        int cur_min =3D SSL_CTX_get_min_proto_version(ctx->ctx);
+        uint16_t cur_min =3D (uint16_t)SSL_CTX_get_min_proto_version(ctx->=
ctx);
         tls_ver_min =3D cur_min < TLS1_VERSION ? TLS1_VERSION : cur_min;
     }

@@ -387,7 +382,7 @@
             /* %.*s format specifier expects length of type int, so guaran=
tee */
             /* that length is small enough and cast to int. */
             msg(D_LOW, "No valid translation found for TLS cipher '%.*s'",
-                constrain_int(current_cipher_len, 0, 256), current_cipher);
+                constrain_int((int)current_cipher_len, 0, 256), current_ci=
pher);
         }
         else
         {
@@ -429,10 +424,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -2522,11 +2513,6 @@
     msg(D_HANDSHAKE, "%s%s%s%s%s", s1, s2, s3, s4, s5);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 show_available_tls_ciphers_list(const char *cipher_list, const char *tls_c=
ert_profile, bool tls13)
 {
@@ -2541,7 +2527,7 @@
 #if defined(TLS1_3_VERSION)
     if (tls13)
     {
-        SSL_CTX_set_min_proto_version(tls_ctx.ctx, openssl_tls_version(TLS=
_VER_1_3));
+        SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
         tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     else
@@ -2594,10 +2580,6 @@
     SSL_CTX_free(tls_ctx.ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Show the Elliptic curves that are available for us to use
  * in the OpenSSL library.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1212?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9ea87531afb553f789289787403900a4758b8e1c
Gerrit-Change-Number: 1212
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--UO3186VvLjg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1212?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">ssl_openssl: Use uint16_t internally for TLS =
versions<br><br>libressl changed the API for the involved functions. Since<=
br>uint16_t is a true subset of int it should be safe to switch<br>to that =
for all OpenSSL variants.<br><br>One trivial drive-by fix in unrelated code=
 to be able<br>to enable -Wconversion fully for the file. This just<br>adds=
 a cast where the comment says we intend a cast.<br><br>Change-Id: I9ea8753=
1afb553f789289787403900a4758b8e1c<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Acked-by: MaxF &lt;max@...2606...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1212<br>Message-Id: &lt;20250924150=
300.29318-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/m=
ailman/message/59238230/<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>1 file changed, 7 insertions(=
+), 25 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span=
><br><span>index 89deeaa..434df7d 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><sp=
an>@@ -235,8 +235,8 @@</span><br><span> }</span><br><span> </span><br><span=
> /** Convert internal version number to openssl version number */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-openssl_tls_version(int ver)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static uint16_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+openssl_tls_version(unsigned int ver=
)</span><br><span> {</span><br><span>     if (ver =3D=3D TLS_VER_1_0)</span=
><br><span>     {</span><br><span>@@ -272,23 +272,18 @@</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> static bool</span><br><span> tls_ctx_set_tls_versions(stru=
ct tls_root_ctx *ctx, unsigned int ssl_flags)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int tls_ver_min =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t tls_ver_min =3D=
</span><br><span>         openssl_tls_version((ssl_flags &gt;&gt; SSLF_TLS_=
VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int tls_ver_max =3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint16_t tls_ver_max =3D</span><br>=
<span>         openssl_tls_version((ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX=
_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK);</span><br><span> </span><br><span=
>     if (!tls_ver_min)</span><br><span>     {</span><br><span>         /* =
Enforce at least TLS 1.0 */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int cur_min =3D SSL_CTX_get_min_proto_version(ctx-&gt;ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t cur_=
min =3D (uint16_t)SSL_CTX_get_min_proto_version(ctx-&gt;ctx);</span><br><sp=
an>         tls_ver_min =3D cur_min &lt; TLS1_VERSION ? TLS1_VERSION : cur_=
min;</span><br><span>     }</span><br><span> </span><br><span>@@ -387,7 +38=
2,7 @@</span><br><span>             /* %.*s format specifier expects length=
 of type int, so guarantee */</span><br><span>             /* that length i=
s small enough and cast to int. */</span><br><span>             msg(D_LOW, =
&quot;No valid translation found for TLS cipher &#39;%.*s&#39;&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                constrain_i=
nt(current_cipher_len, 0, 256), current_cipher);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                constrain_int((int)current_cip=
her_len, 0, 256), current_cipher);</span><br><span>         }</span><br><sp=
an>         else</span><br><span>         {</span><br><span>@@ -429,10 +424=
,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid</span><br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, con=
st char *ciphers)</span><br><span> {</span><br><span>@@ -2522,11 +2513,6 @@=
</span><br><span>     msg(D_HANDSHAKE, &quot;%s%s%s%s%s&quot;, s1, s2, s3, =
s4, s5);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void</span><br><span> show_available_tls_ciphers_list(const c=
har *cipher_list, const char *tls_cert_profile, bool tls13)</span><br><span=
> {</span><br><span>@@ -2541,7 +2527,7 @@</span><br><span> #if defined(TLS1=
_3_VERSION)</span><br><span>     if (tls13)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        SSL_CTX_set_min_proto_=
version(tls_ctx.ctx, openssl_tls_version(TLS_VER_1_3));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        SSL_CTX_set_min_proto_version(t=
ls_ctx.ctx, TLS1_3_VERSION);</span><br><span>         tls_ctx_restrict_ciph=
ers_tls13(&amp;tls_ctx, cipher_list);</span><br><span>     }</span><br><spa=
n>     else</span><br><span>@@ -2594,10 +2580,6 @@</span><br><span>     SSL=
_CTX_free(tls_ctx.ctx);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</sp=
an><br><span>  * Show the Elliptic curves that are available for us to use<=
/span><br><span>  * in the OpenSSL library.</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1212?u=
sp=3Demail">change 1212</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1212?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9ea87531afb553f789289787403=
900a4758b8e1c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1212 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--UO3186VvLjg=--

