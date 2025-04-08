From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 8 Apr 2025 11:31:02 +0000
In-Reply-To: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
References: <gerrit.1743496145000.I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <79e74015b4a75f6cee035531eeab549c5c2807aa-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5UBh44fdPXI="; charset=UTF-8
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

--5UBh44fdPXI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by ordex


Change subject: Use SSL_get0_peer_signature_name instead of SSL_get_peer_si=
gnature_nid
......................................................................

Use SSL_get0_peer_signature_name instead of SSL_get_peer_signature_nid

SSL_get0_peer_signature_name returns a string instead of hardcoded NIDs.
NIDS do not work with provider provided signatures or the new PQ
signatures introduced in OpenSSL 3.5.

Remove also the comment that was added earlier that says that there
is no proper API replacement for SSL_get_peer_signature_nid yet as
OpenSSL 3.5.0 has now introduced it.

Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46cad6
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Message-Id: <20250402153337.5262-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
336.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
2 files changed, 34 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/927/5

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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--5UBh44fdPXI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
927?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Use SSL_get0_peer_signature_name instead of SSL_get_=
peer_signature_nid<br><br>SSL_get0_peer_signature_name returns a string ins=
tead of hardcoded NIDs.<br>NIDS do not work with provider provided signatur=
es or the new PQ<br>signatures introduced in OpenSSL 3.5.<br><br>Remove als=
o the comment that was added earlier that says that there<br>is no proper A=
PI replacement for SSL_get_peer_signature_nid yet as<br>OpenSSL 3.5.0 has n=
ow introduced it.<br><br>Change-Id: I2bc782ceebcc91a8dc8ada0bb72ac042be46ca=
d6<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Anto=
nio Quartulli &lt;antonio@...2726...&gt;<br>Message-Id: &lt;20250402153337.=
5262-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg31336.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/openssl_compat.h<br>M src/openvp=
n/ssl_openssl.c<br>2 files changed, 34 insertions(+), 11 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/927/5<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_com=
pat.h</span><br><span>index 3e3b406..e2bd9bf 100644</span><br><span>--- a/s=
rc/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compa=
t.h</span><br><span>@@ -173,4 +173,30 @@</span><br><span> </span><br><span>=
 #endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUM=
BER &lt; 0x30500000 &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRES=
SL_VERSION_NUMBER &gt; 0x3050400fL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+SSL_get0_peer_signature_name(SSL *ssl, const char **sigalg)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int peer_sig_nid;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (SSL_get_peer_signature_nid(ss=
l, &amp;peer_sig_nid)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &amp;&amp; peer_sig_nid !=3D NID_undef)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *sigalg =3D OBJ_nid2sn(peer_sig_nid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#elif defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER=
 &lt;=3D 0x3050400fL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* The older LibreSSL version do not implement any variant of getting the =
peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * signature */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+SSL_get0_peer_signatu=
re_name(const SSL *ssl, const char **sigalg)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    *sigalg =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if OP=
ENSSL_VERSION_NUMBER &lt; 0x30500000 &amp;&amp; (!defined(LIBRESSL_VERSION_=
NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3050400fL) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><br><span>diff --git a=
/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>inde=
x aad79a4..23b0266 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</=
span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2454,20 =
+2454,17 @@</span><br><span> static void</span><br><span> print_peer_signat=
ure(SSL *ssl, char *buf, size_t buflen)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int peer_sig_nid =3D NID_undef, pe=
er_sig_type_nid =3D NID_undef;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *peer_sig =3D &quot;unknown&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int peer_sig_type_nid =3D NID_un=
def;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*peer_sig_unknown =3D &quot;unknown&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *peer_sig =3D peer_sig_unknown;</span=
><br><span>     const char *peer_sig_type =3D &quot;unknown type&quot;;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
Even though these methods use the deprecated NIDs instead of using</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * string as new OpenSSL A=
PIs do, there seem to be no API that replaces</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * it yet */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if !defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSIO=
N_NUMBER &gt; 0x3050400fL</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (SSL_get_peer_signature_nid(ssl, &amp;peer_sig_nid)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; peer_sig_nid !=
=3D NID_undef)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *signame =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SSL_get0_peer_signature_name(ssl, &amp;signame);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (signame)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        peer_si=
g =3D OBJ_nid2sn(peer_sig_nid);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        peer_sig =3D signame;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><=
br><span> #if !defined(LIBRESSL_VERSION_NUMBER) \</span><br><span>     || (=
defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &gt;=3D=
 0x3090000fL)</span><br><span>@@ -2480,7 +2477,7 @@</span><br><span>     }<=
/span><br><span> #endif</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (peer_sig_nid =3D=3D NID_undef &amp;&amp; peer_s=
ig_type_nid =3D=3D NID_undef)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (peer_sig =3D=3D peer_sig_unknown &amp;&amp; peer_sig_type=
_nid =3D=3D NID_undef)</span><br><span>     {</span><br><span>         retu=
rn;</span><br><span>     }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail">change=
 927</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/927?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2bc782ceebcc91a8dc8ada0bb72=
ac042be46cad6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 927 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5UBh44fdPXI=--

