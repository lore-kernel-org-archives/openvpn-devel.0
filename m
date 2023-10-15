From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 15 Oct 2023 14:15:32 +0000
In-Reply-To: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
References: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <538b0be72e552721808ad200dd8fee85b632bd86-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZROgHx9G5yY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print peer temporary
 key details
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

--ZROgHx9G5yY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/36=
4?usp=3Demail )

Change subject: Print peer temporary key details
......................................................................

Print peer temporary key details

The peer temporary key in TLS session is related to the PFS
exchange/generation. From the SSL_get_peer_tmp_key manual page:

   For example, if ECDHE is in use, then this represents the
   peer's public ECDHE key.

Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231009105518.34432-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
192.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 48 insertions(+), 12 deletions(-)




diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index efc85d4..f487b1b 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -75,6 +75,10 @@
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif

+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSS=
L)) || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x305=
0400fL)
+#define SSL_get_peer_tmp_key SSL_get_server_tmp_key
+#endif
+
 /* Functionality missing in 1.0.2 */
 #if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b561e9d..4c08add 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2052,18 +2052,11 @@
     return ret;
 }

-/**
- * Print human readable information about the certifcate into buf
- * @param cert      the certificate being used
- * @param buf       output buffer
- * @param buflen    output buffer length
- */
 static void
-print_cert_details(X509 *cert, char *buf, size_t buflen)
+print_pkey_details(EVP_PKEY *pkey, char *buf, size_t buflen)
 {
     const char *curve =3D "";
     const char *type =3D "(error getting type)";
-    EVP_PKEY *pkey =3D X509_get_pubkey(cert);

     if (pkey =3D=3D NULL)
     {
@@ -2126,6 +2119,23 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     }

+    openvpn_snprintf(buf, buflen, "%d bits %s%s",
+                     EVP_PKEY_bits(pkey), type, curve);
+}
+
+/**
+ * Print human readable information about the certificate into buf
+ * @param cert      the certificate being used
+ * @param buf       output buffer
+ * @param buflen    output buffer length
+ */
+static void
+print_cert_details(X509 *cert, char *buf, size_t buflen)
+{
+    EVP_PKEY *pkey =3D X509_get_pubkey(cert);
+    char pkeybuf[128] =3D { 0 };
+    print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
+
     char sig[128] =3D { 0 };
     int signature_nid =3D X509_get_signature_nid(cert);
     if (signature_nid !=3D 0)
@@ -2134,8 +2144,27 @@
                          OBJ_nid2sn(signature_nid));
     }

-    openvpn_snprintf(buf, buflen, ", peer certificate: %d bit %s%s%s",
-                     EVP_PKEY_bits(pkey), type, curve, sig);
+    openvpn_snprintf(buf, buflen, ", peer certificate: %s%s",
+                     pkeybuf, sig);
+
+    EVP_PKEY_free(pkey);
+}
+
+static void
+print_server_tempkey(SSL *ssl, char *buf, size_t buflen)
+{
+    EVP_PKEY *pkey =3D NULL;
+    SSL_get_peer_tmp_key(ssl, &pkey);
+    if (!pkey)
+    {
+        return;
+    }
+
+    char pkeybuf[128] =3D { 0 };
+    print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
+
+    openvpn_snprintf(buf, buflen, ", peer temporary key: %s",
+                     pkeybuf);

     EVP_PKEY_free(pkey);
 }
@@ -2153,8 +2182,9 @@
     const SSL_CIPHER *ciph;
     char s1[256];
     char s2[256];
+    char s3[256];

-    s1[0] =3D s2[0] =3D 0;
+    s1[0] =3D s2[0] =3D s3[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2168,7 +2198,9 @@
         print_cert_details(cert, s2, sizeof(s2));
         X509_free(cert);
     }
