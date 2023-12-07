From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 7 Dec 2023 18:26:29 +0000
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f79a1dd3c84224b260771ba0b1d7f85b985e3032-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OeADsDAlruY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OeADsDAlruY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
---
M doc/man-sections/protocol-options.rst
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
6 files changed, 83 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/460/5

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
index e4452d7..8c17f2a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1789,3 +1789,22 @@
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
+    uint8_t expected_out[] =3D { 0xe0, 0x5f, 0x1f, 1, 0, 0, 0, 0};
+
+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int) strlen(seed),
+                           (uint8_t *)secret, (int) strlen(secret),
+                           out, sizeof(out));
+
+    return (ret && memcmp(out, expected_out, sizeof(out)) !=3D 0);
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
index 8b490ed..82122f5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1830,6 +1830,16 @@
     {
         o->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
     }
+    else if (o->force_key_material_export)
+    {
+        msg(M_INFO, "PUSH: client does not support TLS key material export"
+            "but --force-tls-key-material-export is enabled.");
+        auth_set_client_reason(tls_multi, "Client incompatible with this"
+                               "server. Keying Material Exporters (RFC 570=
5)"
+                               "support missing. Upgrade to a client that "
+                               "supports this feature (OpenVPN 2.6.0+).");
+        return false;
+    }
     if (proto & IV_PROTO_DYN_TLS_CRYPT)
     {
         o->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1521872..fc0a5d5 100644
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
+
+        msg(D_TLS_ERRORS, "Warning: TLS 1.0 PRF with MD5+SHA1 PRF not supp=
orted "
+            "by TLS library. Your system does not support this calculation=
 "
+            "anymore or your security policy (e.g. FIPS 140-2) forbids it.=
 "
+            "Connections will only work with peers running OpenVPN 2.6.0 o=
r "
+            "higher)");
+#ifndef HAVE_EXPORT_KEYING_MATERIAL
+        msg(M_FATAL, "Keying Material Exporters (RFC 5705) not available e=
ither. "
+            "No way to generate data channel keys left.");
+#endif
+        if (o->mode =3D=3D MODE_SERVER)
+        {
+            msg(M_WARN, "Automatically enabling option "
+                "--force-tls-key-material-export");
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
@@ -8643,6 +8674,11 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--OeADsDAlruY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Check PRF availability on initialisation and =
add --force-tls-key-material-export<br><br>We now warn a user if the TLS 1.=
0 PRF is not supported by the cryptographic<br>library of the system. Also =
add the option --force-tls-key-material-export<br>that automatically reject=
s clients that do not support TLS Keying Material<br>Export and automatical=
ly enable it when TLS 1.0 PRF support is not available.<br><br>Change-Id: I=
04f8c7c413e7cb62c726262feee6ca89c7e86c70<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>---<br>M doc/man-sections/protocol-options.rst<br>M=
 src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/multi.c<br=
>M src/openvpn/options.c<br>M src/openvpn/options.h<br>6 files changed, 83 =
insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/60/460/5</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/pr=
otocol-options.rst b/doc/man-sections/protocol-options.rst</span><br><span>=
index 948c0c8..8b061d2 100644</span><br><span>--- a/doc/man-sections/protoc=
ol-options.rst</span><br><span>+++ b/doc/man-sections/protocol-options.rst<=
/span><br><span>@@ -242,3 +242,11 @@</span><br><span>   a key renegotiation=
 begins (default :code:`3600` seconds). This feature</span><br><span>   all=
ows for a graceful transition from old to new key, and removes the key</spa=
n><br><span>   renegotiation sequence from the critical path of tunnel data=
 forwarding.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+--force-tls-key-material-e=
xport</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This option =
is only available in --mode server and forces to use</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Keying Material Exporters (RFC 5705) fo=
r clients. This can be used to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  simulate an environment where the cryptographic library does n=
ot support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the old=
er method to generate data channel keys anymore. This option is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  intended to be a test option =
and might be removed in a future OpenVPN</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  version without notice.</span><br><span>diff --git a=
/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index e4452d7.=
.8c17f2a 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>=
+++ b/src/openvpn/crypto.c</span><br><span>@@ -1789,3 +1789,22 @@</span><br=
><span>     gc_free(&amp;gc);</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+check_tls_prf_working(void)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Modern TLS libraries might no longer support the T=
LS 1.0 PRF with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * MD5+SHA1. This allows us to establish connections only</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * with other 2.6.0+ OpenVPN peer=
s.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Do a simpl=
e dummy test here to see if it works. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *seed =3D &quot;tls1-prf-test&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *secret=
 =3D &quot;tls1-prf-test-secret&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint8_t out[8];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint8_t expected_out[] =3D { 0xe0, 0x5f, 0x1f, 1, 0,=
 0, 0, 0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D ssl_tls1_PRF=
((uint8_t *)seed, (int) strlen(seed),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                           (uint8_t *)secret, (int) strle=
n(secret),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                  out, sizeof(out));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (ret &amp;&amp; memcmp(out, expected_out, sizeof(out)) !=3D 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff=
 --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index =
9255d38..4201524 100644</span><br><span>--- a/src/openvpn/crypto.h</span><b=
r><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -593,4 +593,12 @@</sp=
an><br><span>     return kt;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Checks if the current TLS library supports=
 the TLS 1.0 PRF with MD5+SHA1</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * that OpenVPN uses when TLS Keying Material Export is not avai=
lable.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return  true if supported,=
 false otherwise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_tls_prf=
_working(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> #endif /* CRYPTO_H */</span><br><span>diff --git a/src/openvp=
n/multi.c b/src/openvpn/multi.c</span><br><span>index 8b490ed..82122f5 1006=
44</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/open=
vpn/multi.c</span><br><span>@@ -1830,6 +1830,16 @@</span><br><span>     {</=
span><br><span>         o-&gt;imported_protocol_flags |=3D CO_USE_TLS_KEY_M=
ATERIAL_EXPORT;</span><br><span>     }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (o-&gt;force_key_material_export)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;PUSH: client does =
not support TLS key material export&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;but --force-tls-key-material-export=
 is enabled.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        auth_set_client_reason(tls_multi, &quot;Client incompatible with t=
his&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                     &quot;server. Keying Material Exporters (RFC 5705)&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
              &quot;support missing. Upgrade to a client that &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
     &quot;supports this feature (OpenVPN 2.6.0+).&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (pro=
to &amp; IV_PROTO_DYN_TLS_CRYPT)</span><br><span>     {</span><br><span>   =
      o-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><b=
r><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><b=
r><span>index 1521872..fc0a5d5 100644</span><br><span>--- a/src/openvpn/opt=
ions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1561=
,6 +1561,7 @@</span><br><span>     SHOW_STR(auth_user_pass_verify_script);<=
/span><br><span>     SHOW_BOOL(auth_user_pass_verify_script_via_file);</spa=
n><br><span>     SHOW_BOOL(auth_token_generate);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_BOOL(force_key_material_export);</spa=
n><br><span>     SHOW_INT(auth_token_lifetime);</span><br><span>     SHOW_S=
TR_INLINE(auth_token_secret_file);</span><br><span> #if PORT_SHARE</span><b=
r><span>@@ -2802,6 +2803,11 @@</span><br><span>         {</span><br><span> =
            msg(M_USAGE, &quot;--vlan-tagging requires --mode server&quot;)=
;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (options-&gt;force_key_material_export)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_USAGE, &quot;--force-tls-key-material-export r=
equires --mode server&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span>     }</span><br><span> </span><br><spa=
n>     /*</span><br><span>@@ -3634,6 +3640,30 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+options_process_mutate_prf(struct options *o)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!check_tls_prf_working())</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_TLS_ERRORS, &quot;Warning: TLS 1.0 PRF with MD5+SHA1=
 PRF not supported &quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &quot;by TLS library. Your system does not support this c=
alculation &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;anymore or your security policy (e.g. FIPS 140-2) forbids i=
t. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;Connections will only work with peers running OpenVPN 2.6.0 or &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;higher)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_FATAL, &quot;Keying Material Exporters (RFC 5705=
) not available either. &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;No way to generate data channel keys left.&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;mode =3D=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_WARN, &quot;Automatically enabling option &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;--force-tls-key-mat=
erial-export&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> options_postprocess_mutate(struct options *o, str=
uct env_set *es)</span><br><span> {</span><br><span>     int i;</span><br><=
span>@@ -3647,6 +3677,7 @@</span><br><span> </span><br><span>     options_p=
ostprocess_setdefault_ncpciphers(o);</span><br><span>     options_set_backw=
ards_compatible_options(o);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    options_process_mutate_prf(o);</span><br><span> </span><br><spa=
n>     options_postprocess_cipher(o);</span><br><span>     o-&gt;ncp_cipher=
s =3D mutate_ncp_cipher_list(o-&gt;ncp_ciphers, &amp;o-&gt;gc);</span><br><=
span>@@ -8643,6 +8674,11 @@</span><br><span>             }</span><br><span>=
         }</span><br><span>     }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (streq(p[0], &quot;force-tls-key-material-export&=
quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(=
OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    options-&gt;force_key_material_export =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq=
(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>=
     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prng option ign=
ored (SSL library PRNG is used)&quot;);</span><br><span>diff --git a/src/op=
envpn/options.h b/src/openvpn/options.h</span><br><span>index c4514e1..cbff=
f18 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ =
b/src/openvpn/options.h</span><br><span>@@ -687,6 +687,8 @@</span><br><span=
>     const char *keying_material_exporter_label;</span><br><span>     int =
keying_material_exporter_length;</span><br><span> #endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* force using TLS key material ex=
port for data channel key generation */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool force_key_material_export;</span><br><span> </=
span><br><span>     bool vlan_tagging;</span><br><span>     enum vlan_accep=
table_frames vlan_accept;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">change =
460</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--OeADsDAlruY=--

