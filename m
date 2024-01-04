From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Jan 2024 15:45:05 +0000
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e932c465d561b96fb6be60ccfb3a2f6c2a09b67f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2RQ3V/d0GR0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check PRF
 availability on initialisation and add --force-tls-key-mate...
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

--2RQ3V/d0GR0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Check PRF availability on initialisation and add --force-tl=
s-key-material-export
......................................................................

Check PRF availability on initialisation and add --force-tls-key-material-e=
xport

We now warn a user if the TLS 1.0 PRF is not supported by the cryptographic
library of the system. Also add the option --force-tls-key-material-export
that automatically rejects clients that do not support TLS Keying Material
Export and automatically enable it when TLS 1.0 PRF support is not availabl=
e.

Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240104140214.32196-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
924.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/protocol-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
6 files changed, 84 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/460/10

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 948c0c8..8b061d2 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -242,3 +242,11 @@
   a key renegotiation begins (default :code:`3600` seconds). This feature
   allows for a graceful transition from old to new key, and removes the key
   renegotiation sequence from the critical path of tunnel data forwarding.
+
+--force-tls-key-material-export
+  This option is only available in --mode server and forces to use
+  Keying Material Exporters (RFC 5705) for clients. This can be used to
+  simulate an environment where the cryptographic library does not support
+  the older method to generate data channel keys anymore. This option is
+  intended to be a test option and might be removed in a future OpenVPN
+  version without notice.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e4452d7..2fca131 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -27,6 +27,7 @@
 #endif

 #include "syshead.h"
+#include <string.h>

 #include "crypto.h"
 #include "error.h"
@@ -1789,3 +1790,22 @@
     gc_free(&gc);
     return ret;
 }
+
+bool
+check_tls_prf_working(void)
+{
+    /* Modern TLS libraries might no longer support the TLS 1.0 PRF with
+     * MD5+SHA1. This allows us to establish connections only
+     * with other 2.6.0+ OpenVPN peers.
+     * Do a simple dummy test here to see if it works. */
+    const char *seed =3D "tls1-prf-test";
+    const char *secret =3D "tls1-prf-test-secret";
+    uint8_t out[8];
+    uint8_t expected_out[] =3D { 'q', 'D', '\xfe', '%', '@', 's', 'u', '\x=
95' };
+
+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int) strlen(seed),
+                           (uint8_t *)secret, (int) strlen(secret),
+                           out, sizeof(out));
+
+    return (ret && memcmp(out, expected_out, sizeof(out)) =3D=3D 0);
+}
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 9255d38..4201524 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -593,4 +593,12 @@
     return kt;
 }

+/**
+ * Checks if the current TLS library supports the TLS 1.0 PRF with MD5+SHA1
+ * that OpenVPN uses when TLS Keying Material Export is not available.
+ *
+ * @return  true if supported, false otherwise.
+ */
+bool check_tls_prf_working(void);
+
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8b490ed..f4f0b8a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1830,6 +1830,16 @@
     {
         o->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
     }