-    msg(D_HANDSHAKE, "%s%s", s1, s2);
+    print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
+
+    msg(D_HANDSHAKE, "%s%s%s", s1, s2, s3);
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
Gerrit-Change-Number: 364
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ZROgHx9G5yY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/364?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Print peer temporary key details<br><br>The pe=
er temporary key in TLS session is related to the PFS<br>exchange/generatio=
n. From the SSL_get_peer_tmp_key manual page:<br><br>   For example, if ECD=
HE is in use, then this represents the<br>   peer&#39;s public ECDHE key.<b=
r><br>Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3<br>Acked-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20231009105518.3=
4432-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg27192.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/openssl_compat.h<br>M src/openv=
pn/ssl_openssl.c<br>2 files changed, 48 insertions(+), 12 deletions(-)<br><=
br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h=
</span><br><span>index efc85d4..f487b1b 100644</span><br><span>--- a/src/op=
envpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</=
span><br><span>@@ -75,6 +75,10 @@</span><br><span> #define RSA_F_RSA_OSSL_P=
RIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f (OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defined(ENABLE_CRYPT=
O_WOLFSSL)) || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSIO=
N_NUMBER &lt; 0x3050400fL)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define SSL_get_peer_tmp_key SSL_get_server_tmp_key</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /* Functionality missing in 1.0=
.2 */</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&am=
p; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> /**</span><br><span>dif=
f --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><=
span>index b561e9d..4c08add 100644</span><br><span>--- a/src/openvpn/ssl_op=
enssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ =
-2052,18 +2052,11 @@</span><br><span>     return ret;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Print human readable =
information about the certifcate into buf</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param cert      the certificate being used</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param buf       output buf=
fer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param buflen  =
  output buffer length</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-print_cert_details(X509 *cert, char *buf, size_t buflen)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkey_details(EVP_PKE=
Y *pkey, char *buf, size_t buflen)</span><br><span> {</span><br><span>     =
const char *curve =3D &quot;&quot;;</span><br><span>     const char *type =
=3D &quot;(error getting type)&quot;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    EVP_PKEY *pkey =3D X509_get_pubkey(cert);</span><br><sp=
an> </span><br><span>     if (pkey =3D=3D NULL)</span><br><span>     {</spa=
n><br><span>@@ -2126,6 +2119,23 @@</span><br><span> #endif /* if OPENSSL_VE=
RSION_NUMBER &lt; 0x30000000L */</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(=
buf, buflen, &quot;%d bits %s%s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     EVP_PKEY_bits(pkey), type, curve);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Print human readable information about the certificate into buf</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cert      the ce=
rtificate being used</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param buf       output buffer</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param buflen    output buffer length</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+print_cert_details(X509 *cert, char *buf, size_t buflen)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    EVP_PKEY *pkey =3D X509_get_pubkey(cert)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char pkeybuf[1=
28] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
rint_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     char sig[128] =3D { 0 =
};</span><br><span>     int signature_nid =3D X509_get_signature_nid(cert);=
</span><br><span>     if (signature_nid !=3D 0)</span><br><span>@@ -2134,8 =
+2144,27 @@</span><br><span>                          OBJ_nid2sn(signature_=
nid));</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    openvpn_snprintf(buf, buflen, &quot;, peer ce=
rtificate: %d bit %s%s%s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                     EVP_PKEY_bits(pkey), type, curve, sig);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(buf=
, buflen, &quot;, peer certificate: %s%s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     pkeybuf, sig);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    EVP_PKEY_free(pkey);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_server_te=
mpkey(SSL *ssl, char *buf, size_t buflen)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    EVP_PKEY *pkey =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SSL_get_peer_tmp_key(ssl, &amp;pkey);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!pkey)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char pkeybuf[128]=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prin=
t_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    openvpn_snprintf(buf, buflen, &quot;, peer temporary key: %s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
       pkeybuf);</span><br><span> </span><br><span>     EVP_PKEY_free(pkey)=
;</span><br><span> }</span><br><span>@@ -2153,8 +2182,9 @@</span><br><span>=
     const SSL_CIPHER *ciph;</span><br><span>     char s1[256];</span><br><=
span>     char s2[256];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char s3[256];</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    s1[0] =3D s2[0] =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    s1[0] =3D s2[0] =3D s3[0] =3D 0;</span><br><sp=
an>     ciph =3D SSL_get_current_cipher(ks_ssl-&gt;ssl);</span><br><span>  =
   openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s %s&quot;,</span>=
<br><span>                      prefix,</span><br><span>@@ -2168,7 +2198,9 =
@@</span><br><span>         print_cert_details(cert, s2, sizeof(s2));</span=
><br><span>         X509_free(cert);</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(D_HANDSHAKE, &quot;%s%s&quot;=
, s1, s2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print=
_server_tempkey(ks_ssl-&gt;ssl, s3, sizeof(s3));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_HANDSHAKE, &quot;%s%s%s&quot;, s1, s2, s3);</span><br><=
span> }</span><br><span> </span><br><span> void</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/36=
4?usp=3Demail">change 364</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf12bb51a2aac7bcf19070f0b56=
fa3b1a5863bc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZROgHx9G5yY=--

