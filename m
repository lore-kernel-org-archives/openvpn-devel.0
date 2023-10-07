From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 10:25:30 +0000
References: <gerrit.1696674325000.Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0fb67add13ea3821afaf15233e1a2585fdebfec3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aqmEK1OTrN4="; charset=UTF-8
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

--aqmEK1OTrN4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail

to review the following change.


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
1 file changed, 78 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/365/1

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b91ea07..683d76a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2169,6 +2169,80 @@
     EVP_PKEY_free(pkey);
 }

+#ifndef LIBRESSL_VERSION_NUMBER
+/**
+ * Translate an OpenVPN NID into a more human readable name
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
+    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
+        && peer_sig_nid !=3D NID_undef)
+    {
+        peer_sig =3D OBJ_nid2sn(peer_sig_nid);
+    }
+
+#ifndef LIBRESSL_VERSION_NUMBER
+    /* LibreSSL 3.7.x and 3.8.0 weirdly implment this function but fail on
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
@@ -2183,8 +2257,9 @@
     char s1[256];
     char s2[256];
     char s3[256];
+    char s4[256];

-    s1[0] =3D s2[0] =3D s3[0] =3D 0;
+    s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
     openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
                      prefix,
@@ -2199,8 +2274,9 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--aqmEK1OTrN4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Print SSL peer signature information in handshake debug detai=
ls<br><br>This is more SSL debug information that most people do not really=
 need<br>or care about. OpenSSL&#39;s own s_client also logs them:<br><br>P=
eer signing digest: SHA256<br>Peer signature type: ECDSA<br><br>The complet=
e message looks like this:<br><br>   Control Channel: TLSv1.3, cipher TLSv1=
.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bits RSA, signature: RSA-=
SHA256, server temp key: 253 bits X25519, peer signing digest/type: SHA256 =
RSASSA-PSS<br><br>or when forcing a specific group via tls-groups X448 with=
 a ECDSA server:<br><br>   Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES=
_256_GCM_SHA384, peer certificate: 384 bits ECsecp384r1, signature: ecdsa-w=
ith-SHA256, server temp key: 448 bits X448, peer signing digest/type: SHA38=
4 ECDSA<br><br>Change-Id: Ib5fc0c4b8f164596681ac5ad73002068ec6de1e5<br>---<=
br>M src/openvpn/ssl_openssl.c<br>1 file changed, 78 insertions(+), 2 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/65/365/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/s=
sl_openssl.c</span><br><span>index b91ea07..683d76a 100644</span><br><span>=
--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_opens=
sl.c</span><br><span>@@ -2169,6 +2169,80 @@</span><br><span>     EVP_PKEY_f=
ree(pkey);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef LIBRESSL_VERSION_NUMBER</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Translate an OpenVPN NID into a more human reada=
ble name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+get_sigtype(int nid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Fix a few OpenSSL names to be better understandable=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (nid)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case EVP_PKEY_RSA:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* will otherw=
ise say rsaEncryption */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return &quot;RSA&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case EVP_PKEY_DSA:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* dsaEncryption otherwise */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return &quot;DSA&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case EVP_PKEY_EC:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* will say id-ecPublicKey */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
&quot;ECDSA&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case -1:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quo=
t;(error getting name)&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
efault:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return OBJ_nid2sn(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef LIBRESSL_VE=
RSION_NUMBER */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Get the type of the signature that i=
s used by the peer during the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * TLS handshake</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_peer_signat=
ure(SSL *ssl, char *buf, size_t buflen)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int peer_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig=
 =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *peer_sig_type =3D &quot;&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Even though these methods use the deprecated NIDs instead of=
 using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * string=
 as new OpenSSL APIs do, there seem to be no API that replaces</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * it yet */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (SSL_get_peer_signature_nid(=
ssl, &amp;peer_sig_nid)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        &amp;&amp; peer_sig_nid !=3D NID_undef)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        peer_sig =3D OBJ_nid2sn(peer_sig_nid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef LIBRESSL_VERSION_NUMBER</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* LibreSSL 3.7.x and 3.8.0 weirdly implment=
 this function but fail on</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * linking with an unresolved symbol */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (SSL_get_peer_signature_type_nid(ssl,=
 &amp;peer_sig_type_nid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        &amp;&amp; peer_sig_type_nid !=3D NID_undef)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        peer_sig_type =3D get_sigtype(peer_sig_type=
_nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (peer_sig_nid =3D=3D NID_undef &amp;&amp; peer_sig_t=
ype_nid =3D=3D NID_undef)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    openvpn_snprintf(buf, buflen, &quot;, pee=
r signing digest/type: %s %s&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     peer_sig, peer_sig_type);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /* **************************************</span><br><span>  *</span><b=
r><span>  * Information functions</span><br><span>@@ -2183,8 +2257,9 @@</sp=
an><br><span>     char s1[256];</span><br><span>     char s2[256];</span><b=
r><span>     char s3[256];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char s4[256];</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    s1[0] =3D s2[0] =3D s3[0] =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    s1[0] =3D s2[0] =3D s3[0] =3D s4[=
0] =3D 0;</span><br><span>     ciph =3D SSL_get_current_cipher(ks_ssl-&gt;s=
sl);</span><br><span>     openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cip=
her %s %s&quot;,</span><br><span>                      prefix,</span><br><s=
pan>@@ -2199,8 +2274,9 @@</span><br><span>         X509_free(cert);</span><=
br><span>     }</span><br><span>     print_server_tempkey(ks_ssl-&gt;ssl, s=
3, sizeof(s3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
print_peer_signature(ks_ssl-&gt;ssl, s4, sizeof(s4));</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_HANDSHAKE, &quo=
t;%s%s%s&quot;, s1, s2, s3);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_HANDSHAKE, &quot;%s%s%s%s&quot;, s1, s2, s3, s4);</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/365?usp=3Demail">change 365</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/365?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5fc0c4b8f164596681ac5ad730=
02068ec6de1e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 365 </div>
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


--aqmEK1OTrN4=--

