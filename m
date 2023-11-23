From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 23 Nov 2023 12:40:00 +0000
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9d77544cc65c96d2f04fef225327581e7d0dcef3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CEtrZinNUP8="; charset=UTF-8
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

--CEtrZinNUP8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail

to review the following change.


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
6 files changed, 81 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/460/1

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
index e4452d7..9667c74 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1789,3 +1789,21 @@
     gc_free(&gc);
     return ret;
 }
+
+bool
+check_tls_prf_working(void)
+{
+    /* Modern TLS libraries might no longer support the TLS 1.0 PRF. This
+     * limits our compatibility to other 2.6.x+ OpernVPN peers. Do a simple
+     * dummy test here to see if it works. */
+    const char *seed =3D "tls1-prf-test";
+    const char *secret =3D "tls1-prf-test-secret";
+    uint8_t out[8];
+    uint8_t expected_out[] =3D { 0xe0, 0x5f, 0x1f, 1, 0, 0, 0, 0};
+
+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed),
+                           (uint8_t *)secret, strlen(secret),
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
index 2594b66..170d5c7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1564,6 +1564,7 @@
     SHOW_STR(auth_user_pass_verify_script);
     SHOW_BOOL(auth_user_pass_verify_script_via_file);
     SHOW_BOOL(auth_token_generate);
+    SHOW_BOOL(force_key_material_export);
     SHOW_INT(auth_token_lifetime);
     SHOW_STR_INLINE(auth_token_secret_file);
 #if PORT_SHARE
@@ -2579,6 +2580,10 @@
         {
             msg(M_USAGE, "--mode server requires --tls-server");
         }
