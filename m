From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 11:33:58 +0000
In-Reply-To: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
References: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c2764165f4f46486827dc329706803a0d0a4fa4b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FdmAEOXQ8d4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use
 SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid
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

--FdmAEOXQ8d4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail

to look at the new patch set (#2).


Change subject: Use SSL_get0_peer_signature_name instead of SSL_get_peer_si=
gnature_nid
......................................................................

Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid

SSL_get0_peer_signature_name returns a string instead of hardcoded NIDs.
NIDS do not work with provider provided signatures or the new PQ
signatures introduced in OpenSSL 3.5.

Remove also the comment that was added earlier that says that there no
proper API replacement for SSL_get_peer_signature_nid yet as OpenSSL
3.5.0 has now introduced it.

Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 34 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/927/2

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3e3b406..e2bd9bf 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -173,4 +173,30 @@

 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */

+#if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VERSION_NUMB=
ER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL)
+static inline int
+SSL_get0_peer_signature_name(SSL *ssl, const char **sigalg)
+{
+    int peer_sig_nid;
+    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
+        && peer_sig_nid !=3D NID_undef)
+    {
+        *sigalg =3D OBJ_nid2sn(peer_sig_nid);
+        return 1;
+    }
+    return 0;
+}
+#elif defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <=3D 0x3=
050400fL
+/* The older LibreSSL version do not implement any variant of getting the =
peer
+ * signature */
+static inline int
+SSL_get0_peer_signature_name(const SSL *ssl, const char **sigalg)
+{
+    *sigalg =3D NULL;
+    return 0;
+}
+#endif /* if OPENSSL_VERSION_NUMBER < 0x30500000 && (!defined(LIBRESSL_VER=
SION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3050400fL) */
+
+
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index aad79a4..23b0266 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2454,20 +2454,17 @@
 static void
 print_peer_signature(SSL *ssl, char *buf, size_t buflen)
 {
-    int peer_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;
-    const char *peer_sig =3D "unknown";
+    int peer_sig_type_nid =3D NID_undef;
+    const char *peer_sig_unknown =3D "unknown";
+    const char *peer_sig =3D peer_sig_unknown;
     const char *peer_sig_type =3D "unknown type";
=20
-    /* Even though these methods use the deprecated NIDs instead of using
-     * string as new OpenSSL APIs do, there seem to be no API that replaces
-     * it yet */
-#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x30504=
00fL
-    if (SSL_get_peer_signature_nid(ssl, &peer_sig_nid)
-        && peer_sig_nid !=3D NID_undef)
+    const char *signame =3D NULL;
+    SSL_get0_peer_signature_name(ssl, &signame);
+    if (signame)
     {
-        peer_sig =3D OBJ_nid2sn(peer_sig_nid);
+        peer_sig =3D signame;
     }
-#endif

 #if !defined(LIBRESSL_VERSION_NUMBER) \
     || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER >=3D 0=
x3090000fL)
@@ -2480,7 +2477,7 @@
     }
 #endif

-    if (peer_sig_nid =3D=3D NID_undef && peer_sig_type_nid =3D=3D NID_unde=
f)
+    if (peer_sig =3D=3D peer_sig_unknown && peer_sig_type_nid =3D=3D NID_u=
ndef)
     {
         return;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Gerrit-Change-Number: 927
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--FdmAEOXQ8d4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_ni=
d<br><br>SSL_get0_peer_signature_name returns a string instead of hardcoded=
 NIDs.<br>NIDS do not work with provider provided signatures or the new PQ<=
br>signatures introduced in OpenSSL 3.5.<br><br>Remove also the comment tha=
t was added earlier that says that there no<br>proper API replacement for S=
SL_get_peer_signature_nid yet as OpenSSL<br>3.5.0 has now introduced it.<br=
><br>Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6<br>Signed-off-by:=
 Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/openssl_compa=
t.h<br>M src/openvpn/ssl_openssl.c<br>2 files changed, 34 insertions(+), 11=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/27/927/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat.h b/src/=
openvpn/openssl_compat.h</span><br><span>index 3e3b406..e2bd9bf 100644</spa=
n><br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/op=
envpn/openssl_compat.h</span><br><span>@@ -173,4 +173,30 @@</span><br><span=
> </span><br><span> #endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; (!defined(LIBRESSL_VERSIO=
N_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SSL_get0_peer_signature_name(SSL *ssl, co=
nst char **sigalg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_sig_ni=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (SSL_get_p=
eer_signature_nid(ssl, &amp;peer_sig_nid)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &amp;&amp; peer_sig_nid !=3D NID_undef)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *sigalg =3D OBJ_nid2sn(peer_sig=
_nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#elif defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIB=
RESSL_VERSION_NUMBER &lt;=3D 0x3050400fL</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* The older LibreSSL version do not implement any var=
iant of getting the peer</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * signature */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
SL_get0_peer_signature_name(const SSL *ssl, const char **sigalg)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    *sigalg =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif /* if OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; (!defin=
ed(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><b=
r><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<=
/span><br><span>index aad79a4..23b0266 100644</span><br><span>--- a/src/ope=
nvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><b=
r><span>@@ -2454,20 +2454,17 @@</span><br><span> static void</span><br><spa=
n> print_peer_signature(SSL *ssl, char *buf, size_t buflen)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_sig_n=
id =3D NID_undef, peer_sig_type_nid =3D NID_undef;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *peer_sig =3D &quot;unknown&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_sig=
_type_nid =3D NID_undef;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *peer_sig_unknown =3D &quot;unknown&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig =3D pee=
r_sig_unknown;</span><br><span>     const char *peer_sig_type =3D &quot;unk=
nown type&quot;;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* Even though these methods use the deprecated NIDs inste=
ad of using</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * str=
ing as new OpenSSL APIs do, there seem to be no API that replaces</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * it yet */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if !defined(LIBRESSL_VERSION_NUMBER=
) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (SSL_get_peer_signature_nid(ssl, &amp;peer_s=
ig_nid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&=
amp; peer_sig_nid !=3D NID_undef)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *signame =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SSL_get0_peer_signature_name(ssl, &amp;sign=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (signam=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        peer_sig =3D OBJ_nid2sn(peer_sig_nid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        peer_sig =3D signame;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span> </span><br><span> #if !defined(LIBRESSL_VERSION_NUMBER) \</span>=
<br><span>     || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VER=
SION_NUMBER &gt;=3D 0x3090000fL)</span><br><span>@@ -2480,7 +2477,7 @@</spa=
n><br><span>     }</span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (peer_sig_nid =3D=3D NID_unde=
f &amp;&amp; peer_sig_type_nid =3D=3D NID_undef)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (peer_sig =3D=3D peer_sig_unknown &amp;=
&amp; peer_sig_type_nid =3D=3D NID_undef)</span><br><span>     {</span><br>=
<span>         return;</span><br><span>     }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?=
usp=3Demail">change 927</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bc782ceebcc91a8dc8ada0bb72=
ac042be46cad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 927 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FdmAEOXQ8d4=--

