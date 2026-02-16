From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 13:18:33 +0000
References: <gerrit.1771247899000.I6298795f140c2c62252638f9e0cd6df19cb3d7ed@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f9c66e3e4aa6dc377b1e2a961ad6db9f8e954dc7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7o0W7oaUBdE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Mbed TLS 3: Remove
 prediction resistance option
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

--7o0W7oaUBdE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1530?usp=3Demail

to review the following change.


Change subject: Mbed TLS 3: Remove prediction resistance option
......................................................................

Mbed TLS 3: Remove prediction resistance option

The option --use-prediction-resistance causes the random number
generator to be reseeded for every call. This is excessive.

This commit removes that option.

Change-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
---
M doc/man-sections/generic-options.rst
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_mbedtls_legacy.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/syshead.h
7 files changed, 0 insertions(+), 69 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1530/1

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index ed581b1..f46dfec 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -462,16 +462,6 @@
     success/failure via :code:`auth_control_file` when using deferred auth
     method and pending authentication via :code:`auth_pending_file`.

---use-prediction-resistance
-  Enable prediction resistance on mbed TLS's RNG.
-
-  Enabling prediction resistance causes the RNG to reseed in each call for
-  random. Reseeding this often can quickly deplete the kernel entropy
-  pool.
-
-  If you need this option, please consider running a daemon that adds
-  entropy to the kernel pool.
-
 --user user
   Change the user ID of the OpenVPN process to ``user`` after
   initialization, dropping privileges in the process. This option is
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index a991349..b8e7d6a 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -366,16 +366,6 @@
     return &cd_ctx;
 }

-#ifdef ENABLE_PREDICTION_RESISTANCE
-void
-rand_ctx_enable_prediction_resistance(void)
-{
-    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
-
-    mbedtls_ctr_drbg_set_prediction_resistance(cd_ctx, 1);
-}
-#endif /* ENABLE_PREDICTION_RESISTANCE */
-
 int
 rand_bytes(uint8_t *output, int len)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedt=
ls_legacy.h
index af71037..1005057 100644
--- a/src/openvpn/crypto_mbedtls_legacy.h
+++ b/src/openvpn/crypto_mbedtls_legacy.h
@@ -89,14 +89,6 @@
  */
 mbedtls_ctr_drbg_context *rand_ctx_get(void);

-#ifdef ENABLE_PREDICTION_RESISTANCE
-/**
- * Enable prediction resistance on the random number generator.
- */
-void rand_ctx_enable_prediction_resistance(void);
-
-#endif
-
 /**
  * Log the supplied mbed TLS error, prefixed by supplied prefix.
  *
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 70c0b5d..1391aa85 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2989,13 +2989,6 @@
             packet_id_persist_load(&c->c1.pid_persist, c->options.packet_i=
d_file);
         }
     }
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    if (c->options.use_prediction_resistance)
-    {
-        rand_ctx_enable_prediction_resistance();
-    }
-#endif
 }


diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2bca647..51b4252 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -566,10 +566,6 @@
     "                  using file.\n"
     "--test-crypto   : Run a self-test of crypto features enabled.\n"
     "                  For debugging only.\n"
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    "--use-prediction-resistance: Enable prediction resistance on the rand=
om\n"
-    "                             number generator.\n"
-#endif
     "\n"
     "TLS Key Negotiation Options:\n"
     "(These options are meaningful only for TLS-mode)\n"
@@ -872,9 +868,6 @@
     o->replay_window =3D DEFAULT_SEQ_BACKTRACK;
     o->replay_time =3D DEFAULT_TIME_BACKTRACK;
     o->key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    o->use_prediction_resistance =3D false;
-#endif
     o->tls_timeout =3D 2;
     o->renegotiate_bytes =3D -1;
     o->renegotiate_seconds =3D 3600;
@@ -1841,9 +1834,6 @@
     SHOW_INT(replay_time);
     SHOW_STR(packet_id_file);
     SHOW_BOOL(test_crypto);
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    SHOW_BOOL(use_prediction_resistance);
-#endif

     SHOW_BOOL(tls_server);
     SHOW_BOOL(tls_client);
@@ -4476,13 +4466,6 @@
         {
             buf_printf(&out, ",secret");
         }
-
-#ifdef ENABLE_PREDICTION_RESISTANCE
-        if (o->use_prediction_resistance)
-        {
-            buf_printf(&out, ",use-prediction-resistance");
-        }
-#endif
     }

     /*
@@ -8543,13 +8526,6 @@
             options->providers.names[j] =3D p[j];
         }
     }
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    else if (streq(p[0], "use-prediction-resistance") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->use_prediction_resistance =3D true;
-    }
-#endif
     else if (streq(p[0], "show-tls") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 16cfdb5..cf9936b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -584,9 +584,6 @@
     int replay_time;
     const char *packet_id_file;
     bool test_crypto;
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    bool use_prediction_resistance;
-#endif

     /* TLS (control channel) parms */
     bool tls_server;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 582e130..7e742b3 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -474,13 +474,6 @@
 #define PORT_SHARE 0
 #endif

