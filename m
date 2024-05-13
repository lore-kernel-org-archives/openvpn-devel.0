From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 May 2024 15:24:15 +0000
In-Reply-To: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
References: <gerrit.1715191782000.Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <820b5ea9f9005e6e5d226a5397591081899638a8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mPjerIJvF1c="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mPjerIJvF1c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/58=
6?usp=3Demail )

Change subject: Workaround issue in LibreSSL crashing when enumerating dige=
sts/ciphers
......................................................................

Workaround issue in LibreSSL crashing when enumerating digests/ciphers

OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname/EVP_get_digestbyname
and broke calling EVP_get_cipherbynid/EVP_get_digestbyname with an
invalid nid in the process so that it would segfault.

Workaround but doing that NULL check in OpenVPN instead of leaving it
to the library.

Github: see also https://github.com/libressl/openbsd/issues/150

Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa23cb3934
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240508220540.12554-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
649.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 25 insertions(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--mPjerIJvF1c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/586?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Workaround issue in LibreSSL crashing when enu=
merating digests/ciphers<br><br>OpenBSD/LibreSSL reimplemented EVP_get_ciph=
erbyname/EVP_get_digestbyname<br>and broke calling EVP_get_cipherbynid/EVP_=
get_digestbyname with an<br>invalid nid in the process so that it would seg=
fault.<br><br>Workaround but doing that NULL check in OpenVPN instead of le=
aving it<br>to the library.<br><br>Github: see also https://github.com/libr=
essl/openbsd/issues/150<br><br>Change-Id: Ia08a9697d0ff41721fb0acf17ccb4cfa=
23cb3934<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240508220540.12=
554-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg28649.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>1 file change=
d, 25 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c=
</span><br><span>index 61c6518..1649ab7 100644</span><br><span>--- a/src/op=
envpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</=
span><br><span>@@ -387,7 +387,19 @@</span><br><span> #else</span><br><span>=
     for (int nid =3D 0; nid &lt; 10000; ++nid)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(LIBRESSL_VER=
SION_NUMBER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* OpenBSD/LibreSSL reimplemented EVP_get_cipherbyname and broke</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * calling EVP_get_ci=
pherbynid with an invalid nid in the process</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * so that it would segfault. */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const EVP_CIPHER *cip=
her =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const char *name =3D OBJ_nid2sn(nid);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (name)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            cipher =3D EVP_get_cipherbyname(name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#else  /* if defined(LIBRESSL_VERSION_NUMBER) =
*/</span><br><span>         const EVP_CIPHER *cipher =3D EVP_get_cipherbyni=
d(nid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span>         /* We cast the const away so we can keep the function p=
rototype</span><br><span>          * compatible with EVP_CIPHER_do_all_prov=
ided */</span><br><span>         collect_ciphers((EVP_CIPHER *) cipher, &am=
p;cipher_list);</span><br><span>@@ -441,7 +453,19 @@</span><br><span> #else=
</span><br><span>     for (int nid =3D 0; nid &lt; 10000; ++nid)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* OpenBSD/LibreSSL reimplemented EVP_get_digestbyname and broke</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * calling EVP_get_di=
gestbynid with an invalid nid in the process</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * so that it would segfault. */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef LIBRESSL_VERSION_NUMBE=
R</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const EVP_=
MD *digest =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char *name =3D OBJ_nid2sn(nid);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (name)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            digest =3D EVP_get_digestbyname(name);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#else  /* ifdef LIBRESSL_VERSION_NUMBER=
 */</span><br><span>         const EVP_MD *digest =3D EVP_get_digestbynid(n=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span>         if (digest)</span><br><span>         {</span><br><span>   =
          /* We cast the const away so we can keep the function prototype</=
span><br><span>@@ -449,7 +473,7 @@</span><br><span>             print_diges=
t((EVP_MD *)digest, NULL);</span><br><span>         }</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* if OPENSSL_VERSION_NUMB=
ER &gt;=3D 0x30000000L */</span><br><span>     printf(&quot;\n&quot;);</spa=
n><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail">=
change 586</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/586?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia08a9697d0ff41721fb0acf17cc=
b4cfa23cb3934 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 586 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--mPjerIJvF1c=--

