From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 11:07:01 +0000
In-Reply-To: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6e761f99d3647baedcb9d9b91661496560f9c17d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X2N5VqOZNQw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print SSL peer
 signature information in handshake debug details
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

--X2N5VqOZNQw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail

to look at the new patch set (#5).


Change subject: Print SSL peer signature information in handshake debug det=
ails
......................................................................

Print SSL peer signature information in handshake debug details

This is more SSL debug information that most people do not really need
or care about. OpenSSL's own s_client also logs them:

Peer signing digest: SHA256
Peer signature type: ECDSA

The complete message looks like this:

   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer ce=
rtificate: 2048 bits RSA, signature: RSA-SHA256, server temp key: 253 bits =
X25519, peer signing digest/type: SHA256 RSASSA-PSS

or when forcing a specific group via tls-groups X448 with a ECDSA server:

   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer ce=
rtificate: 384 bits ECsecp384r1, signature: ecdsa-with-SHA256, server temp =
key: 448 bits X448, peer signing digest/type: SHA384 ECDSA

Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5
---
M src/openvpn/ssl_openssl.c
1 file changed, 81 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/365/5

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b91ea07..26a478b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2163,12 +2163,88 @@
     char pkeybuf[128] =3D { 0 };
     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));

-    openvpn_snprintf(buf, buflen, ", server temp key: %s",
+    openvpn_snprintf(buf, buflen, ", peer temporary key: %s",
                      pkeybuf);

     EVP_PKEY_free(pkey);
 }

