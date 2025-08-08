From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Aug 2025 12:12:42 +0000
References: <gerrit.1754655145000.Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <19013507f787d631150824919834a46ee32d1d12-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u7U8CIPosgY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Review CMocka
 assertion usage
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

--u7U8CIPosgY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail

to review the following change.


Change subject: Review CMocka assertion usage
......................................................................

Review CMocka assertion usage

Replace some assert_true calls with more specific
assertions. This should improve reporting in case
of problems and also just makes the code nicer.

Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
4 files changed, 27 insertions(+), 29 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1141/1

diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index 0c5467e..e993409 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -286,9 +286,9 @@
     strcpy(ctx->up.password, ctx->multi.auth_token);
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);

-    assert_int_not_equal(0, memcmp(ctx->multi.auth_token_initial + strlen(=
SESSION_ID_PREFIX),
-                                   token_sessiona + strlen(SESSION_ID_PREF=
IX),
-                                   AUTH_TOKEN_SESSION_ID_BASE64_LEN));
+    assert_memory_not_equal(ctx->multi.auth_token_initial + strlen(SESSION=
_ID_PREFIX),
+                            token_sessiona + strlen(SESSION_ID_PREFIX),
+                            AUTH_TOKEN_SESSION_ID_BASE64_LEN);

     /* The first token is valid but should trigger the invalid response si=
nce
      * the session id is not the same */
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index d623c3d..85179cc 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -82,9 +82,9 @@

     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, false, false)=
);
-    assert_true(data->pis.id =3D=3D 1);
-    assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D 0);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, 0);
 }

 static void
@@ -96,8 +96,8 @@
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }

 static void
@@ -108,9 +108,9 @@
     data->test_buf.offset =3D sizeof(packet_id_type);
     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, false, true));
-    assert_true(data->pis.id =3D=3D 1);
-    assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D 0);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, 0);
 }

 static void
@@ -123,8 +123,8 @@
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, true));
     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }

 static void
@@ -156,8 +156,8 @@

     assert_int_equal(data->pis.id, 1);
     assert_int_equal(data->pis.time, now);
-    assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
-    assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
+    assert_int_equal(data->test_buf_data.buf_id, htonl(1));
+    assert_int_equal(data->test_buf_data.buf_time, htonl((uint32_t)now));
 }

 static void
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/op=
envpn/test_provider.c
index 463b394..48adb96 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -287,9 +287,9 @@
     for (size_t i =3D 0; i < _countof(pubkeys); i++)
     {
         pubkey =3D load_pubkey(pubkeys[i]);
-        assert_true(pubkey !=3D NULL);
+        assert_non_null(pubkey);
         EVP_PKEY *privkey =3D xkey_load_management_key(NULL, pubkey);
-        assert_true(privkey !=3D NULL);
+        assert_non_null(privkey);

         management->settings.flags =3D MF_EXTERNAL_KEY | MF_EXTERNAL_KEY_P=
SSPAD;

@@ -384,11 +384,11 @@
     for (size_t i =3D 0; i < _countof(pubkeys); i++)
     {
         pubkey =3D load_pubkey(pubkeys[i]);
-        assert_true(pubkey !=3D NULL);
+        assert_non_null(pubkey);

         EVP_PKEY *privkey =3D
             xkey_load_generic_key(NULL, (void *)dummy, pubkey, xkey_sign, =
xkey_free);
-        assert_true(privkey !=3D NULL);
+        assert_non_null(privkey);

         xkey_sign_called =3D 0;
         xkey_free_called =3D 0;
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 596f0e0..6ae26fb 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -487,9 +487,8 @@
     assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2, &un=
wrap_metadata,
                                                wrapped_client_key, &ctx->s=
erver_keys.decrypt));