+        if (options->force_key_material_export)
+        {
+            msg(M_USAGE, "--force-tls-key-material-export requires --mode =
server");
+        }
         if (ce->remote)
         {
             msg(M_USAGE, "--remote cannot be used with --mode server");
@@ -3639,6 +3644,30 @@
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
@@ -3652,6 +3681,7 @@

     options_postprocess_setdefault_ncpciphers(o);
     options_set_backwards_compatible_options(o);
+    options_process_mutate_prf(o);

     options_postprocess_cipher(o);
     o->ncp_ciphers =3D mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
@@ -8650,6 +8680,11 @@
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
index 5a37316..db7008a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -688,6 +688,8 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--CEtrZinNUP8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Check PRF availability on initialisation and add --force-tls-=
key-material-export<br><br>We now warn a user if the TLS 1.0 PRF is not sup=
ported by the cryptographic<br>library of the system. Also add the option -=
-force-tls-key-material-export<br>that automatically rejects clients that d=
o not support TLS Keying Material<br>Export and automatically enable it whe=
n TLS 1.0 PRF support is not available.<br><br>Change-Id: I04f8c7c413e7cb62=
c726262feee6ca89c7e86c70<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>---<br>M doc/man-sections/protocol-options.rst<br>M src/openvpn/cry=
pto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/multi.c<br>M src/openvpn/o=
ptions.c<br>M src/openvpn/options.h<br>6 files changed, 81 insertions(+), 0=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/60/460/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/man-sections/protocol-options.r=
st b/doc/man-sections/protocol-options.rst</span><br><span>index 948c0c8..8=
b061d2 100644</span><br><span>--- a/doc/man-sections/protocol-options.rst</=
span><br><span>+++ b/doc/man-sections/protocol-options.rst</span><br><span>=
@@ -242,3 +242,11 @@</span><br><span>   a key renegotiation begins (default=
 :code:`3600` seconds). This feature</span><br><span>   allows for a gracef=
ul transition from old to new key, and removes the key</span><br><span>   r=
enegotiation sequence from the critical path of tunnel data forwarding.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+--force-tls-key-material-export</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  This option is only availab=
le in --mode server and forces to use</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Keying Material Exporters (RFC 5705) for clients. This =
can be used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  sim=
ulate an environment where the cryptographic library does not support</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  the older method to gen=
erate data channel keys anymore. This option is</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  intended to be a test option and might be rem=
oved in a future OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  version without notice.</span><br><span>diff --git a/src/openvpn/cry=
pto.c b/src/openvpn/crypto.c</span><br><span>index e4452d7..9667c74 100644<=
/span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvp=
n/crypto.c</span><br><span>@@ -1789,3 +1789,21 @@</span><br><span>     gc_f=
ree(&amp;gc);</span><br><span>     return ret;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_tls_prf_working(void)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Modern TLS libraries might no longer support the TLS 1.0 PRF. This=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * limits our c=
ompatibility to other 2.6.x+ OpernVPN peers. Do a simple</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * dummy test here to see if it wo=
rks. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *seed =3D &quot;tls1-prf-test&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *secret =3D &quot;tls1-prf-test-secret&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t ou=
t[8];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t ex=
pected_out[] =3D { 0xe0, 0x5f, 0x1f, 1, 0, 0, 0, 0};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       (uint8_t *)secret, strlen(secret),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                           out, sizeof(out));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (ret &amp;&amp; memcmp(out, expecte=
d_out, sizeof(out)) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/=
crypto.h</span><br><span>index 9255d38..4201524 100644</span><br><span>--- =
a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br=
><span>@@ -593,4 +593,12 @@</span><br><span>     return kt;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks if t=
he current TLS library supports the TLS 1.0 PRF with MD5+SHA1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * that OpenVPN uses when TLS Key=
ing Material Export is not available.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return  true if supported, false otherwise.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool check_tls_prf_working(void);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* CRYPTO_H */</span><b=
r><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><s=
pan>index 8b490ed..82122f5 100644</span><br><span>--- a/src/openvpn/multi.c=
</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1830,6 +1830=
,16 @@</span><br><span>     {</span><br><span>         o-&gt;imported_proto=
col_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span>     }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (o-&gt;force_=
key_material_export)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_INFO, &quot;PUSH: client does not support TLS key material export&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;but =
--force-tls-key-material-export is enabled.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        auth_set_client_reason(tls_multi,=
 &quot;Client incompatible with this&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                               &quot;server. Keying =
Material Exporters (RFC 5705)&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               &quot;support missing. Upgra=
de to a client that &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                               &quot;supports this feature (OpenVPN =
2.6.0+).&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     if (proto &amp; IV_PROTO_DYN_TLS_CRYPT)</span><br=
><span>     {</span><br><span>         o-&gt;imported_protocol_flags |=3D C=
O_USE_DYNAMIC_TLS_CRYPT;</span><br><span>diff --git a/src/openvpn/options.c=
 b/src/openvpn/options.c</span><br><span>index 2594b66..170d5c7 100644</spa=
n><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/o=
ptions.c</span><br><span>@@ -1564,6 +1564,7 @@</span><br><span>     SHOW_ST=
R(auth_user_pass_verify_script);</span><br><span>     SHOW_BOOL(auth_user_p=
ass_verify_script_via_file);</span><br><span>     SHOW_BOOL(auth_token_gene=
rate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL=
(force_key_material_export);</span><br><span>     SHOW_INT(auth_token_lifet=
ime);</span><br><span>     SHOW_STR_INLINE(auth_token_secret_file);</span><=
br><span> #if PORT_SHARE</span><br><span>@@ -2579,6 +2580,10 @@</span><br><=
span>         {</span><br><span>             msg(M_USAGE, &quot;--mode serv=
er requires --tls-server&quot;);</span><br><span>         }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;force_key_m=
aterial_export)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_USAGE, &quot;--force-tls-key-material-export requires --mode server&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>         if (ce-&gt;remote)</span><br><span>         {</span><br=
><span>             msg(M_USAGE, &quot;--remote cannot be used with --mode =
server&quot;);</span><br><span>@@ -3639,6 +3644,30 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+options_process_mutate_prf(struct options *o)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!check_tls_prf_working())</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;Warning: TLS 1.0 PRF with MD=
5+SHA1 PRF not supported &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;by TLS library. Your system does not support =
this calculation &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;anymore or your security policy (e.g. FIPS 140-2) for=
bids it. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &quot;Connections will only work with peers running OpenVPN 2.6.0 o=
r &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;higher)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(M_FATAL, &quot;Keying Material Exporters (RF=
C 5705) not available either. &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;No way to generate data channel keys lef=
t.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;mode=
 =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;Automatically enabling option &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                &quot;--force-tls-key=
-material-export&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span> options_postprocess_mutate(struct options *o, =
struct env_set *es)</span><br><span> {</span><br><span>     int i;</span><b=
r><span>@@ -3652,6 +3681,7 @@</span><br><span> </span><br><span>     option=
s_postprocess_setdefault_ncpciphers(o);</span><br><span>     options_set_ba=
ckwards_compatible_options(o);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    options_process_mutate_prf(o);</span><br><span> </span><br><=
span>     options_postprocess_cipher(o);</span><br><span>     o-&gt;ncp_cip=
hers =3D mutate_ncp_cipher_list(o-&gt;ncp_ciphers, &amp;o-&gt;gc);</span><b=
r><span>@@ -8650,6 +8680,11 @@</span><br><span>             }</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;force-tls-key-material-expo=
rt&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSI=
ON(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;force_key_material_export =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (stre=
q(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span=
>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --prng option ig=
nored (SSL library PRNG is used)&quot;);</span><br><span>diff --git a/src/o=
penvpn/options.h b/src/openvpn/options.h</span><br><span>index 5a37316..db7=
008a 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++=
 b/src/openvpn/options.h</span><br><span>@@ -688,6 +688,8 @@</span><br><spa=
n>     const char *keying_material_exporter_label;</span><br><span>     int=
 keying_material_exporter_length;</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* force using TLS key material e=
xport for data channel key generation */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool force_key_material_export;</span><br><span> <=
/span><br><span>     bool vlan_tagging;</span><br><span>     enum vlan_acce=
ptable_frames vlan_accept;</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">change=
 460</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--CEtrZinNUP8=--