-#ifdef ENABLE_CRYPTO_MBEDTLS
-#include <mbedtls/version.h>
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#define ENABLE_PREDICTION_RESISTANCE
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-#endif /* ENABLE_CRYPTO_MBEDTLS */
-
 /*
  * Do we support Unix domain sockets?
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1530?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed
Gerrit-Change-Number: 1530
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7o0W7oaUBdE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>MaxF would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1530?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Mbed TLS 3: Remove prediction resistance op=
tion<br><br>The option --use-prediction-resistance causes the random number=
<br>generator to be reseeded for every call. This is excessive.<br><br>This=
 commit removes that option.<br><br>Change-Id: I6298795f140c2c62252638f9e0c=
d6df19cb3d7ed<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...1665...=
918...&gt;<br>---<br>M doc/man-sections/generic-options.rst<br>M src/openvp=
n/crypto_mbedtls_legacy.c<br>M src/openvpn/crypto_mbedtls_legacy.h<br>M src=
/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M =
src/openvpn/syshead.h<br>7 files changed, 0 insertions(+), 69 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/30/1530/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/generic-option=
s.rst b/doc/man-sections/generic-options.rst</span><br><span>index ed581b1.=
.f46dfec 100644</span><br><span>--- a/doc/man-sections/generic-options.rst<=
/span><br><span>+++ b/doc/man-sections/generic-options.rst</span><br><span>=
@@ -462,16 +462,6 @@</span><br><span>     success/failure via :code:`auth_c=
ontrol_file` when using deferred auth</span><br><span>     method and pendi=
ng authentication via :code:`auth_pending_file`.</span><br><span> </span><b=
r><span>---use-prediction-resistance</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  Enable prediction resistance on mbed TLS&#39;s RNG.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  Enabling prediction resistance causes the RNG t=
o reseed in each call for</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  random. Reseeding this often can quickly deplete the kernel entropy</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  pool.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  If you need this option, please consider running a daemo=
n that adds</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  entropy =
to the kernel pool.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> --user user</span><br><span>   Change the user ID of the Op=
enVPN process to ``user`` after</span><br><span>   initialization, dropping=
 privileges in the process. This option is</span><br><span>diff --git a/src=
/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c</spa=
n><br><span>index a991349..b8e7d6a 100644</span><br><span>--- a/src/openvpn=
/crypto_mbedtls_legacy.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls_l=
egacy.c</span><br><span>@@ -366,16 +366,6 @@</span><br><span>     return &a=
mp;cd_ctx;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-rand_ctx_enable_prediction_resistance(void)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_=
get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_set_prediction_=
resistance(cd_ctx, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_PR=
EDICTION_RESISTANCE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> int</span><br><span> rand_bytes(uint8_t *output, int len=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/crypto_mbedtl=
s_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h</span><br><span>index af71=
037..1005057 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=
.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.h</span><br><spa=
n>@@ -89,14 +89,6 @@</span><br><span>  */</span><br><span> mbedtls_ctr_drbg=
_context *rand_ctx_get(void);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Enable prediction resistance on the random number =
generator.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void rand_ctx_enable_predicti=
on_resistance(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span=
>  * Log the supplied mbed TLS error, prefixed by supplied prefix.</span><b=
r><span>  *</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/i=
nit.c</span><br><span>index 70c0b5d..1391aa85 100644</span><br><span>--- a/=
src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span=
>@@ -2989,13 +2989,6 @@</span><br><span>             packet_id_persist_load=
(&amp;c-&gt;c1.pid_persist, c-&gt;options.packet_id_file);</span><br><span>=
         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef EN=
ABLE_PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (c-&gt;options.use_prediction_resistance)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        rand_ctx_enable_prediction_resistance();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c</span><br><span>index 2bca647..51b4252 100644</span><br><span=
>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</s=
pan><br><span>@@ -566,10 +566,6 @@</span><br><span>     &quot;             =
     using file.\n&quot;</span><br><span>     &quot;--test-crypto   : Run a=
 self-test of crypto features enabled.\n&quot;</span><br><span>     &quot; =
                 For debugging only.\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;--use-prediction-resistance:=
 Enable prediction resistance on the random\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;                             numb=
er generator.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;TLS K=
ey Negotiation Options:\n&quot;</span><br><span>     &quot;(These options a=
re meaningful only for TLS-mode)\n&quot;</span><br><span>@@ -872,9 +868,6 @=
@</span><br><span>     o-&gt;replay_window =3D DEFAULT_SEQ_BACKTRACK;</span=
><br><span>     o-&gt;replay_time =3D DEFAULT_TIME_BACKTRACK;</span><br><sp=
an>     o-&gt;key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;use_predicti=
on_resistance =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span>     o-&gt;tls_timeout =3D 2;</span><br><span>   =
  o-&gt;renegotiate_bytes =3D -1;</span><br><span>     o-&gt;renegotiate_se=
conds =3D 3600;</span><br><span>@@ -1841,9 +1834,6 @@</span><br><span>     =
SHOW_INT(replay_time);</span><br><span>     SHOW_STR(packet_id_file);</span=
><br><span>     SHOW_BOOL(test_crypto);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(use_prediction_resistance);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>=
 </span><br><span>     SHOW_BOOL(tls_server);</span><br><span>     SHOW_BOO=
L(tls_client);</span><br><span>@@ -4476,13 +4466,6 @@</span><br><span>     =
    {</span><br><span>             buf_printf(&amp;out, &quot;,secret&quot;=
);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE=
_PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (o-&gt;use_prediction_resistance)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            buf_printf(&amp;out, &quot;,use-prediction-resistan=
ce&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>=
     }</span><br><span> </span><br><span>     /*</span><br><span>@@ -8543,1=
3 +8526,6 @@</span><br><span>             options-&gt;providers.names[j] =
=3D p[j];</span><br><span>         }</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0]=
, &quot;use-prediction-resistance&quot;) &amp;&amp; !p[1])</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;use_prediction=
_resistance =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span>     else if (streq(p[0], &quot;show-tls&quot;) &amp;&amp; !p[1])</s=
pan><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENER=
AL);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/optio=
ns.h</span><br><span>index 16cfdb5..cf9936b 100644</span><br><span>--- a/sr=
c/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><=
span>@@ -584,9 +584,6 @@</span><br><span>     int replay_time;</span><br><s=
pan>     const char *packet_id_file;</span><br><span>     bool test_crypto;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICT=
ION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    boo=
l use_prediction_resistance;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span> </span><br><span>     /* TLS (control channe=
l) parms */</span><br><span>     bool tls_server;</span><br><span>diff --gi=
t a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><span>index 582=
e130..7e742b3 100644</span><br><span>--- a/src/openvpn/syshead.h</span><br>=
<span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -474,13 +474,6 @@</spa=
n><br><span> #define PORT_SHARE 0</span><br><span> #endif</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_=
MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;m=
bedtls/version.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define ENABLE_PREDICTION_RESISTANCE</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x=
04000000 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> /*</span><br><span>  * Do we support Unix domain socke=
ts?</span><br><span>  */</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1530?usp=3Demail">change =
1530</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1530?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6298795f140c2c62252638f9e0c=
d6df19cb3d7ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1530 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7o0W7oaUBdE=--