-    assert_true(0
-                =3D=3D memcmp(ctx->client_key2.keys, unwrapped_client_key2=
.keys,
-                          sizeof(ctx->client_key2.keys)));
+    assert_memory_equal(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                        sizeof(ctx->client_key2.keys));
 }

 /**
@@ -511,9 +510,8 @@
     assert_true(tls_crypt_v2_unwrap_client_key(&unwrapped_client_key2, &un=
wrap_metadata, ctx->wkc,
                                                &ctx->server_keys.decrypt));

-    assert_true(0
-                =3D=3D memcmp(ctx->client_key2.keys, unwrapped_client_key2=
.keys,
-                          sizeof(ctx->client_key2.keys)));
+    assert_memory_equal(ctx->client_key2.keys, unwrapped_client_key2.keys,
+                        sizeof(ctx->client_key2.keys));
     assert_true(buf_equal(&ctx->metadata, &unwrap_metadata));

     struct tls_wrap_ctx wrap_ctx =3D {
@@ -563,8 +561,8 @@
                                                 ctx->wkc, &ctx->server_key=
s.decrypt));

     const struct key2 zero =3D { 0 };
-    assert_true(0 =3D=3D memcmp(&unwrapped_client_key2, &zero, sizeof(zero=
)));
-    assert_true(0 =3D=3D BLEN(&ctx->unwrapped_metadata));
+    assert_memory_equal(&unwrapped_client_key2, &zero, sizeof(zero));
+    assert_int_equal(0, BLEN(&ctx->unwrapped_metadata));
 }

 /**
@@ -587,8 +585,8 @@
                                                 ctx->wkc, &ctx->server_key=
s.decrypt));

     const struct key2 zero =3D { 0 };
-    assert_true(0 =3D=3D memcmp(&unwrapped_client_key2, &zero, sizeof(zero=
)));
-    assert_true(0 =3D=3D BLEN(&ctx->unwrapped_metadata));
+    assert_memory_equal(&unwrapped_client_key2, &zero, sizeof(zero));
+    assert_int_equal(0, BLEN(&ctx->unwrapped_metadata));
 }

 static void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152
Gerrit-Change-Number: 1141
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--u7U8CIPosgY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Review CMocka assertion usage<br><br>Replace some assert_tru=
e calls with more specific<br>assertions. This should improve reporting in =
case<br>of problems and also just makes the code nicer.<br><br>Change-Id: I=
a2f374476c87855bba6c0f9d3e2f28a5fe62a152<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_auth_t=
oken.c<br>M tests/unit_tests/openvpn/test_packet_id.c<br>M tests/unit_tests=
/openvpn/test_provider.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<br>=
4 files changed, 27 insertions(+), 29 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/41/1141/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn=
/test_auth_token.c</span><br><span>index 0c5467e..e993409 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>@@ -286,9 +286=
,9 @@</span><br><span>     strcpy(ctx-&gt;up.password, ctx-&gt;multi.auth_t=
oken);</span><br><span>     assert_int_equal(verify_auth_token(&amp;ctx-&gt=
;up, &amp;ctx-&gt;multi, ctx-&gt;session), AUTH_TOKEN_HMAC_OK);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_=
not_equal(0, memcmp(ctx-&gt;multi.auth_token_initial + strlen(SESSION_ID_PR=
EFIX),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                    token_sessiona + strlen(SESSION_ID_PREFIX),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
  AUTH_TOKEN_SESSION_ID_BASE64_LEN));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_memory_not_equal(ctx-&gt;multi.auth_token_init=
ial + strlen(SESSION_ID_PREFIX),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            token_sessiona + strlen(SESSION_ID=
_PREFIX),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                  AUTH_TOKEN_SESSION_ID_BASE64_LEN);</span><br><span> </spa=
n><br><span>     /* The first token is valid but should trigger the invalid=
 response since</span><br><span>      * the session id is not the same */</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tes=
