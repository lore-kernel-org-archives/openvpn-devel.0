From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 20:53:20 +0000
In-Reply-To: <gerrit.1754655145000.Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152@...2715...>
References: <gerrit.1754655145000.Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4103ac6dfb10cf8daeca2b50dc77e717414621a2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kzmrOlQPXJU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kzmrOlQPXJU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Review CMocka assertion usage
......................................................................

Review CMocka assertion usage

Replace some assert_true calls with more specific
assertions. This should improve reporting in case
of problems and also just makes the code nicer.

Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1141
Message-Id: <20251006204118.26237-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243096/
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_provider.c
M tests/unit_tests/openvpn/test_tls_crypt.c
4 files changed, 27 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1141/4

diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index a2a10ea..68e4693 100644
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
index 0eacbab..ec71bc3 100644
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
index 950ce26..6fe64b2 100644
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
=20
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152
Gerrit-Change-Number: 1141
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--kzmrOlQPXJU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1141?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Review CMocka assertion usage<br><b=
r>Replace some assert_true calls with more specific<br>assertions. This sho=
uld improve reporting in case<br>of problems and also just makes the code n=
icer.<br><br>Change-Id: Ia2f374476c87855bba6c0f9d3e2f28a5fe62a152<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1141<br>Message-Id: &lt;20251006204118.26237-1-gert@...1296...&gt;<br=
>URL: https://sourceforge.net/p/openvpn/mailman/message/59243096/<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/=
openvpn/test_auth_token.c<br>M tests/unit_tests/openvpn/test_packet_id.c<br=
>M tests/unit_tests/openvpn/test_provider.c<br>M tests/unit_tests/openvpn/t=
est_tls_crypt.c<br>4 files changed, 27 insertions(+), 29 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/41/1141/4</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_auth_t=
oken.c b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>index a=
2a10ea..68e4693 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
auth_token.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token=
.c</span><br><span>@@ -286,9 +286,9 @@</span><br><span>     strcpy(ctx-&gt;=
up.password, ctx-&gt;multi.auth_token);</span><br><span>     assert_int_equ=
al(verify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session),=
 AUTH_TOKEN_HMAC_OK);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_int_not_equal(0, memcmp(ctx-&gt;multi.auth_tok=
en_initial + strlen(SESSION_ID_PREFIX),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                   token_sessiona + strle=
n(SESSION_ID_PREFIX),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                   AUTH_TOKEN_SESSION_ID_BASE64_LEN));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_not_eq=
ual(ctx-&gt;multi.auth_token_initial + strlen(SESSION_ID_PREFIX),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            t=
oken_sessiona + strlen(SESSION_ID_PREFIX),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            AUTH_TOKEN_SESSION_ID_BA=
SE64_LEN);</span><br><span> </span><br><span>     /* The first token is val=
id but should trigger the invalid response since</span><br><span>      * th=
e session id is not the same */</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</sp=
an><br><span>index 0eacbab..ec71bc3 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_packet_id.c</span><br><span>@@ -82,9 +82,9 @@</span><br><span> </s=
pan><br><span>     now =3D 5010;</span><br><span>     assert_true(packet_id=
_write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, false, false));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;pis.id=
 =3D=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_=
