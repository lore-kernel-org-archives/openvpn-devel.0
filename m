From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Feb 2026 12:02:53 +0000
References: <gerrit.1770379369000.I73dba29719ea685f0427a3c479e7f1f176f09eba@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0bbef77c5bce85dabceff60224461208ee720672-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lz/fbVcnvLk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: auth_token: Clean up
 type handling in verify_auth_token and its UT
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

--Lz/fbVcnvLk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1510?usp=3Demail

to review the following change.


Change subject: auth_token: Clean up type handling in verify_auth_token and=
 its UT
......................................................................

auth_token: Clean up type handling in verify_auth_token and its UT

First of all remove the testing of renegotiation_seconds.
Commit 9a5161704173e31f2510d3f5c29361f76e275d0f made it
irrelevant for verify_auth_token but still left UTs for it.
But AFAICT these UTs only test that renegotiation_seconds
is bigger than auth_token_renewal, so it tests the UT
setup routine...

Also improve the code to require less casts under
-Wsign-compare.

Add a comment that this code is not y38 safe if time_t
is 32bit. Probably nothing we want to do from our side
since in that case everything that uses "now" is borked.
So we trust in the OS here...

Change-Id: I73dba29719ea685f0427a3c479e7f1f176f09eba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/auth_token.c
M tests/unit_tests/openvpn/test_auth_token.c
2 files changed, 22 insertions(+), 38 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1510/1

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index eb2b4d5..d8ca125 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -287,11 +287,6 @@
     return memcmp_constant_time(&hmac_output, hmac, 32) =3D=3D 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 unsigned int
 verify_auth_token(struct user_pass *up, struct tls_multi *multi, struct tl=
s_session *session)
 {
@@ -318,7 +313,7 @@

     const uint8_t *sessid =3D b64decoded;
     const uint8_t *tstamp_initial =3D sessid + AUTH_TOKEN_SESSION_ID_LEN;
-    const uint8_t *tstamp =3D tstamp_initial + sizeof(int64_t);
+    const uint8_t *tstamp =3D tstamp_initial + sizeof(uint64_t);

     /* tstamp, tstamp_initial might not be aligned to an uint64, use memcpy
      * to avoid unaligned access */
@@ -348,9 +343,11 @@
     }

     /* Accept session tokens only if their timestamp is in the acceptable =
range
-     * for renegotiations */
-    bool in_renegotiation_time =3D
-        now >=3D timestamp && now < timestamp + 2 * session->opt->auth_tok=
en_renewal;
+     * for renegotiations.
+     * Cast is required for systems with 32bit time_t, e.g. Windows x86.
+     */
+    const time_t token_reneg_deadline =3D (time_t)timestamp + 2 * session-=
>opt->auth_token_renewal;
+    bool in_renegotiation_time =3D now >=3D (time_t)timestamp && now < tok=
en_reneg_deadline;

     if (!in_renegotiation_time)
     {
@@ -369,7 +366,8 @@
         ret |=3D AUTH_TOKEN_EXPIRED;
     }

-    if (multi->opt.auth_token_lifetime && now > timestamp_initial + multi-=
>opt.auth_token_lifetime)
+    const time_t token_eol =3D (time_t)timestamp_initial + multi->opt.auth=
_token_lifetime;
+    if (multi->opt.auth_token_lifetime && now > token_eol)
     {
         ret |=3D AUTH_TOKEN_EXPIRED;
     }
@@ -396,10 +394,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 wipe_auth_token(struct tls_multi *multi)
 {
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index 82c20c1..30d55f6 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -166,20 +166,19 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);
 }

-/* Note: only on 32bit Windows builds */
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 auth_token_test_timeout(void **state)
 {
     struct test_context *ctx =3D (struct test_context *)*state;

-    now =3D 100000;
+    const time_t initial_time =3D 100000;
+    now =3D initial_time;
     generate_auth_token(&ctx->up, &ctx->multi);

+    const time_t token_renew_window =3D
+        initial_time + 2 * ctx->session->opt->auth_token_renewal;
+    const time_t token_eol =3D initial_time + ctx->session->opt->auth_toke=
n_lifetime + 1;
+
     strcpy(ctx->up.password, ctx->multi.auth_token);
     free(ctx->multi.auth_token_initial);
     ctx->multi.auth_token_initial =3D NULL;
@@ -188,26 +187,21 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);

     /* Token before validity, should be rejected */
-    now =3D 100000 - 100;
+    now =3D initial_time - 100;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);

