From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 12:48:35 +0000
In-Reply-To: <gerrit.1744197804000.I90d54853fe1b1d820661cc2c099e07ec5d31ed05@...2715...>
References: <gerrit.1744197804000.I90d54853fe1b1d820661cc2c099e07ec5d31ed05@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <05a1d7bb435bcb9bd41263aa23e399d1c19874c3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w8nBhWHRejw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Also print key
 agreement when printing negotiated details
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w8nBhWHRejw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
8?usp=3Demail )

Change subject: Also print key agreement when printing negotiated details
......................................................................

Also print key agreement when printing negotiated details

With TLS 1.0 to 1.2, the used key agreement was depended on the certificates
themselves. With TLS 1.3 this is no longer the case but basically always
X25519 was used.  So this information has not been very interesting so far.

With OpenSSL 3.5.0 and the new X25519MLKEM768 hybrid key agreement, the used
key agreement group actually becomes interesting information.

This commit adds printing this information for OpenSSL 3.0.0+ and uses
a compat version for OpenSSL 3.0-3.1 to avoid an additional ifdef in the
code itself.

Example output with ML-DSA-65 certificates on the server (client output):

   Control Channel: TLSv1.3, cipher
   TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 15616
   bits ML-DSA-65, signature: id-ml-dsa-65, peer signing
   digest/type: mldsa65 id-ml-dsa-65,
   key agreement: X25519MLKEM768

with an secp384r1 certificate:

  Control Channel: TLSv1.3, cipher
  TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384
  bits ECsecp384r1, signature: ecdsa-with-SHA256, peer signing
  digest/type: ecdsa_secp384r1_sha384 ECDSA,
  key agreement: X25519MLKEM768

Change-Id: I90d54853fe1b1d820661cc2c099e07ec5d31ed05
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250409122409.17616-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
393.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 29 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index e2bd9bf..bd6f09c 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -197,6 +197,13 @@
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VER=
SION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL) */

-
+#if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >=3D 0x=
30000000L
+static inline const char *
+SSL_get0_group_name(SSL *s)
+{
+    int nid =3D SSL_get_negotiated_group(s);
+    return SSL_group_to_name(s, nid);
+}
+#endif

 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 23b0266..d1d5d3e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2486,7 +2486,21 @@
              peer_sig, peer_sig_type);
 }

