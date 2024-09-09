From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 06:06:18 +0000
In-Reply-To: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
References: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cd98332ef45a5f632e5461718f2b63e961ef8f6b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XrW6iaIJ9CE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add a test for
 loading certificate and key using file: URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XrW6iaIJ9CE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/73=
0?usp=3Demail )

Change subject: Add a test for loading certificate and key using file: URI
......................................................................

Add a test for loading certificate and key using file: URI

We do not load any providers, so only file: URI internally supported by
OpenSSL 3+ is tested. On non-OpenSSL 3 builds the test prints "SKIPPED".

v2: avoid dead code; rebase to current master

Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240906103900.37037-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
076.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 44 insertions(+), 0 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index a5c58a0..a1ca344 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -66,6 +66,10 @@
 }
 #endif

+#if defined(ENABLE_CRYPTO_OPENSSL) && (OPENSSL_VERSION_NUMBER > 0x30000000=
L)
+#define HAVE_OPENSSL_STORE
+#endif
+
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 bool
 get_user_pass_cr(struct user_pass *up, const char *auth_file, const char *=
prefix,
@@ -234,6 +238,45 @@
     tls_ctx_free(&ctx);
 }

+/* test loading cert and key using file:/path URI */
+static void
+test_load_certificate_and_key_uri(void **state)
+{
+    (void) state;
+
+#if !defined(HAVE_OPENSSL_STORE)
+    skip();
+#else /* HAVE_OPENSSL_STORE */
+
+    struct tls_root_ctx ctx =3D { 0 };
+    const char *certfile =3D global_state.certfile;
+    const char *keyfile =3D global_state.keyfile;
+    struct gc_arena *gc =3D &global_state.gc;
+
+    struct buffer certuri =3D alloc_buf_gc(6 + strlen(certfile) + 1, gc); =
/* 6 bytes for "file:/" */
+    struct buffer keyuri =3D alloc_buf_gc(6 + strlen(keyfile) + 1, gc);   =
/* 6 bytes for "file:/" */
+
+    /* Windows temp file path starts with drive letter -- add a leading sl=
ash for URI */
+    const char *lead =3D "";
+#ifdef _WIN32
+    lead =3D "/";
+#endif /* _WIN32 */
+    assert_true(buf_printf(&certuri, "file:%s%s", lead, certfile));
+    assert_true(buf_printf(&keyuri, "file:%s%s", lead, keyfile));
+
+    /* On Windows replace any '\' in path by '/' required for URI */
+#ifdef _WIN32
+    string_mod(BSTR(&certuri), CC_ANY, CC_BACKSLASH, '/');
+    string_mod(BSTR(&keyuri), CC_ANY, CC_BACKSLASH, '/');
+#endif /* _WIN32 */
+
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, BSTR(&certuri), false);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, BSTR(&keyuri), false), 0=
);
+    tls_ctx_free(&ctx);
+#endif /* HAVE_OPENSSL_STORE */
+}
+
 static void
 init_implicit_iv(struct crypto_options *co)
 {
@@ -469,6 +512,7 @@
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_certificate),
         cmocka_unit_test(test_load_certificate_and_key),
+        cmocka_unit_test(test_load_certificate_and_key_uri),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/730?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea
Gerrit-Change-Number: 730
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--XrW6iaIJ9CE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/730?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add a test for loading certificate and key usi=
ng file: URI<br><br>We do not load any providers, so only file: URI interna=
lly supported by<br>OpenSSL 3+ is tested. On non-OpenSSL 3 builds the test =
prints &quot;SKIPPED&quot;.<br><br>v2: avoid dead code; rebase to current m=
aster<br><br>Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea<br>Signed=
-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240906103900.37037-1-fra=
nk@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg29076.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M tests/unit_tests/openvpn/test_ssl.c<br>1 file changed=
, 44 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>index a5c58a0..a1ca344 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>@@ -66,6 +66,10 @@</span><br><sp=
an> }</span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; (=
OPENSSL_VERSION_NUMBER &gt; 0x30000000L)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define HAVE_OPENSSL_STORE</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /* stubs for some unused functions instead=
 of pulling in too many dependencies */</span><br><span> bool</span><br><sp=
an> get_user_pass_cr(struct user_pass *up, const char *auth_file, const cha=
r *prefix,</span><br><span>@@ -234,6 +238,45 @@</span><br><span>     tls_ct=
x_free(&amp;ctx);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* test loading cert and key using file:=
/path URI */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_load_certi=
ficate_and_key_uri(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (=
void) state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(HAVE_OPENSSL_=
STORE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    skip();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* HAVE_OPENSSL=
_STORE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_root_ctx ctx =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *certfile =3D global_state.certfile;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *keyfile =3D global_state.keyfile;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena *g=
c =3D &amp;global_state.gc;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer certuri =3D alloc_buf_gc(6 + strlen(certfile) + 1, gc); /* 6 bytes f=
or &quot;file:/&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer keyuri =3D alloc_buf_gc(6 + strlen(keyfile) + 1, gc)=
;   /* 6 bytes for &quot;file:/&quot; */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Windows temp file path starts with drive letter -- add a leading s=
lash for URI */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *lead =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    lead =3D &quot;/&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif /* _WIN32 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_printf(&amp;certuri, &quot;file:%s%s&q=
uot;, lead, certfile));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(buf_printf(&amp;keyuri, &quot;file:%s%s&quot;, lead, ke=
yfile));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* On Windows replace any =
&#39;\&#39; in path by &#39;/&#39; required for URI */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    string_mod(BSTR(&amp;certuri), CC_ANY, CC_=
BACKSLASH, &#39;/&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    string_mod(BSTR(&amp;keyuri), CC_ANY, CC_BACKSLASH, &#39;/&#39;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_client_new(&amp;ctx);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_load_cert_fil=
e(&amp;ctx, BSTR(&amp;certuri), false);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, B=
STR(&amp;keyuri), false), 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    tls_ctx_free(&amp;ctx);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* HAVE_OPENSSL_STORE */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> static void</span><br><span> init_implicit_iv=
(struct crypto_options *co)</span><br><span> {</span><br><span>@@ -469,6 +5=
12,7 @@</span><br><span>     const struct CMUnitTest tests[] =3D {</span><b=
r><span>         cmocka_unit_test(crypto_pem_encode_certificate),</span><br=
><span>         cmocka_unit_test(test_load_certificate_and_key),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
load_certificate_and_key_uri),</span><br><span>         cmocka_unit_test(te=
st_data_channel_roundtrip_aes_128_gcm),</span><br><span>         cmocka_uni=
t_test(test_data_channel_roundtrip_aes_192_gcm),</span><br><span>         c=
mocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/730?usp=3Demail">change 730</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/730?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7615116b5251319aa1f13d671ba=
b7013f3a043ea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 730 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--XrW6iaIJ9CE=--