ts/unit_tests/openvpn/test_packet_id.c</span><br><span>index d623c3d..85179=
cc 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_packet_id.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_packet_id.c</span><br><s=
pan>@@ -82,9 +82,9 @@</span><br><span> </span><br><span>     now =3D 5010;<=
/span><br><span>     assert_true(packet_id_write(&amp;data-&gt;pis, &amp;da=
ta-&gt;test_buf, false, false));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_true(data-&gt;pis.id =3D=3D 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_=
id =3D=3D htonl(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   assert_true(data-&gt;test_buf_data.buf_time =3D=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;pis.id,=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(data-&gt;test_buf_data.buf_id, htonl(1));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf=
_time, 0);</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span>@@ -96,8 +96,8 @@</span><br><span>     assert_true(packet=
_id_write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, true, false));</span><=
br><span>     assert_int_equal(data-&gt;pis.id, 1);</span><br><span>     as=
sert_int_equal(data-&gt;pis.time, now);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_id =3D=3D hton=
l(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true=
(data-&gt;test_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;te=
st_buf_data.buf_id, htonl(1));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf_time, htonl((uin=
t32_t)now));</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span>@@ -108,9 +108,9 @@</span><br><span>     data-&gt;test_=
buf.offset =3D sizeof(packet_id_type);</span><br><span>     now =3D 5010;</=
span><br><span>     assert_true(packet_id_write(&amp;data-&gt;pis, &amp;dat=
a-&gt;test_buf, false, true));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_true(data-&gt;pis.id =3D=3D 1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_=
id =3D=3D htonl(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   assert_true(data-&gt;test_buf_data.buf_time =3D=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;pis.id,=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(data-&gt;test_buf_data.buf_id, htonl(1));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf=
_time, 0);</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span>@@ -123,8 +123,8 @@</span><br><span>     assert_true(pack=
et_id_write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, true, true));</span>=
<br><span>     assert_int_equal(data-&gt;pis.id, 1);</span><br><span>     a=
ssert_int_equal(data-&gt;pis.time, now);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_id =3D=3D hto=
nl(1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_tru=
e(data-&gt;test_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;t=
est_buf_data.buf_id, htonl(1));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf_time, htonl((ui=
nt32_t)now));</span><br><span> }</span><br><span> </span><br><span> static =
void</span><br><span>@@ -156,8 +156,8 @@</span><br><span> </span><br><span>=
     assert_int_equal(data-&gt;pis.id, 1);</span><br><span>     assert_int_=
equal(data-&gt;pis.time, now);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt=
;test_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_da=
ta.buf_id, htonl(1));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(data-&gt;test_buf_data.buf_time, htonl((uint32_t)now=
));</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/un=
it_tests/openvpn/test_provider.c</span><br><span>index 463b394..48adb96 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_provider.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_provider.c</span><br><span>@@ -=
287,9 +287,9 @@</span><br><span>     for (size_t i =3D 0; i &lt; _countof(p=
ubkeys); i++)</span><br><span>     {</span><br><span>         pubkey =3D lo=
ad_pubkey(pubkeys[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        assert_true(pubkey !=3D NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        assert_non_null(pubkey);</span><br><span>      =
   EVP_PKEY *privkey =3D xkey_load_management_key(NULL, pubkey);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        assert_true(privkey !=3D=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asse=
rt_non_null(privkey);</span><br><span> </span><br><span>         management=
-&gt;settings.flags =3D MF_EXTERNAL_KEY | MF_EXTERNAL_KEY_PSSPAD;</span><br=
><span> </span><br><span>@@ -384,11 +384,11 @@</span><br><span>     for (si=
ze_t i =3D 0; i &lt; _countof(pubkeys); i++)</span><br><span>     {</span><=
br><span>         pubkey =3D load_pubkey(pubkeys[i]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        assert_true(pubkey !=3D NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_non_null(=
pubkey);</span><br><span> </span><br><span>         EVP_PKEY *privkey =3D</=
span><br><span>             xkey_load_generic_key(NULL, (void *)dummy, pubk=
ey, xkey_sign, xkey_free);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        assert_true(privkey !=3D NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        assert_non_null(privkey);</span><br><span>=
 </span><br><span>         xkey_sign_called =3D 0;</span><br><span>        =
 xkey_free_called =3D 0;</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br>=
<span>index 596f0e0..6ae26fb 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_tls_crypt.c</span><br><span>@@ -487,9 +487,8 @@</span><br><span>     asse=
rt_true(tls_crypt_v2_unwrap_client_key(&amp;unwrapped_client_key2, &amp;unw=
rap_metadata,</span><br><span>                                             =
   wrapped_client_key, &amp;ctx-&gt;server_keys.decrypt));</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                =3D=3D m=
emcmp(ctx-&gt;client_key2.keys, unwrapped_client_key2.keys,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                          sizeof(ctx-=
&gt;client_key2.keys)));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_memory_equal(ctx-&gt;client_key2.keys, unwrapped_client_key=
2.keys,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            sizeof(ctx-&gt;client_key2.keys));</span><br><span> }</span><br=
><span> </span><br><span> /**</span><br><span>@@ -511,9 +510,8 @@</span><br=
><span>     assert_true(tls_crypt_v2_unwrap_client_key(&amp;unwrapped_clien=
t_key2, &amp;unwrap_metadata, ctx-&gt;wkc,</span><br><span>                =
                                &amp;ctx-&gt;server_keys.decrypt));</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
true(0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 =3D=3D memcmp(ctx-&gt;client_key2.keys, unwrapped_client_key2.keys,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                          si=
zeof(ctx-&gt;client_key2.keys)));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_memory_equal(ctx-&gt;client_key2.keys, unwrapped_c=
lient_key2.keys,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     sizeof(ctx-&gt;client_key2.keys));</span><br><span>   =
  assert_true(buf_equal(&amp;ctx-&gt;metadata, &amp;unwrap_metadata));</spa=
n><br><span> </span><br><span>     struct tls_wrap_ctx wrap_ctx =3D {</span=
><br><span>@@ -563,8 +561,8 @@</span><br><span>                            =
                     ctx-&gt;wkc, &amp;ctx-&gt;server_keys.decrypt));</span=
><br><span> </span><br><span>     const struct key2 zero =3D { 0 };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(0 =3D=3D memc=
mp(&amp;unwrapped_client_key2, &amp;zero, sizeof(zero)));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_true(0 =3D=3D BLEN(&amp;ctx-=
&gt;unwrapped_metadata));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_memory_equal(&amp;unwrapped_client_key2, &amp;zero, sizeof=
(zero));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(0, BLEN(&amp;ctx-&gt;unwrapped_metadata));</span><br><span> }</sp=
an><br><span> </span><br><span> /**</span><br><span>@@ -587,8 +585,8 @@</sp=
an><br><span>                                                 ctx-&gt;wkc, =
&amp;ctx-&gt;server_keys.decrypt));</span><br><span> </span><br><span>     =
const struct key2 zero =3D { 0 };</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    assert_true(0 =3D=3D memcmp(&amp;unwrapped_client_key2, &am=
p;zero, sizeof(zero)));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_true(0 =3D=3D BLEN(&amp;ctx-&gt;unwrapped_metadata));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp=
;unwrapped_client_key2, &amp;zero, sizeof(zero));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(0, BLEN(&amp;ctx-&gt;unw=
rapped_metadata));</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail">change 1141</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1141?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2f374476c87855bba6c0f9d3e2=
f28a5fe62a152 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1141 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--u7U8CIPosgY=--

