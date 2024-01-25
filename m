From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 25 Jan 2024 12:37:10 +0000
In-Reply-To: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8a466f6346b4c207f2f1cc8812e2c37428251554-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dme92FSmHyE="; charset=UTF-8
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

--dme92FSmHyE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail

to look at the new patch set (#9).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
1 file changed, 81 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/365/9

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c30e6a9..9b6027c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2166,6 +2166,83 @@
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
+    const char *peer_sig =3D "unknown";
+    const char *peer_sig_type =3D "unknown type";
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
+#if (!defined(LIBRESSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER >=3D 0x10=
10000fL) \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >=3D 0=
x3090000fL)
+    /* LibreSSL 3.7.x and 3.8.x implement this function but do not export =
it
+     * and fail linking with an unresolved symbol */
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
@@ -2180,8 +2257,9 @@
     char s1[256];
     char s2[256];
     char s3[256];
+    char s4[256];

-    s1[0] =3D s2[0] =3D s3[0] =3D 0;
+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2196,8 +2274,9 @@
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
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--dme92FSmHyE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Print SSL peer signature information in hands=
hake debug details<br><br>This is more SSL debug information that most peop=
le do not really need<br>or care about. OpenSSL&#39;s own s_client also log=
s them:<br><br>Peer signing digest: SHA256<br>Peer signature type: ECDSA<br=
><br>The complete message looks like this:<br><br>   Control Channel: TLSv1=
.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bits RSA,=
 signature: RSA-SHA256, server temp key: 253 bits X25519, peer signing dige=
st/type: SHA256 RSASSA-PSS<br><br>or when forcing a specific group via tls-=
groups X448 with a ECDSA server:<br><br>   Control Channel: TLSv1.3, cipher=
 TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 384 bits ECsecp384r1, si=
gnature: ecdsa-with-SHA256, server temp key: 448 bits X448, peer signing di=
gest/type: SHA384 ECDSA<br><br>Change-Id: Ib5fc0c4b8f164596681ac5ad73002068=
ec6de1e5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M=
 src/openvpn/ssl_openssl.c<br>1 file changed, 81 insertions(+), 2 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
65/365/9</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_o=
penssl.c</span><br><span>index c30e6a9..9b6027c 100644</span><br><span>--- =
a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c=
</span><br><span>@@ -2166,6 +2166,83 @@</span><br><span>     EVP_PKEY_free(=
pkey);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUMBER)  &amp;&amp; O=
PENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Translate an OpenSSL NID into a more human readable name</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param nid</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+get_sigtype(int nid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Fix a few OpenSSL names to be better understandable */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    switch (nid)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case EVP_PKEY_RSA:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* will otherwise say rsaEncrypti=
on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn &quot;RSA&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case EVP_=
PKEY_DSA:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* dsaEncryption otherwise */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return &quot;DSA&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        case EVP_PKEY_EC:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* will say id-ecPublicKey */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return &quot;ECDSA&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case -1:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;(error getting n=
ame)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return OBJ_nid2sn(=
nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* ifndef LIBRESSL_VERSION_NUMBER */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Get the type of the signature that is used by the peer=
 during the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLS h=
andshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+print_peer_signature(SSL *ssl, char=
 *buf, size_t buflen)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_sig=
_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig =3D &quot;unknow=
n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *peer_sig_type =3D &quot;unknown type&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Even though these methods use the deprecated NIDs instead =
of using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * stri=
ng as new OpenSSL APIs do, there seem to be no API that replaces</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * it yet */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if !defined(LIBRESSL_VERSION_NUM=
BER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (SSL_get_peer_signature_nid(ssl, &amp;p=
eer_sig_nid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 &amp;&amp; peer_sig_nid !=3D NID_undef)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        peer_sig =3D OBJ_nid2sn(peer_sig_nid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if (!define=
d(LIBRESSL_VERSION_NUMBER) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x1010=
000fL) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    || (def=
ined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;=3D 0x=
3090000fL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Li=
breSSL 3.7.x and 3.8.x implement this function but do not export it</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * and fail linking wit=
h an unresolved symbol */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (SSL_get_peer_signature_type_nid(ssl, &amp;peer_sig_type_nid)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; p=
eer_sig_type_nid !=3D NID_undef)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       peer_sig_type =3D get_sigtype(peer_sig_type_nid);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p=
eer_sig_nid =3D=3D NID_undef &amp;&amp; peer_sig_type_nid =3D=3D NID_undef)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    openvpn_snprintf(buf, buflen, &quot;, peer signing digest/type: %s=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            peer_sig, peer_sig_type);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* *****************=
*********************</span><br><span>  *</span><br><span>  * Information f=
unctions</span><br><span>@@ -2180,8 +2257,9 @@</span><br><span>     char s1=
[256];</span><br><span>     char s2[256];</span><br><span>     char s3[256]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char s4[256];<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
s1[0] =3D s2[0] =3D s3[0] =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;</span><br><span=
>     ciph =3D SSL_get_current_cipher(ks_ssl-&gt;ssl);</span><br><span>    =
 openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s %s&quot;,</span><b=
r><span>                      prefix,</span><br><span>@@ -2196,8 +2274,9 @@=
</span><br><span>         X509_free(cert);</span><br><span>     }</span><br=
><span>     print_server_tempkey(ks_ssl-&gt;ssl, s3, sizeof(s3));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    print_peer_signature(ks_s=
sl-&gt;ssl, s4, sizeof(s4));</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_HANDSHAKE, &quot;%s%s%s&quot;, s1, s2, s=
3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_HANDSH=
AKE, &quot;%s%s%s%s&quot;, s1, s2, s3, s4);</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">chang=
e 365</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad730=
02068ec6de1e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 365 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--dme92FSmHyE=--