+    else if (o->force_key_material_export)
+    {
+        msg(M_INFO, "PUSH: client does not support TLS Keying Material "
+            "Exporters but --force-tls-key-material-export is enabled.");
+        auth_set_client_reason(tls_multi, "Client incompatible with this "
+                               "server. Keying Material Exporters (RFC 570=
5) "
+                               "support missing. Upgrade to a client that "
+                               "supports this feature (OpenVPN 2.6.0+).");
+        return false;
+    }
     if (proto & IV_PROTO_DYN_TLS_CRYPT)
     {
         o->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e498114..1b28a19 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1561,6 +1561,7 @@
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
+    SHOW_BOOL(force_key_material_export);
     SHOW_INT(auth_token_lifetime);
     SHOW_STR_INLINE(auth_token_secret_file);
 #if PORT_SHARE
@@ -2802,6 +2803,11 @@
         {
             msg(M_USAGE, "--vlan-tagging requires --mode server");
         }
+
+        if (options->force_key_material_export)
+        {
+            msg(M_USAGE, "--force-tls-key-material-export requires --mode =
server");
+        }
     }

     /*
@@ -3634,6 +3640,30 @@
 }

 static void
+options_process_mutate_prf(struct options *o)
+{
+    if (!check_tls_prf_working())
+    {
+        msg(D_TLS_ERRORS, "Warning: TLS 1.0 PRF with MD5+SHA1 PRF is not "
+            "supported by the TLS library. Your system does not support th=
is "
+            "calculation anymore or your security policy (e.g. FIPS 140-2)=
 "
+            "forbids it. Connections will only work with peers running "
+            "OpenVPN 2.6.0 or higher)");
+#ifndef HAVE_EXPORT_KEYING_MATERIAL
+        msg(M_FATAL, "Keying Material Exporters (RFC 5705) not available e=
ither. "
+            "No way to generate data channel keys left.");
+#endif
+        if (o->mode =3D=3D MODE_SERVER)
+        {
+            msg(M_WARN, "Automatically enabling option "
+                "--force-tls-key-material-export");
+            o->force_key_material_export =3D true;
+        }
+
+    }
+}
+
+static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
     int i;
@@ -3647,6 +3677,7 @@

     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);
+    options_process_mutate_prf(o);

     options_postprocess_cipher(o);
     o->ncp_ciphers =3D mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
@@ -8642,6 +8673,11 @@
             }
         }
     }
+    else if (streq(p[0], "force-tls-key-material-export"))
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->force_key_material_export =3D true;
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is us=
ed)");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c4514e1..cbfff18 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -687,6 +687,8 @@
     const char *keying_material_exporter_label;
     int keying_material_exporter_length;
 #endif
+    /* force using TLS key material export for data channel key generation=
 */
+    bool force_key_material_export;

     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Gerrit-Change-Number: 460
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--2RQ3V/d0GR0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #10</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/460?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Check PRF availability on initialisation and add --f=
orce-tls-key-material-export<br><br>We now warn a user if the TLS 1.0 PRF i=
s not supported by the cryptographic<br>library of the system. Also add the=
 option --force-tls-key-material-export<br>that automatically rejects clien=
ts that do not support TLS Keying Material<br>Export and automatically enab=
le it when TLS 1.0 PRF support is not available.<br><br>Change-Id: I04f8c7c=
413e7cb62c726262feee6ca89c7e86c70<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-=
Id: &lt;20240104140214.32196-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg27924.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/pro=
tocol-options.rst<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M =
src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<b=
r>6 files changed, 84 insertions(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/60/460/10</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-opt=
ions.rst</span><br><span>index 948c0c8..8b061d2 100644</span><br><span>--- =
a/doc/man-sections/protocol-options.rst</span><br><span>+++ b/doc/man-secti=
ons/protocol-options.rst</span><br><span>@@ -242,3 +242,11 @@</span><br><sp=
an>   a key renegotiation begins (default :code:`3600` seconds). This featu=
re</span><br><span>   allows for a graceful transition from old to new key,=
 and removes the key</span><br><span>   renegotiation sequence from the cri=
tical path of tunnel data forwarding.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-force-tls-key-material-export</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  This option is only available in --mode server and forces to u=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Keying Material=
 Exporters (RFC 5705) for clients. This can be used to</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  simulate an environment where the cryp=
tographic library does not support</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  the older method to generate data channel keys anymore. Th=
is option is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  inten=
ded to be a test option and might be removed in a future OpenVPN</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  version without notice.</spa=
n><br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span>=
<br><span>index e4452d7..2fca131 100644</span><br><span>--- a/src/openvpn/c=
rypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -27,6=
 +27,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #inclu=
de &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;string.h&gt;</span><br><span> </span><br><span> #include =
&quot;crypto.h&quot;</span><br><span> #include &quot;error.h&quot;</span><b=
r><span>@@ -1789,3 +1790,22 @@</span><br><span>     gc_free(&amp;gc);</span=
><br><span>     return ret;</span><br><span> }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_t=
ls_prf_working(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Modern TLS=
 libraries might no longer support the TLS 1.0 PRF with</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * MD5+SHA1. This allows us to esta=
blish connections only</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * with other 2.6.0+ OpenVPN peers.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * Do a simple dummy test here to see if it work=
s. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *seed =3D &quot;tls1-prf-test&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *secret =3D &quot;tls1-prf-test-secret&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t out[=
8];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t expe=
cted_out[] =3D { &#39;q&#39;, &#39;D&#39;, &#39;\xfe&#39;, &#39;%&#39;, &#3=
9;@&#39;, &#39;s&#39;, &#39;u&#39;, &#39;\x95&#39; };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int) strlen(s=
eed),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
             (uint8_t *)secret, (int) strlen(secret),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           out, sizeof(ou=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (ret &amp;&amp; memcmp(=
out, expected_out, sizeof(out)) =3D=3D 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/crypto.h =
b/src/openvpn/crypto.h</span><br><span>index 9255d38..4201524 100644</span>=
<br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/cryp=
to.h</span><br><span>@@ -593,4 +593,12 @@</span><br><span>     return kt;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Checks if the current TLS library supports the TLS 1.0 PRF with MD5+SHA1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that OpenVPN use=
s when TLS Keying Material Export is not available.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return  true if supported, false otherwise.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool check_tls_prf_working(void);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* CRYP=
TO_H */</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mult=
i.c</span><br><span>index 8b490ed..f4f0b8a 100644</span><br><span>--- a/src=
/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>=
@@ -1830,6 +1830,16 @@</span><br><span>     {</span><br><span>         o-&g=
t;imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (o-&gt;force_key_material_export)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_INFO, &quot;PUSH: client does not support TLS Keying Mater=
ial &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;Exporters but --force-tls-key-material-export is enabled.&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_cli=
ent_reason(tls_multi, &quot;Client incompatible with this &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
 &quot;server. Keying Material Exporters (RFC 5705) &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                               &quot=
;support missing. Upgrade to a client that &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                               &quot;supports=
 this feature (OpenVPN 2.6.0+).&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span>     if (proto &amp; IV_PROTO_D=
YN_TLS_CRYPT)</span><br><span>     {</span><br><span>         o-&gt;importe=
d_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>diff --git =
a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index e4981=
14..1b28a19 100644</span><br><span>--- a/src/openvpn/options.c</span><br><s=
pan>+++ b/src/openvpn/options.c</span><br><span>@@ -1561,6 +1561,7 @@</span=
><br><span>     SHOW_STR(auth_user_pass_verify_script);</span><br><span>   =
  SHOW_BOOL(auth_user_pass_verify_script_via_file);</span><br><span>     SH=
OW_BOOL(auth_token_generate);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_BOOL(force_key_material_export);</span><br><span>     SH=
OW_INT(auth_token_lifetime);</span><br><span>     SHOW_STR_INLINE(auth_toke=
n_secret_file);</span><br><span> #if PORT_SHARE</span><br><span>@@ -2802,6 =
+2803,11 @@</span><br><span>         {</span><br><span>             msg(M_U=
SAGE, &quot;--vlan-tagging requires --mode server&quot;);</span><br><span> =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;force=
_key_material_export)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_USAGE, &quot;--force-tls-key-material-export requires --mode serv=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span>     }</span><br><span> </span><br><span>     /*</span><br=
><span>@@ -3634,6 +3640,30 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+options_process_mutate_prf(struct options *o)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!check_tls_prf_working())</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_TLS_ERRORS, &quot;Warning: TLS 1.0 PRF with MD5+SHA1=
 PRF is not &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;supported by the TLS library. Your system does not support=
 this &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;calculation anymore or your security policy (e.g. FIPS 140-2) &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;forbids it. Connections will only work with peers running &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;OpenVPN 2=
.6.0 or higher)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_FATAL, &quot;Keying Material Exporters (R=
FC 5705) not available either. &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;No way to generate data channel keys le=
ft.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;mod=
e =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_WARN, &quot;Automatically enabling option &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;--force-tls-ke=
y-material-export&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            o-&gt;force_key_material_export =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> options_pos=
tprocess_mutate(struct options *o, struct env_set *es)</span><br><span> {</=
span><br><span>     int i;</span><br><span>@@ -3647,6 +3677,7 @@</span><br>=
<span> </span><br><span>     options_postprocess_setdefault_ncpciphers(o);<=
/span><br><span>     options_set_backwards_compatible_options(o);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    options_process_mutate_pr=
f(o);</span><br><span> </span><br><span>     options_postprocess_cipher(o);=
</span><br><span>     o-&gt;ncp_ciphers =3D mutate_ncp_cipher_list(o-&gt;nc=
p_ciphers, &amp;o-&gt;gc);</span><br><span>@@ -8642,6 +8673,11 @@</span><br=
><span>             }</span><br><span>         }</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;force-tls-key-material-export&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;force_key_material_ex=
port =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         msg(M_W=
ARN, &quot;NOTICE: --prng option ignored (SSL library PRNG is used)&quot;);=
</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h=
</span><br><span>index c4514e1..cbfff18 100644</span><br><span>--- a/src/op=
envpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span=
>@@ -687,6 +687,8 @@</span><br><span>     const char *keying_material_expor=
ter_label;</span><br><span>     int keying_material_exporter_length;</span>=
<br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* force using TLS key material export for data channel key generation */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool force_key_=
material_export;</span><br><span> </span><br><span>     bool vlan_tagging;<=
/span><br><span>     enum vlan_acceptable_frames vlan_accept;</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/460?usp=3Demail">change 460</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2RQ3V/d0GR0=--