-    /* Token no valid for renegotiate_seconds but still for renewal_time */
-    now =3D 100000 + 2 * ctx->session->opt->renegotiate_seconds - 20;
-    assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
),
-                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
-
-
-    now =3D 100000 + 2 * ctx->session->opt->auth_token_renewal - 20;
+    /* Token still valid for renewal_time */
+    now =3D token_renew_window - 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);

     /* Token past validity, should be rejected */
-    now =3D 100000 + 2 * ctx->session->opt->renegotiate_seconds + 20;
+    now =3D token_renew_window + 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);

-    /* But not when we reached our timeout */
-    now =3D 100000 + ctx->session->opt->auth_token_lifetime + 1;
+    /* Token past lifetime, should be rejected */
+    now =3D token_eol;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
),
                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);

@@ -215,8 +209,8 @@
     ctx->multi.auth_token_initial =3D NULL;

     /* regenerate the token util it hits the expiry */
-    now =3D 100000;
-    while (now < 100000 + ctx->session->opt->auth_token_lifetime + 1)
+    now =3D initial_time;
+    while (now < token_eol)
     {
         assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->ses=
sion),
                          AUTH_TOKEN_HMAC_OK);
@@ -234,10 +228,6 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 zerohmac(char *token)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1510?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73dba29719ea685f0427a3c479e7f1f176f09eba
Gerrit-Change-Number: 1510
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Lz/fbVcnvLk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1510?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">auth_token: Clean up type handling in verif=
y_auth_token and its UT<br><br>First of all remove the testing of renegotia=
tion_seconds.<br>Commit 9a5161704173e31f2510d3f5c29361f76e275d0f made it<br=
>irrelevant for verify_auth_token but still left UTs for it.<br>But AFAICT =
these UTs only test that renegotiation_seconds<br>is bigger than auth_token=
_renewal, so it tests the UT<br>setup routine...<br><br>Also improve the co=
de to require less casts under<br>-Wsign-compare.<br><br>Add a comment that=
 this code is not y38 safe if time_t<br>is 32bit. Probably nothing we want =
