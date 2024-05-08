From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 8 May 2024 18:09:45 +0000
References: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8d0a0a251e08739204f66849157127fec88eb0cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oxCxT5gbuxc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Workaround issue in
 LibreSSL crashing when enumerating digests/ciphers
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

--oxCxT5gbuxc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail

to review the following change.


Change subject: Workaround issue in LibreSSL crashing when enumerating dige=
sts/ciphers
......................................................................

Workaround issue in LibreSSL crashing when enumerating digests/ciphers

OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname/EVP_get_digestbyname
and broke calling EVP_get_cipherbynid/EVP_get_digestbyname with an
invalid nid in the process so that it would segfault.

Workaround but doing that NULL check in OpenVPN instead of leaving it
to the library.

Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 25 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/586/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 61c6518..1649ab7 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -387,7 +387,19 @@
 #else
     for (int nid =3D 0; nid < 10000; ++nid)
     {
+#if defined(LIBRESSL_VERSION_NUMBER)
+        /* OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname and broke
+         * calling EVP_get_cipherbynid with an invalid nid in the process
+         * so that it would segfault. */
+        const EVP_CIPHER *cipher =3D NULL;
+        const char *name =3D OBJ_nid2sn(nid);
+        if (name)
+        {
+            cipher =3D EVP_get_cipherbyname(name);
+        }
+#else  /* if defined(LIBRESSL_VERSION_NUMBER) */
         const EVP_CIPHER *cipher =3D EVP_get_cipherbynid(nid);
+#endif
         /* We cast the const away so we can keep the function prototype
          * compatible with EVP_CIPHER_do_all_provided */
         collect_ciphers((EVP_CIPHER *) cipher, &cipher_list);
@@ -441,7 +453,19 @@
 #else
     for (int nid =3D 0; nid < 10000; ++nid)
     {
+        /* OpenBSD/LibreSSL reimplemented EVP_get_digestbyname and broke
+         * calling EVP_get_digestbynid with an invalid nid in the process
+         * so that it would segfault. */
+#ifdef LIBRESSL_VERSION_NUMBER
+        const EVP_MD *digest =3D NULL;
+        const char *name =3D OBJ_nid2sn(nid);
+        if (name)
+        {
+            digest =3D EVP_get_digestbyname(name);
+        }
+#else  /* ifdef LIBRESSL_VERSION_NUMBER */
         const EVP_MD *digest =3D EVP_get_digestbynid(nid);
+#endif
         if (digest)
         {
             /* We cast the const away so we can keep the function prototype
@@ -449,7 +473,7 @@
             print_digest((EVP_MD *)digest, NULL);
         }
     }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
     printf("\n");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934
Gerrit-Change-Number: 586
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--oxCxT5gbuxc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Workaround issue in LibreSSL crashing when enumerating digest=
s/ciphers<br><br>OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname/EVP_ge=
t_digestbyname<br>and broke calling EVP_get_cipherbynid/EVP_get_digestbynam=
e with an<br>invalid nid in the process so that it would segfault.<br><br>W=
orkaround but doing that NULL check in OpenVPN instead of leaving it<br>to =
the library.<br><br>Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934<br=
>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvp=
n/crypto_openssl.c<br>1 file changed, 25 insertions(+), 1 deletion(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/586/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_open=
ssl.c</span><br><span>index 61c6518..1649ab7 100644</span><br><span>--- a/s=
rc/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openss=
l.c</span><br><span>@@ -387,7 +387,19 @@</span><br><span> #else</span><br><=
span>     for (int nid =3D 0; nid &lt; 10000; ++nid)</span><br><span>     {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESS=
L_VERSION_NUMBER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname and broke</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * calling EVP_g=
et_cipherbynid with an invalid nid in the process</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * so that it would segfault. */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const EVP_CIPHER=
 *cipher =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const char *name =3D OBJ_nid2sn(nid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (name)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            cipher =3D EVP_get_cipherbyname(name);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else  /* if defined(LIBRESSL_VERSION_NUM=
BER) */</span><br><span>         const EVP_CIPHER *cipher =3D EVP_get_ciphe=
rbynid(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span>         /* We cast the const away so we can keep the funct=
ion prototype</span><br><span>          * compatible with EVP_CIPHER_do_all=
_provided */</span><br><span>         collect_ciphers((EVP_CIPHER *) cipher=
, &amp;cipher_list);</span><br><span>@@ -441,7 +453,19 @@</span><br><span> =
#else</span><br><span>     for (int nid =3D 0; nid &lt; 10000; ++nid)</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* OpenBSD/LibreSSL reimplemented EVP_get_digestbyname and broke</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * calling EVP_g=
et_digestbynid with an invalid nid in the process</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * so that it would segfault. */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef LIBRESSL_VERSION_=
NUMBER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 EVP_MD *digest =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const char *name =3D OBJ_nid2sn(nid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (name)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            digest =3D EVP_get_digestbyname(name);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifdef LIBRESSL_VERSI=
ON_NUMBER */</span><br><span>         const EVP_MD *digest =3D EVP_get_dige=
stbynid(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>         if (digest)</span><br><span>         {</span><br>=
<span>             /* We cast the const away so we can keep the function pr=
ototype</span><br><span>@@ -449,7 +473,7 @@</span><br><span>             pr=
int_digest((EVP_MD *)digest, NULL);</span><br><span>         }</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if OPENSSL_VER=
SION_NUMBER &gt;=3D 0x30000000L */</span><br><span>     printf(&quot;\n&quo=
t;);</span><br><span> }</span><br><span> </span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=
=3Demail">change 586</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia08a9697d0ff41721fb0acf17cc=
b4cfa23cb3934 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 586 </div>
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


--oxCxT5gbuxc=--

