From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 15:26:56 +0000
In-Reply-To: <gerrit.1771247899000.I6298795f140c2c62252638f9e0cd6df19cb3d7ed@...2715...>
References: <gerrit.1771247899000.I6298795f140c2c62252638f9e0cd6df19cb3d7ed@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <793253adc802915b75e69966be605cae24117233-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+xFVfR3MlNw="; charset=UTF-8
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
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+xFVfR3MlNw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
30?usp=3Demail )

Change subject: Mbed TLS 3: Remove prediction resistance option
......................................................................

Mbed TLS 3: Remove prediction resistance option

The option --use-prediction-resistance causes the random number
generator to be reseeded for every call. This is excessive.

This commit removes that option.

Github: closes OpenVPN/openvpn#964

Change-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1530
Message-Id: <20260216151033.16585-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
658.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/generic-options.rst
M doc/man-sections/unsupported-options.rst
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_mbedtls_legacy.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/syshead.h
8 files changed, 5 insertions(+), 69 deletions(-)




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
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index f1332f3..c273905 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -65,3 +65,8 @@
   Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
   driver on Windows. It will fall back to tap-windows6 if options are used
   that are incompatible with ovpn-dco.
+
+--use-prediction-resistance
+  Removed in OpenVPN 2.8. This option caused the Mbed TLS 3 random number
+  generator to be reseeded on every call. It has been removed because this
+  is excessive.
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
index 09a5d48..cdb02e9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -565,10 +565,6 @@
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
@@ -871,9 +867,6 @@
     o->replay_window =3D DEFAULT_SEQ_BACKTRACK;
     o->replay_time =3D DEFAULT_TIME_BACKTRACK;
     o->key_direction =3D KEY_DIRECTION_BIDIRECTIONAL;
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    o->use_prediction_resistance =3D false;
-#endif
     o->tls_timeout =3D 2;
     o->renegotiate_bytes =3D -1;
     o->renegotiate_seconds =3D 3600;
@@ -1840,9 +1833,6 @@
     SHOW_INT(replay_time);
     SHOW_STR(packet_id_file);
     SHOW_BOOL(test_crypto);
-#ifdef ENABLE_PREDICTION_RESISTANCE
-    SHOW_BOOL(use_prediction_resistance);
-#endif

     SHOW_BOOL(tls_server);
     SHOW_BOOL(tls_client);
@@ -4475,13 +4465,6 @@
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
@@ -8542,13 +8525,6 @@
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
index 067ee9d..1d6cdc2 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed
Gerrit-Change-Number: 1530
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+xFVfR3MlNw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1530?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Mbed TLS 3: Remove prediction resistance option<=
br><br>The option --use-prediction-resistance causes the random number<br>g=
enerator to be reseeded for every call. This is excessive.<br><br>This comm=
it removes that option.<br><br>Github: closes OpenVPN/openvpn#964<br><br>Ch=
ange-Id: I6298795f140c2c62252638f9e0cd6df19cb3d7ed<br>Signed-off-by: Max Fi=
llinger &lt;maximilian.fillinger@...2918...&gt;<br>Acked-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/op=
envpn/+/1530<br>Message-Id: &lt;20260216151033.16585-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g35658.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M doc/man-sections/generic-options.rst<br>M doc/man-sections/unsupported-=
options.rst<br>M src/openvpn/crypto_mbedtls_legacy.c<br>M src/openvpn/crypt=
o_mbedtls_legacy.h<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M =
src/openvpn/options.h<br>M src/openvpn/syshead.h<br>8 files changed, 5 inse=
rtions(+), 69 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/gen=
eric-options.rst</span><br><span>index ed581b1..f46dfec 100644</span><br><s=
pan>--- a/doc/man-sections/generic-options.rst</span><br><span>+++ b/doc/ma=
n-sections/generic-options.rst</span><br><span>@@ -462,16 +462,6 @@</span><=
br><span>     success/failure via :code:`auth_control_file` when using defe=
rred auth</span><br><span>     method and pending authentication via :code:=
`auth_pending_file`.</span><br><span> </span><br><span>---use-prediction-re=
sistance</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Enable pred=
iction resistance on mbed TLS&#39;s RNG.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
Enabling prediction resistance causes the RNG to reseed in each call for</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  random. Reseeding this=
 often can quickly deplete the kernel entropy</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  pool.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  If you ne=
ed this option, please consider running a daemon that adds</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  entropy to the kernel pool.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --user user<=
/span><br><span>   Change the user ID of the OpenVPN process to ``user`` af=
ter</span><br><span>   initialization, dropping privileges in the process. =
This option is</span><br><span>diff --git a/doc/man-sections/unsupported-op=
tions.rst b/doc/man-sections/unsupported-options.rst</span><br><span>index =
f1332f3..c273905 100644</span><br><span>--- a/doc/man-sections/unsupported-=
options.rst</span><br><span>+++ b/doc/man-sections/unsupported-options.rst<=
/span><br><span>@@ -65,3 +65,8 @@</span><br><span>   Removed in OpenVPN 2.7=
. OpenVPN will always use ovpn-dco as the default</span><br><span>   driver=
 on Windows. It will fall back to tap-windows6 if options are used</span><b=
