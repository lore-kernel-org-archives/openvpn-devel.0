From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 09:46:07 +0000
In-Reply-To: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
References: <gerrit.1696674325000.Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <10d6eea399bf041d9a165bba4ec34aef5a211f27-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="41dfCc7sxPg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print server temp
 key details
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

--41dfCc7sxPg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail

to look at the new patch set (#3).


Change subject: Print server temp key details
......................................................................

Print server temp key details

Change-Id: Iaf12bb51a2aac7bcf19070f0b56fa3b1a5863bc3
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 48 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/364/3

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index efc85d4..d79f0f4 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -75,6 +75,10 @@
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif

+#if (OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSS=
L)) || defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050=
400fL
+#define SSL_get_peer_tmp_key SSL_get_server_tmp_key
+#endif
+
 /* Functionality missing in 1.0.2 */
 #if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b5cc9a7..b91ea07 100644
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
+ * Print human readable information about the certifcate into buf
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
+    openvpn_snprintf(buf, buflen, ", server temp key: %s",
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--41dfCc7sxPg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Print server temp key details<br><br>Change-Id: Iaf12bb51a2aac7bcf190=
70f0b56fa3b1a5863bc3<br>---<br>M src/openvpn/openssl_compat.h<br>M src/open=
vpn/ssl_openssl.c<br>2 files changed, 48 insertions(+), 12 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/364/=
3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_c=
ompat.h</span><br><span>index efc85d4..d79f0f4 100644</span><br><span>--- a=
/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_com=
pat.h</span><br><span>@@ -75,6 +75,10 @@</span><br><span> #define RSA_F_RSA=
_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT</span><br><span> =
#endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if (OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defined(ENABL=
E_CRYPTO_WOLFSSL)) || defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_=
VERSION_NUMBER &lt; 0x3050400fL</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define SSL_get_peer_tmp_key SSL_get_server_tmp_key</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* Functionality missing i=
n 1.0.2 */</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &am=
p;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> /**</span><br><spa=
n>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span>=
<br><span>index b5cc9a7..b91ea07 100644</span><br><span>--- a/src/openvpn/s=
sl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><spa=
n>@@ -2052,18 +2052,11 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Print human read=
able information about the certifcate into buf</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param cert      the certificate being used</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param buf       outpu=
t buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param buf=
len    output buffer length</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-print_cert_details(X509 *cert, char *buf, size_t buflen)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkey_details(EV=
P_PKEY *pkey, char *buf, size_t buflen)</span><br><span> {</span><br><span>=
     const char *curve =3D &quot;&quot;;</span><br><span>     const char *t=
ype =3D &quot;(error getting type)&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    EVP_PKEY *pkey =3D X509_get_pubkey(cert);</span><br=
><span> </span><br><span>     if (pkey =3D=3D NULL)</span><br><span>     {<=
/span><br><span>@@ -2126,6 +2119,23 @@</span><br><span> #endif /* if OPENSS=
L_VERSION_NUMBER &lt; 0x30000000L */</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snpri=
ntf(buf, buflen, &quot;%d bits %s%s&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     EVP_PKEY_bits(pkey), type, curv=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Print human readable information about the certifcate into buf</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cert      the=
 certificate being used</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf       output buffer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param buflen    output buffer length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+print_cert_details(X509 *cert, char *buf, size_t buflen)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_PKEY *pkey =3D X509_get_pubkey(ce=
rt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char pkeybu=
f[128] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     char sig[128] =3D {=
 0 };</span><br><span>     int signature_nid =3D X509_get_signature_nid(cer=
t);</span><br><span>     if (signature_nid !=3D 0)</span><br><span>@@ -2134=
,8 +2144,27 @@</span><br><span>                          OBJ_nid2sn(signatu=
re_nid));</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(buf, buflen, &quot;, peer=
 certificate: %d bit %s%s%s&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                     EVP_PKEY_bits(pkey), type, curve, sig);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(=
buf, buflen, &quot;, peer certificate: %s%s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     pkeybuf, sig);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    EVP_PKEY_free(pkey);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_serve=
r_tempkey(SSL *ssl, char *buf, size_t buflen)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    EVP_PKEY *pkey =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SSL_get_peer_tmp_key(ssl, &amp;pkey);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!pkey)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char pkeybuf[=
128] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    openvpn_snprintf(buf, buflen, &quot;, server temp key: %=
s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          pkeybuf);</span><br><span> </span><br><span>     EVP_PKEY_free(pk=
ey);</span><br><span> }</span><br><span>@@ -2153,8 +2182,9 @@</span><br><sp=
an>     const SSL_CIPHER *ciph;</span><br><span>     char s1[256];</span><b=
r><span>     char s2[256];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char s3[256];</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    s1[0] =3D s2[0] =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    s1[0] =3D s2[0] =3D s3[0] =3D 0;</span><br>=
<span>     ciph =3D SSL_get_current_cipher(ks_ssl-&gt;ssl);</span><br><span=
>     openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s %s&quot;,</sp=
an><br><span>                      prefix,</span><br><span>@@ -2168,7 +2198=
,9 @@</span><br><span>         print_cert_details(cert, s2, sizeof(s2));</s=
pan><br><span>         X509_free(cert);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    msg(D_HANDSHAKE, &quot;%s%s&qu=
ot;, s1, s2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
int_server_tempkey(ks_ssl-&gt;ssl, s3, sizeof(s3));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_HANDSHAKE, &quot;%s%s%s&quot;, s1, s2, s3);</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/364?usp=3Demail">change 364</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/364?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf12bb51a2aac7bcf19070f0b56=
fa3b1a5863bc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--41dfCc7sxPg=--