+#if !defined(LIBRESSL_VERSION_NUMBER)  && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL
+/**
+ * Translate an OpenSSL NID into a more human readable name
+ * @param nid
+ * @return
+ */
+static const char *
+get_sigtype(int nid)
+{
+    /* Fix a few OpenSSL names to be better understandable */
+    switch (nid)
+    {
+        case EVP_PKEY_RSA:
+            /* will otherwise say rsaEncryption */
+            return "RSA";
+
+        case EVP_PKEY_DSA:
+            /* dsaEncryption otherwise */
+            return "DSA";
+
+        case EVP_PKEY_EC:
+            /* will say id-ecPublicKey */
+            return "ECDSA";
+
+        case -1:
+            return "(error getting name)";
+
+        default:
+            return OBJ_nid2sn(nid);
+    }
+}
+#endif /* ifndef LIBRESSL_VERSION_NUMBER */
+
+/**
+ * Get the type of the signature that is used by the peer during the
+ * TLS handshake
+ */
+static void
+print_peer_signature(SSL *ssl, char *buf, size_t buflen)
+{
+    int peer_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;
+    const char *peer_sig =3D "";
+    const char *peer_sig_type =3D "";
+
+    /* Even though these methods use the deprecated NIDs instead of using
+     * string as new OpenSSL APIs do, there seem to be no API that replaces
+     * it yet */
+#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x30504=
00fL
+    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
+        && peer_sig_nid !=3D NID_undef)
+    {
+        peer_sig =3D OBJ_nid2sn(peer_sig_nid);
+    }
+#endif
+
+#if !defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x101=
0000fL
+    /* LibreSSL 3.7.x and 3.8.0 weirdly implement this function but fail on
+     * linking with an unresolved symbol */
+    if (SSL_get_peer_signature_type_nid(ssl, &peer_sig_type_nid)
+        && peer_sig_type_nid !=3D NID_undef)
+    {
+        peer_sig_type =3D get_sigtype(peer_sig_type_nid);
+    }
+#endif
+
+    if (peer_sig_nid =3D=3D NID_undef && peer_sig_type_nid =3D=3D NID_unde=
f)
+    {
+        return;
+    }
+
+    openvpn_snprintf(buf, buflen, ", peer signing digest/type: %s %s",
+                     peer_sig, peer_sig_type);
+}
+
+
+
 /* **************************************
  *
  * Information functions
@@ -2183,8 +2259,9 @@
     char s1[256];
     char s2[256];
     char s3[256];
+    char s4[256];

-    s1[0] =3D s2[0] =3D s3[0] =3D 0;
+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2199,8 +2276,9 @@
         X509_free(cert);
     }
     print_server_tempkey(ks_ssl->ssl, s3, sizeof(s3));
+    print_peer_signature(ks_ssl->ssl, s4, sizeof(s4));

-    msg(D_HANDSHAKE, "%s%s%s", s1, s2, s3);
+    msg(D_HANDSHAKE, "%s%s%s%s", s1, s2, s3, s4);
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5
Gerrit-Change-Number: 365
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--X2N5VqOZNQw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Print SSL peer signature information in handshake debug details<br><b=
r>This is more SSL debug information that most people do not really need<br=
>or care about. OpenSSL&#39;s own s_client also logs them:<br><br>Peer sign=
ing digest: SHA256<br>Peer signature type: ECDSA<br><br>The complete messag=
e looks like this:<br><br>   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_A=
ES_256_GCM_SHA384, peer certificate: 2048 bits RSA, signature: RSA-SHA256, =
server temp key: 253 bits X25519, peer signing digest/type: SHA256 RSASSA-P=
SS<br><br>or when forcing a specific group via tls-groups X448 with a ECDSA=
 server:<br><br>   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM=
_SHA384, peer certificate: 384 bits ECsecp384r1, signature: ecdsa-with-SHA2=
56, server temp key: 448 bits X448, peer signing digest/type: SHA384 ECDSA<=
br><br>Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5<br>---<br>M src=
/openvpn/ssl_openssl.c<br>1 file changed, 81 insertions(+), 3 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/3=
65/5</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_opens=
sl.c</span><br><span>index b91ea07..26a478b 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</sp=
an><br><span>@@ -2163,12 +2163,88 @@</span><br><span>     char pkeybuf[128]=
 =3D { 0 };</span><br><span>     print_pkey_details(pkey, pkeybuf, sizeof(p=
keybuf));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    openvpn_snprintf(buf, buflen, &quot;, server temp key: %s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf=
(buf, buflen, &quot;, peer temporary key: %s&quot;,</span><br><span>       =
               pkeybuf);</span><br><span> </span><br><span>     EVP_PKEY_fr=
ee(pkey);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER)  &amp;&amp=
; OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Translate an OpenSSL NID into a more human readable name</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param nid</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+get_sigtype(int nid)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Fix a few OpenSSL names to be better understandable */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    switch (nid)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case EVP_PKEY_RSA:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* will otherwise say rsaEncr=
yption */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return &quot;RSA&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case =
EVP_PKEY_DSA:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* dsaEncryption otherwise */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return &quot;DSA&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case EVP_PKEY_EC:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* will say id-ecPublicKey */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return &quot;ECDSA&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case -1:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return &quot;(error gett=
ing name)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return OBJ_ni=
d2sn(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef LIBRESSL_VERSION_NUMBER =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Get the type of the signature that is used by the=
 peer during the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
TLS handshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+print_peer_signature(SSL *ssl,=
 char *buf, size_t buflen)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int pee=
r_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig =3D &quot;&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *peer_sig_type =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Even though these methods use the deprecated NIDs instead of using</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * string as new OpenS=
SL APIs do, there seem to be no API that replaces</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * it yet */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESS=
L_VERSION_NUMBER &gt; 0x3050400fL</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (SSL_get_peer_signature_nid(ssl, &amp;peer_sig_nid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; pee=
r_sig_nid !=3D NID_undef)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
peer_sig =3D OBJ_nid2sn(peer_sig_nid);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSI=
ON_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* LibreSSL 3.7.x and 3.8.=
0 weirdly implement this function but fail on</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * linking with an unresolved symbol */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (SSL_get_peer_sign=
ature_type_nid(ssl, &amp;peer_sig_type_nid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        &amp;&amp; peer_sig_type_nid !=3D NID_undef=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        peer_sig_type =3D get_si=
gtype(peer_sig_type_nid);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (peer_sig_nid =3D=3D NID_undef &a=
mp;&amp; peer_sig_type_nid =3D=3D NID_undef)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(buf, =
buflen, &quot;, peer signing digest/type: %s %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     peer_sig, peer_sig_=
type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /* **************************************</span><br=
><span>  *</span><br><span>  * Information functions</span><br><span>@@ -21=
83,8 +2259,9 @@</span><br><span>     char s1[256];</span><br><span>     cha=
r s2[256];</span><br><span>     char s3[256];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char s4[256];</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    s1[0] =3D s2[0] =3D s3[0] =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s1[0] =3D s2[0=
] =3D s3[0] =3D s4[0] =3D 0;</span><br><span>     ciph =3D SSL_get_current_=
cipher(ks_ssl-&gt;ssl);</span><br><span>     openvpn_snprintf(s1, sizeof(s1=
), &quot;%s %s, cipher %s %s&quot;,</span><br><span>                      p=
refix,</span><br><span>@@ -2199,8 +2276,9 @@</span><br><span>         X509_=
free(cert);</span><br><span>     }</span><br><span>     print_server_tempke=
y(ks_ssl-&gt;ssl, s3, sizeof(s3));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    print_peer_signature(ks_ssl-&gt;ssl, s4, sizeof(s4));</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_HANDSHAKE, &quot;%s%s%s&quot;, s1, s2, s3);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_HANDSHAKE, &quot;%s%s%s%s&quot;, s1, =
s2, s3, s4);</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/365?usp=3Demail">change 365</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/365?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad730=
02068ec6de1e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 365 </div>
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


--X2N5VqOZNQw=--