r><span>   that are incompatible with ovpn-dco.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+--use-prediction-resistance</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  Removed in OpenVPN 2.8. This option caused the Mbed TLS =
3 random number</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ge=
nerator to be reseeded on every call. It has been removed because this</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  is excessive.</span><b=
r><span>diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/cryp=
to_mbedtls_legacy.c</span><br><span>index a991349..b8e7d6a 100644</span><br=
><span>--- a/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>+++ b/src/=
openvpn/crypto_mbedtls_legacy.c</span><br><span>@@ -366,16 +366,6 @@</span>=
<br><span>     return &amp;cd_ctx;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_=
RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_enable_prediction_r=
esistance(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_conte=
xt *cd_ctx =3D rand_ctx_get();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_=
ctr_drbg_set_prediction_resistance(cd_ctx, 1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif /* ENABLE_PREDICTION_RESISTANCE */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> rand_bytes(=
uint8_t *output, int len)</span><br><span> {</span><br><span>diff --git a/s=
rc/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h</s=
pan><br><span>index af71037..1005057 100644</span><br><span>--- a/src/openv=
pn/crypto_mbedtls_legacy.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls=
_legacy.h</span><br><span>@@ -89,14 +89,6 @@</span><br><span>  */</span><br=
><span> mbedtls_ctr_drbg_context *rand_ctx_get(void);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_=
RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Enable prediction resistan=
ce on the random number generator.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
rand_ctx_enable_prediction_resistance(void);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  * Log the supplied mbed TLS error, prefixed by s=
upplied prefix.</span><br><span>  *</span><br><span>diff --git a/src/openvp=
n/init.c b/src/openvpn/init.c</span><br><span>index 70c0b5d..1391aa85 10064=
4</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvp=
n/init.c</span><br><span>@@ -2989,13 +2989,6 @@</span><br><span>           =
  packet_id_persist_load(&amp;c-&gt;c1.pid_persist, c-&gt;options.packet_id=
_file);</span><br><span>         }</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.use_prediction_resistanc=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        rand_ctx_enable_prediction_=
resistance();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> =
}</span><br><span> </span><br><span> </span><br><span>diff --git a/src/open=
vpn/options.c b/src/openvpn/options.c</span><br><span>index 09a5d48..cdb02e=
9 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/=
src/openvpn/options.c</span><br><span>@@ -565,10 +565,6 @@</span><br><span>=
     &quot;                  using file.\n&quot;</span><br><span>     &quot=
;--test-crypto   : Run a self-test of crypto features enabled.\n&quot;</spa=
n><br><span>     &quot;                  For debugging only.\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RES=
ISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--us=
e-prediction-resistance: Enable prediction resistance on the random\n&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;           =
                  number generator.\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span>     &quot;\n&quot;</span><br>=
<span>     &quot;TLS Key Negotiation Options:\n&quot;</span><br><span>     =
&quot;(These options are meaningful only for TLS-mode)\n&quot;</span><br><s=
pan>@@ -871,9 +867,6 @@</span><br><span>     o-&gt;replay_window =3D DEFAUL=
T_SEQ_BACKTRACK;</span><br><span>     o-&gt;replay_time =3D DEFAULT_TIME_BA=
CKTRACK;</span><br><span>     o-&gt;key_direction =3D KEY_DIRECTION_BIDIREC=
TIONAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    o-&gt;use_prediction_resistance =3D false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span>     o-&gt;tls_timeout =3D =
2;</span><br><span>     o-&gt;renegotiate_bytes =3D -1;</span><br><span>   =
  o-&gt;renegotiate_seconds =3D 3600;</span><br><span>@@ -1840,9 +1833,6 @@=
</span><br><span>     SHOW_INT(replay_time);</span><br><span>     SHOW_STR(=
packet_id_file);</span><br><span>     SHOW_BOOL(test_crypto);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_BOOL(use_pre=
diction_resistance);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span> </span><br><span>     SHOW_BOOL(tls_server);</span><=
br><span>     SHOW_BOOL(tls_client);</span><br><span>@@ -4475,13 +4465,6 @@=
</span><br><span>         {</span><br><span>             buf_printf(&amp;ou=
t, &quot;,secret&quot;);</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (o-&gt;use_prediction_resistance)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;=
,use-prediction-resistance&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span>     }</span><br><span> </span><br><span>     /*</s=
pan><br><span>@@ -8542,13 +8525,6 @@</span><br><span>             options-&=
gt;providers.names[j] =3D p[j];</span><br><span>         }</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_P=
REDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else if (streq(p[0], &quot;use-prediction-resistance&quot;) &amp;&amp; !=
p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opti=
ons-&gt;use_prediction_resistance =3D true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span>     else if (streq(p[0], &quot;show-tls&quot;=
) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/options=
.h b/src/openvpn/options.h</span><br><span>index 16cfdb5..cf9936b 100644</s=
pan><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn=
/options.h</span><br><span>@@ -584,9 +584,6 @@</span><br><span>     int rep=
lay_time;</span><br><span>     const char *packet_id_file;</span><br><span>=
     bool test_crypto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef ENABLE_PREDICTION_RESISTANCE</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool use_prediction_resistance;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span>     =
/* TLS (control channel) parms */</span><br><span>     bool tls_server;</sp=
an><br><span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</sp=
an><br><span>index 067ee9d..1d6cdc2 100644</span><br><span>--- a/src/openvp=
n/syshead.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ =
-474,13 +474,6 @@</span><br><span> #define PORT_SHARE 0</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &lt;mbedtls/version.h&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_PREDICTION_RESISTA=
NCE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_=
VERSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Do we sup=
port Unix domain sockets?</span><br><span>  */</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/153=
0?usp=3Demail">change 1530</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1530?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6298795f140c2c62252638f9e0c=
d6df19cb3d7ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1530 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--+xFVfR3MlNw=--

