From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 19 Aug 2024 19:28:49 +0000
References: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <332ae535c38386d882f4a5d5556305eb7cdfe933-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gVo4ksGTtBM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gVo4ksGTtBM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/730?usp=3Demail

to review the following change.


Change subject: Add a test for loading certificate and key using file: URI
......................................................................

Add a test for loading certificate and key using file: URI

We do not load any providers, so only file: URI internally supported by
OpenSSL 3+ is tested. On non-OpenSSL 3 builds the test prints "SKIPPED".

Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 43 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/730/1

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 651f302..260a7ba 100644
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
@@ -234,6 +238,44 @@
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
+#endif /* HAVE_OPENSSL_STORE */
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
+}
+
 static void
 init_implicit_iv(struct crypto_options *co)
 {
@@ -452,6 +494,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gVo4ksGTtBM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/730?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add a test for loading certificate and key using file: URI<br=
><br>We do not load any providers, so only file: URI internally supported b=
y<br>OpenSSL 3+ is tested. On non-OpenSSL 3 builds the test prints &quot;SK=
IPPED&quot;.<br><br>Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea<br=
>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M tests/u=
nit_tests/openvpn/test_ssl.c<br>1 file changed, 43 insertions(+), 0 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/30/730/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests=
/unit_tests/openvpn/test_ssl.c</span><br><span>index 651f302..260a7ba 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -66,6 +66,10 =
@@</span><br><span> }</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENS=
SL) &amp;&amp; (OPENSSL_VERSION_NUMBER &gt; 0x30000000L)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define HAVE_OPENSSL_STORE</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* stubs for some unused f=
unctions instead of pulling in too many dependencies */</span><br><span> bo=
ol</span><br><span> get_user_pass_cr(struct user_pass *up, const char *auth=
_file, const char *prefix,</span><br><span>@@ -234,6 +238,44 @@</span><br><=
span>     tls_ctx_free(&amp;ctx);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* test loading cert and=
 key using file:/path URI */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_load_certificate_and_key_uri(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    (void) state;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defin=
ed(HAVE_OPENSSL_STORE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    skip();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f /* HAVE_OPENSSL_STORE */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct t=
ls_root_ctx ctx =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *certfile =3D global_state.certfile;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *keyfile =3D global_s=
tate.keyfile;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena *gc =3D &amp;global_state.gc;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer certuri =3D alloc_buf_gc(6 + strlen(certfile) + 1, g=
c); /* 6 bytes for &quot;file:/&quot; */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer keyuri =3D alloc_buf_gc(6 + strlen(k=
eyfile) + 1, gc);   /* 6 bytes for &quot;file:/&quot; */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Windows temp file path starts with drive letter --=
 add a leading slash for URI */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *lead =3D &quot;&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    lead =3D &quot;/&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_printf(&amp;certuri, =
&quot;file:%s%s&quot;, lead, certfile));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buf_printf(&amp;keyuri, &quot;file:%s%=
s&quot;, lead, keyfile));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* On Win=
dows replace any &#39;\&#39; in path by &#39;/&#39; required for URI */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    string_mod(BSTR(&amp;cert=
uri), CC_ANY, CC_BACKSLASH, &#39;/&#39;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    string_mod(BSTR(&amp;keyuri), CC_ANY, CC_BACKSLAS=
H, &#39;/&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_client_new=
(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
ctx_load_cert_file(&amp;ctx, BSTR(&amp;certuri), false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(tls_ctx_load_priv=
_file(&amp;ctx, BSTR(&amp;keyuri), false), 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    tls_ctx_free(&amp;ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static void</span><br><span> init_implic=
it_iv(struct crypto_options *co)</span><br><span> {</span><br><span>@@ -452=
,6 +494,7 @@</span><br><span>     const struct CMUnitTest tests[] =3D {</sp=
an><br><span>         cmocka_unit_test(crypto_pem_encode_certificate),</spa=
n><br><span>         cmocka_unit_test(test_load_certificate_and_key),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_load_certificate_and_key_uri),</span><br><span>         cmocka_unit_te=
st(test_data_channel_roundtrip_aes_128_gcm),</span><br><span>         cmock=
a_unit_test(test_data_channel_roundtrip_aes_192_gcm),</span><br><span>     =
    cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/730?usp=3Demail">change 730</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/730?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7615116b5251319aa1f13d671ba=
b7013f3a043ea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 730 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--gVo4ksGTtBM=--

