From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 11:38:18 +0000
In-Reply-To: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
References: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4ab536d09d8e6eb46990599e7a673ff1367e448d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CSoFwfsww5I="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CSoFwfsww5I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

ordex has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail )


Change subject: Use SSL_get0_peer_signature_name instead of SSL_get_peer_si=
gnature_nid
......................................................................

Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid

SSL_get0_peer_signature_name returns a string instead of hardcoded NIDs.
NIDS do not work with provider provided signatures or the new PQ
signatures introduced in OpenSSL 3.5.

Remove also the comment that was added earlier that says that there
is no proper API replacement for SSL_get_peer_signature_nid yet as OpenSSL
3.5.0 has now introduced it.

Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 34 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/927/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--CSoFwfsww5I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>ordex <strong>uploaded patch set #3</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
927?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Use SSL_get0_peer_signature_name instead o=
f SSL_get_peer_signature_nid<br><br>SSL_get0_peer_signature_name returns a =
string instead of hardcoded NIDs.<br>NIDS do not work with provider provide=
d signatures or the new PQ<br>signatures introduced in OpenSSL 3.5.<br><br>=
Remove also the comment that was added earlier that says that there<br>is n=
o proper API replacement for SSL_get_peer_signature_nid yet as OpenSSL<br>3=
.5.0 has now introduced it.<br><br>Change-Id: I2bc782ceebcc91a8dc8ada0bb72a=
c042be46cad6<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M src/openvpn/openssl_compat.h<br>M src/openvpn/ssl_openssl.c<br>2 files=
 changed, 34 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/27/927/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>inde=
x 3e3b406..e2bd9bf 100644</span><br><span>--- a/src/openvpn/openssl_compat.=
h</span><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -17=
3,4 +173,30 @@</span><br><span> </span><br><span> #endif /* OPENSSL_VERSION=
_NUMBER &lt; 0x30000000L */</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&=
amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3=
050400fL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inl=
ine int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SSL_get0_pee=
r_signature_name(SSL *ssl, const char **sigalg)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int peer_sig_nid;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (SSL_get_peer_signature_nid(ssl, &amp;peer_sig_nid)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; peer_=
sig_nid !=3D NID_undef)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *s=
igalg =3D OBJ_nid2sn(peer_sig_nid);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(LIBRESSL_V=
ERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt;=3D 0x3050400fL</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The older LibreSSL ver=
sion do not implement any variant of getting the peer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * signature */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SSL_get0_peer_signature_name(const SSL *ssl, co=
nst char **sigalg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *sigalg =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* if OPENSSL_VERSION_NUMBER &lt; =
0x30500000 &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSIO=
N_NUMBER &gt; 0x3050400fL) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* =
OPENSSL_COMPAT_H_ */</span><br><span>diff --git a/src/openvpn/ssl_openssl.c=
 b/src/openvpn/ssl_openssl.c</span><br><span>index aad79a4..23b0266 100644<=
/span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/o=
penvpn/ssl_openssl.c</span><br><span>@@ -2454,20 +2454,17 @@</span><br><spa=
n> static void</span><br><span> print_peer_signature(SSL *ssl, char *buf, s=
ize_t buflen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int peer_sig_nid =3D NID_undef, peer_sig_type_nid =3D NID_un=
def;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *p=
eer_sig =3D &quot;unknown&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int peer_sig_type_nid =3D NID_undef;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *peer_sig_unknown =3D &quo=
t;unknown&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *peer_sig =3D peer_sig_unknown;</span><br><span>     const char=
 *peer_sig_type =3D &quot;unknown type&quot;;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Even though these methods =
use the deprecated NIDs instead of using</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * string as new OpenSSL APIs do, there seem to be n=
o API that replaces</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * it yet */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !de=
fined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (SSL_get_peer_s=
ignature_nid(ssl, &amp;peer_sig_nid)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        &amp;&amp; peer_sig_nid !=3D NID_undef)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *signame =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SSL_get0_peer_=
signature_name(ssl, &amp;signame);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (signame)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        peer_sig =3D OBJ_nid2sn(peer_sig_n=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_si=
g =3D signame;</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span> </span><br><span> #if !defined(LIBR=
ESSL_VERSION_NUMBER) \</span><br><span>     || (defined(LIBRESSL_VERSION_NU=
MBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;=3D 0x3090000fL)</span><br><sp=
an>@@ -2480,7 +2477,7 @@</span><br><span>     }</span><br><span> #endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(peer_sig_nid =3D=3D NID_undef &amp;&amp; peer_sig_type_nid =3D=3D NID_unde=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (peer_sig =
=3D=3D peer_sig_unknown &amp;&amp; peer_sig_type_nid =3D=3D NID_undef)</spa=
n><br><span>     {</span><br><span>         return;</span><br><span>     }<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/927?usp=3Demail">change 927</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/927?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bc782ceebcc91a8dc8ada0bb72=
ac042be46cad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 927 </div>
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


--CSoFwfsww5I=--