time =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(data-&gt;pis.id, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf_id, htonl=
(1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(data-&gt;test_buf_data.buf_time, 0);</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span>@@ -96,8 +96,8 @@</span>=
<br><span>     assert_true(packet_id_write(&amp;data-&gt;pis, &amp;data-&gt=
;test_buf, true, false));</span><br><span>     assert_int_equal(data-&gt;pi=
s.id, 1);</span><br><span>     assert_int_equal(data-&gt;pis.time, now);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt=
;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_time =3D=3D ht=
onl((uint32_t)now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(data-&gt;test_buf_data.buf_id, htonl(1));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;t=
est_buf_data.buf_time, htonl((uint32_t)now));</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span>@@ -108,9 +108,9 @@</s=
pan><br><span>     data-&gt;test_buf.offset =3D sizeof(packet_id_type);</sp=
an><br><span>     now =3D 5010;</span><br><span>     assert_true(packet_id_=
write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, false, true));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;pis.id =
=3D=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_=
time =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(data-&gt;pis.id, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_data.buf_id, htonl=
(1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(data-&gt;test_buf_data.buf_time, 0);</span><br><span> }</span><br><s=
pan> </span><br><span> static void</span><br><span>@@ -123,8 +123,8 @@</spa=
n><br><span>     assert_true(packet_id_write(&amp;data-&gt;pis, &amp;data-&=
gt;test_buf, true, true));</span><br><span>     assert_int_equal(data-&gt;p=
is.id, 1);</span><br><span>     assert_int_equal(data-&gt;pis.time, now);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&g=
t;test_buf_data.buf_id =3D=3D htonl(1));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    assert_true(data-&gt;test_buf_data.buf_time =3D=3D h=
tonl((uint32_t)now));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(data-&gt;test_buf_data.buf_id, htonl(1));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;=
test_buf_data.buf_time, htonl((uint32_t)now));</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span>@@ -156,8 +156,8 @@</=
span><br><span> </span><br><span>     assert_int_equal(data-&gt;pis.id, 1);=
</span><br><span>     assert_int_equal(data-&gt;pis.time, now);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(data-&gt;test_buf=
_data.buf_id =3D=3D htonl(1));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_true(data-&gt;test_buf_data.buf_time =3D=3D htonl((uint=
32_t)now));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(data-&gt;test_buf_data.buf_id, htonl(1));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;test_buf_d=
ata.buf_time, htonl((uint32_t)now));</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c</span><br=
><span>index 463b394..48adb96 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_provider.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_provider.c</span><br><span>@@ -287,9 +287,9 @@</span><br><span>     for (=
size_t i =3D 0; i &lt; _countof(pubkeys); i++)</span><br><span>     {</span=
><br><span>         pubkey =3D load_pubkey(pubkeys[i]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        assert_true(pubkey !=3D NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_non_nul=
l(pubkey);</span><br><span>         EVP_PKEY *privkey =3D xkey_load_managem=
ent_key(NULL, pubkey);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        assert_true(privkey !=3D NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_non_null(privkey);</span><br><span> </s=
pan><br><span>         management-&gt;settings.flags =3D MF_EXTERNAL_KEY | =
MF_EXTERNAL_KEY_PSSPAD;</span><br><span> </span><br><span>@@ -384,11 +384,1=
1 @@</span><br><span>     for (size_t i =3D 0; i &lt; _countof(pubkeys); i+=
+)</span><br><span>     {</span><br><span>         pubkey =3D load_pubkey(p=
ubkeys[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        as=
sert_true(pubkey !=3D NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        assert_non_null(pubkey);</span><br><span> </span><br><span=
>         EVP_PKEY *privkey =3D</span><br><span>             xkey_load_gene=
ric_key(NULL, (void *)dummy, pubkey, xkey_sign, xkey_free);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        assert_true(privkey !=3D NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_no=
n_null(privkey);</span><br><span> </span><br><span>         xkey_sign_calle=
d =3D 0;</span><br><span>         xkey_free_called =3D 0;</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/op=
envpn/test_tls_crypt.c</span><br><span>index 950ce26..6fe64b2 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -487,9 +4=
87,8 @@</span><br><span>     assert_true(tls_crypt_v2_unwrap_client_key(&am=
p;unwrapped_client_key2, &amp;unwrap_metadata,</span><br><span>            =
                                    wrapped_client_key, &amp;ctx-&gt;server=
_keys.decrypt));</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_true(0</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                =3D=3D memcmp(ctx-&gt;client_key2.keys, unwrapped_=
client_key2.keys,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      sizeof(ctx-&gt;client_key2.keys)));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(ctx-&gt;clien=
t_key2.keys, unwrapped_client_key2.keys,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        sizeof(ctx-&gt;client_key2.key=
s));</span><br><span> }</span><br><span> </span><br><span> /**</span><br><s=
pan>@@ -511,9 +510,8 @@</span><br><span>     assert_true(tls_crypt_v2_unwra=
p_client_key(&amp;unwrapped_client_key2, &amp;unwrap_metadata, ctx-&gt;wkc,=
</span><br><span>                                                &amp;ctx-&=
gt;server_keys.decrypt));</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_true(0</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                =3D=3D memcmp(ctx-&gt;client_key2.keys, u=
nwrapped_client_key2.keys,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                          sizeof(ctx-&gt;client_key2.keys)));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(ctx-=
&gt;client_key2.keys, unwrapped_client_key2.keys,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        sizeof(ctx-&gt;client=
_key2.keys));</span><br><span>     assert_true(buf_equal(&amp;ctx-&gt;metad=
ata, &amp;unwrap_metadata));</span><br><span> </span><br><span>     struct =
tls_wrap_ctx wrap_ctx =3D {</span><br><span>@@ -563,8 +561,8 @@</span><br><=
span>                                                 ctx-&gt;wkc, &amp;ctx=
-&gt;server_keys.decrypt));</span><br><span> </span><br><span>     const st=
ruct key2 zero =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_true(0 =3D=3D memcmp(&amp;unwrapped_client_key2, &amp;zero, =
sizeof(zero)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as=
sert_true(0 =3D=3D BLEN(&amp;ctx-&gt;unwrapped_metadata));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;unwrapp=
ed_client_key2, &amp;zero, sizeof(zero));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(0, BLEN(&amp;ctx-&gt;unwrapped_m=
etadata));</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span>@@ -587,8 +585,8 @@</span><br><span>                             =
                    ctx-&gt;wkc, &amp;ctx-&gt;server_keys.decrypt));</span>=
<br><span> </span><br><span>     const struct key2 zero =3D { 0 };</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(0 =3D=3D memcm=
p(&amp;unwrapped_client_key2, &amp;zero, sizeof(zero)));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_true(0 =3D=3D BLEN(&amp;ctx-&=
gt;unwrapped_metadata));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_memory_equal(&amp;unwrapped_client_key2, &amp;zero, sizeof(=
zero));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(0, BLEN(&amp;ctx-&gt;unwrapped_metadata));</span><br><span> }</spa=
n><br><span> </span><br><span> static void</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1141?us=
p=3Demail">change 1141</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1141?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2f374476c87855bba6c0f9d3e2=
f28a5fe62a152 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1141 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--kzmrOlQPXJU=--