to do from our side<br>since in that case everything that uses &quot;now&qu=
ot; is borked.<br>So we trust in the OS here...<br><br>Change-Id: I73dba297=
19ea685f0427a3c479e7f1f176f09eba<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>---<br>M src/openvpn/auth_token.c<br>M tests/unit_tes=
ts/openvpn/test_auth_token.c<br>2 files changed, 22 insertions(+), 38 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/10/1510/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token.=
c b/src/openvpn/auth_token.c</span><br><span>index eb2b4d5..d8ca125 100644<=
/span><br><span>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/op=
envpn/auth_token.c</span><br><span>@@ -287,11 +287,6 @@</span><br><span>   =
  return memcmp_constant_time(&amp;hmac_output, hmac, 32) =3D=3D 0;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> unsigned int</span><br><span> verify_auth_token(struct user_pass *up, str=
uct tls_multi *multi, struct tls_session *session)</span><br><span> {</span=
><br><span>@@ -318,7 +313,7 @@</span><br><span> </span><br><span>     const=
 uint8_t *sessid =3D b64decoded;</span><br><span>     const uint8_t *tstamp=
_initial =3D sessid + AUTH_TOKEN_SESSION_ID_LEN;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const uint8_t *tstamp =3D tstamp_initial + s=
izeof(int64_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const uint8_t *tstamp =3D tstamp_initial + sizeof(uint64_t);</span><br><spa=
n> </span><br><span>     /* tstamp, tstamp_initial might not be aligned to =
an uint64, use memcpy</span><br><span>      * to avoid unaligned access */<=
/span><br><span>@@ -348,9 +343,11 @@</span><br><span>     }</span><br><span=
> </span><br><span>     /* Accept session tokens only if their timestamp is=
 in the acceptable range</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     * for renegotiations */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bool in_renegotiation_time =3D</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        now &gt;=3D timestamp &amp;&amp; now &lt; ti=
mestamp + 2 * session-&gt;opt-&gt;auth_token_renewal;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * for renegotiations.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * Cast is required for system=
s with 32bit time_t, e.g. Windows x86.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const time_t token_reneg_deadline =3D (time_t)timestamp + 2 * se=
ssion-&gt;opt-&gt;auth_token_renewal;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool in_renegotiation_time =3D now &gt;=3D (time_t)ti=
mestamp &amp;&amp; now &lt; token_reneg_deadline;</span><br><span> </span><=
br><span>     if (!in_renegotiation_time)</span><br><span>     {</span><br>=
<span>@@ -369,7 +366,8 @@</span><br><span>         ret |=3D AUTH_TOKEN_EXPI=
RED;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (multi-&gt;opt.auth_token_lifetime &amp;&amp=
; now &gt; timestamp_initial + multi-&gt;opt.auth_token_lifetime)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const time_t token_eol =
=3D (time_t)timestamp_initial + multi-&gt;opt.auth_token_lifetime;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;opt.auth_t=
oken_lifetime &amp;&amp; now &gt; token_eol)</span><br><span>     {</span><=
br><span>         ret |=3D AUTH_TOKEN_EXPIRED;</span><br><span>     }</span=
><br><span>@@ -396,10 +394,6 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> wipe_auth_token(st=
ruct tls_multi *multi)</span><br><span> {</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth=
_token.c</span><br><span>index 82c20c1..30d55f6 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_auth_token.c</span><br><span>@@ -166,20 +166,19 @@</s=
pan><br><span>     assert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp=
;ctx-&gt;multi, ctx-&gt;session), AUTH_TOKEN_HMAC_OK);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* No=
te: only on 32bit Windows builds */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &q=
uot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static void</span><br><span> auth_token_test_timeout(void **state)</s=
pan><br><span> {</span><br><span>     struct test_context *ctx =3D (struct =
test_context *)*state;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    now =3D 100000;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const time_t initial_time =3D 100000;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    now =3D initial_time;</span><b=
r><span>     generate_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst time_t token_renew_window =3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        initial_time + 2 * ctx-&gt;session-&gt;opt-&gt;auth_t=
oken_renewal;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst time_t token_eol =3D initial_time + ctx-&gt;session-&gt;opt-&gt;auth_to=
ken_lifetime + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     strcpy(ctx-&gt;up.password, ctx-&gt;multi.auth_token);<=
/span><br><span>     free(ctx-&gt;multi.auth_token_initial);</span><br><spa=
n>     ctx-&gt;multi.auth_token_initial =3D NULL;</span><br><span>@@ -188,2=
6 +187,21 @@</span><br><span>     assert_int_equal(verify_auth_token(&amp;c=
tx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session), AUTH_TOKEN_HMAC_OK);</span=
><br><span> </span><br><span>     /* Token before validity, should be rejec=
ted */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    now =3D 100=
000 - 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =
=3D initial_time - 100;</span><br><span>     assert_int_equal(verify_auth_t=
oken(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session),</span><br><span=
>                      AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Token n=
o valid for renegotiate_seconds but still for renewal_time */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    now =3D 100000 + 2 * ctx-&gt;se=
ssion-&gt;opt-&gt;renegotiate_seconds - 20;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_int_equal(verify_auth_token(&amp;ctx-&gt;u=
p, &amp;ctx-&gt;multi, ctx-&gt;session),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXP=
IRED);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    now =3D 100000 + 2 * ctx-&gt;session-&gt;opt-&gt;auth=
_token_renewal - 20;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Token still valid for renewal_time */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    now =3D token_renew_window - 20;</span><br><s=
pan>     assert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;m=
ulti, ctx-&gt;session), AUTH_TOKEN_HMAC_OK);</span><br><span> </span><br><s=
pan>     /* Token past validity, should be rejected */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    now =3D 100000 + 2 * ctx-&gt;session-&=
gt;opt-&gt;renegotiate_seconds + 20;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    now =3D token_renew_window + 20;</span><br><span>     =
assert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx=
-&gt;session),</span><br><span>                      AUTH_TOKEN_HMAC_OK | A=
UTH_TOKEN_EXPIRED);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* But not when we reached our timeout */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    now =3D 100000 + ctx-&gt;sessio=
n-&gt;opt-&gt;auth_token_lifetime + 1;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Token past lifetime, should be rejected */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D token_eol;</sp=
an><br><span>     assert_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;=
ctx-&gt;multi, ctx-&gt;session),</span><br><span>                      AUTH=
_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);</span><br><span> </span><br><span>@@ =
-215,8 +209,8 @@</span><br><span>     ctx-&gt;multi.auth_token_initial =3D =
NULL;</span><br><span> </span><br><span>     /* regenerate the token util i=
t hits the expiry */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   now =3D 100000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 while (now &lt; 100000 + ctx-&gt;session-&gt;opt-&gt;auth_token_lifetime +=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    now =3D init=
ial_time;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
(now &lt; token_eol)</span><br><span>     {</span><br><span>         assert=
_int_equal(verify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;s=
ession),</span><br><span>                          AUTH_TOKEN_HMAC_OK);</sp=
an><br><span>@@ -234,10 +228,6 @@</span><br><span>     assert_int_equal(ver=
ify_auth_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session), AUTH_=
TOKEN_HMAC_OK);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</=
span><br><span> zerohmac(char *token)</span><br><span> {</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1510?usp=3Demail">change 1510</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1510?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73dba29719ea685f0427a3c479e=
7f1f176f09eba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1510 </div>
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

--Lz/fbVcnvLk=--