-
+#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
+void
+print_tls_key_agreement_group(SSL *ssl, char *buf, size_t buflen)
+{
+    const char *groupname =3D SSL_get0_group_name(ssl);
+    if (!groupname)
+    {
+        snprintf(buf, buflen, ", key agreement: (error fetching group)");
+    }
+    else
+    {
+        snprintf(buf, buflen, ", key agreement: %s", groupname);
+    }
+}
+#endif

 /* **************************************
  *
@@ -2503,8 +2517,9 @@
     char s2[256];
     char s3[256];
     char s4[256];
+    char s5[256];

-    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;
+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D s5[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
     snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
              prefix,
@@ -2520,8 +2535,11 @@
     }
     print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
     print_peer_signature(ks_ssl->ssl, s4, sizeof(s4));
+#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
+    print_tls_key_agreement_group(ks_ssl->ssl, s5, sizeof(s5));
+#endif

-    msg(D_HANDSHAKE, "%s%s%s%s", s1, s2, s3, s4);
+    msg(D_HANDSHAKE, "%s%s%s%s%s", s1, s2, s3, s4, s5);
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/938?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I90d54853fe1b1d820661cc2c099e07ec5d31ed05
Gerrit-Change-Number: 938
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--w8nBhWHRejw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/938?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Also print key agreement when printing negotia=
ted details<br><br>With TLS 1.0 to 1.2, the used key agreement was depended=
 on the certificates<br>themselves. With TLS 1.3 this is no longer the case=
 but basically always<br>X25519 was used.  So this information has not been=
 very interesting so far.<br><br>With OpenSSL 3.5.0 and the new X25519MLKEM=
768 hybrid key agreement, the used<br>key agreement group actually becomes =
interesting information.<br><br>This commit adds printing this information =
for OpenSSL 3.0.0+ and uses<br>a compat version for OpenSSL 3.0-3.1 to avoi=
d an additional ifdef in the<br>code itself.<br><br>Example output with ML-=
DSA-65 certificates on the server (client output):<br><br>   Control Channe=
l: TLSv1.3, cipher<br>   TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: =
15616<br>   bits ML-DSA-65, signature: id-ml-dsa-65, peer signing<br>   dig=
est/type: mldsa65 id-ml-dsa-65,<br>   key agreement: X25519MLKEM768<br><br>=
with an secp384r1 certificate:<br><br>  Control Channel: TLSv1.3, cipher<br=
>  TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384<br>  bits ECsecp38=
4r1, signature: ecdsa-with-SHA256, peer signing<br>  digest/type: ecdsa_sec=
p384r1_sha384 ECDSA,<br>  key agreement: X25519MLKEM768<br><br>Change-Id: I=
90d54853fe1b1d820661cc2c099e07ec5d31ed05<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>M=
essage-Id: &lt;20250409122409.17616-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31393.html<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/o=
penssl_compat.h<br>M src/openvpn/ssl_openssl.c<br>2 files changed, 29 inser=
tions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h=
</span><br><span>index e2bd9bf..bd6f09c 100644</span><br><span>--- a/src/op=
envpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</=
span><br><span>@@ -197,6 +197,13 @@</span><br><span> }</span><br><span> #en=
dif /* if OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; (!defined(LIBRE=
SSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL) */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt=
; 0x30200000L &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const char *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+SSL_get0_group_name(=
SSL *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int nid =3D SSL_get_negoti=
ated_group(s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn SSL_group_to_name(s, nid);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> </span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><=
br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c=
</span><br><span>index 23b0266..d1d5d3e 100644</span><br><span>--- a/src/op=
envpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><=
br><span>@@ -2486,7 +2486,21 @@</span><br><span>              peer_sig, pee=
r_sig_type);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+print_tls_key_agreement_group(SSL *ssl, char *buf, siz=
e_t buflen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *groupname =
=3D SSL_get0_group_name(ssl);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!groupname)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    snprintf(buf, buflen, &quot;, key agreement: (error fetching group)&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        snprintf(buf, buflen, &quot;, key agreement: %=
s&quot;, groupname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span>=
<br><span> /* **************************************</span><br><span>  *</s=
pan><br><span>@@ -2503,8 +2517,9 @@</span><br><span>     char s2[256];</spa=
n><br><span>     char s3[256];</span><br><span>     char s4[256];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char s5[256];</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s1[0] =3D s=
2[0] =3D s3[0] =3D s4[0] =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D s5[0] =3D 0;</span>=
<br><span>     ciph =3D SSL_get_current_cipher(ks_ssl-&gt;ssl);</span><br><=
span>     snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s %s&quot;,</span><=
br><span>              prefix,</span><br><span>@@ -2520,8 +2535,11 @@</span=
><br><span>     }</span><br><span>     print_server_tempkey(ks_ssl-&gt;ssl,=
 s3, sizeof(s3));</span><br><span>     print_peer_signature(ks_ssl-&gt;ssl,=
 s4, sizeof(s4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    print_tls_key_agreement_group(ks_ssl-&gt;ssl, =
s5, sizeof(s5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_HANDSHAKE, &quot;%s%s%s%s&quot;, s1, s2, s3, s4);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_HANDSHAKE, &quot;%s%s%s%s=
%s&quot;, s1, s2, s3, s4, s5);</span><br><span> }</span><br><span> </span><=
br><span> void</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/938?usp=3Demail">change 938</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/938?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I90d54853fe1b1d820661cc2c099=
e07ec5d31ed05 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 938 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--w8nBhWHRejw=--

