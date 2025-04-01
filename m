From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 08:29:09 +0000
References: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0f0e384b4a08b4c0752a0514b19cebe8abe2f126-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0QnPjE3jup4="; charset=UTF-8
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

--0QnPjE3jup4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail

to review the following change.


Change subject: Use SSL_get0_peer_signature_name instead of SSL_get_peer_si=
gnature_nid
......................................................................

Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid

SSL_get0_peer_signature_name return a string instead of hardcoded NIDs that
do not work with provider provided signatures or the new PQ signatures
introduced in OpenSSL 3.5.

Remove also the comment that was added earlier that says that there no
proper API replacement for SSL_get_peer_signature_nid yet as OpenSSL
3.5.0 has now introduced it.

Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 34 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/927/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0QnPjE3jup4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use SSL_get0_peer_signature_name instead of SSL_get_peer_sign=
ature_nid<br><br>SSL_get0_peer_signature_name return a string instead of ha=
rdcoded NIDs that<br>do not work with provider provided signatures or the n=
ew PQ signatures<br>introduced in OpenSSL 3.5.<br><br>Remove also the comme=
nt that was added earlier that says that there no<br>proper API replacement=
 for SSL_get_peer_signature_nid yet as OpenSSL<br>3.5.0 has now introduced =
it.<br><br>Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/openssl=
_compat.h<br>M src/openvpn/ssl_openssl.c<br>2 files changed, 34 insertions(=
+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/27/927/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat.h =
b/src/openvpn/openssl_compat.h</span><br><span>index 3e3b406..e2bd9bf 10064=
4</span><br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/=
src/openvpn/openssl_compat.h</span><br><span>@@ -173,4 +173,30 @@</span><br=
><span> </span><br><span> #endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L=
 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; (!defined(LIBRESSL_=
VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SSL_get0_peer_signature_name(SSL *ss=
l, const char **sigalg)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_s=
ig_nid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (SSL_=
get_peer_signature_nid(ssl, &amp;peer_sig_nid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        &amp;&amp; peer_sig_nid !=3D NID_undef)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        *sigalg =3D OBJ_nid2sn(pee=
r_sig_nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#elif defined(LIBRESSL_VERSION_NUMBER) &amp;&amp=
; LIBRESSL_VERSION_NUMBER &lt;=3D 0x3050400fL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* The older LibreSSL version do not implement an=
y variant of getting the peer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * signature */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+SSL_get0_peer_signature_name(const SSL *ssl, const char **sigalg)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    *sigalg =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* if OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; =
(!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x305040=
0fL) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_ */</=
span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_ope=
nssl.c</span><br><span>index aad79a4..23b0266 100644</span><br><span>--- a/=
src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</=
span><br><span>@@ -2454,20 +2454,17 @@</span><br><span> static void</span><=
br><span> print_peer_signature(SSL *ssl, char *buf, size_t buflen)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int pee=
r_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_undef;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *peer_sig =3D &quot;unkn=
own&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p=
eer_sig_type_nid =3D NID_undef;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *peer_sig_unknown =3D &quot;unknown&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig =
=3D peer_sig_unknown;</span><br><span>     const char *peer_sig_type =3D &q=
uot;unknown type&quot;;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Even though these methods use the deprecated NID=
s instead of using</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * string as new OpenSSL APIs do, there seem to be no API that replaces</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * it yet */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(LIBRESSL_VERSION=
_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (SSL_get_peer_signature_nid(ssl, &am=
p;peer_sig_nid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  &amp;&amp; peer_sig_nid !=3D NID_undef)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *signame =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    SSL_get0_peer_signature_name(ssl, &=
amp;signame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (signame)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        peer_sig =3D OBJ_nid2sn(peer_sig_nid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        peer_sig =3D signame;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span> </span><br><span> #if !defined(LIBRESSL_VERSION_NUMBER) =
\</span><br><span>     || (defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBR=
ESSL_VERSION_NUMBER &gt;=3D 0x3090000fL)</span><br><span>@@ -2480,7 +2477,7=
 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (peer_sig_nid =3D=3D =
NID_undef &amp;&amp; peer_sig_type_nid =3D=3D NID_undef)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (peer_sig =3D=3D peer_sig_unkno=
wn &amp;&amp; peer_sig_type_nid =3D=3D NID_undef)</span><br><span>     {</s=
pan><br><span>         return;</span><br><span>     }</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/927?usp=3Demail">change 927</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bc782ceebcc91a8dc8ada0bb72=
ac042be46cad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 927 </div>
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


--0QnPjE3jup4=--

