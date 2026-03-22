From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Mar 2026 12:03:17 +0000
In-Reply-To: <gerrit.1773754326000.I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7@...2715...>
References: <gerrit.1773754326000.I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <011b4b199b043615c6ec6301a90f0479f1eb81f7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eOfHtxpX/CI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use openssl_err_t
 typedef to deal with difference between TLS libraries
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

--eOfHtxpX/CI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Use openssl_err_t typedef to deal with difference between T=
LS libraries
......................................................................

Use openssl_err_t typedef to deal with difference between TLS libraries

AWS-LC and OpenSSL disagree on the type of that errors are reported in.

Instead of having a lot of glue code and casting back and forth, use a
typedef to always use the right type.

Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1578
Message-Id: <20260322111131.8251-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
242.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
2 files changed, 12 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1578/2

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 19cb9a9..9900d06 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -229,7 +229,7 @@
 void
 crypto_print_openssl_errors(const unsigned int flags)
 {
-    unsigned long err =3D 0;
+    openssl_err_t err =3D 0;
     int line, errflags;
     const char *file, *data, *func;

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ab011d3..8fdb39a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -45,6 +45,15 @@
 #include <openssl/x509.h>
 #include <openssl/err.h>

+/* Define the type of error. This is something that is less
+ * intrusive than casts everywhere */
+#if defined(OPENSSL_IS_AWSLC)
+typedef uint32_t openssl_err_t;
+#else
+typedef unsigned long openssl_err_t;
+#endif
+
+
 /* Functionality missing in 1.1.0 */
 #if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 #define SSL_CTX_set1_groups SSL_CTX_set1_curves
@@ -157,12 +166,12 @@
     /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
 }

-static inline unsigned long
+static inline openssl_err_t
 ERR_get_error_all(const char **file, int *line, const char **func, const c=
har **data, int *flags)
 {
     static const char *empty =3D "";
     *func =3D empty;
-    unsigned long err =3D ERR_get_error_line_data(file, line, data, flags);
+    openssl_err_t err =3D ERR_get_error_line_data(file, line, data, flags);
     return err;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7
Gerrit-Change-Number: 1578
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eOfHtxpX/CI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Use openssl_err_t typedef to=
 deal with difference between TLS libraries<br><br>AWS-LC and OpenSSL disag=
ree on the type of that errors are reported in.<br><br>Instead of having a =
lot of glue code and casting back and forth, use a<br>typedef to always use=
 the right type.<br><br>Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe=
7<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1578<br>Message-Id: &lt;20260322111131.8251-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg36242.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/openssl_compat.h<=
br>2 files changed, 12 insertions(+), 3 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1578/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_ope=
nssl.c</span><br><span>index 19cb9a9..9900d06 100644</span><br><span>--- a/=
src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_opens=
sl.c</span><br><span>@@ -229,7 +229,7 @@</span><br><span> void</span><br><s=
pan> crypto_print_openssl_errors(const unsigned int flags)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned long e=
rr =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openss=
l_err_t err =3D 0;</span><br><span>     int line, errflags;</span><br><span=
>     const char *file, *data, *func;</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span=
><br><span>index ab011d3..8fdb39a 100644</span><br><span>--- a/src/openvpn/=
openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</span><=
br><span>@@ -45,6 +45,15 @@</span><br><span> #include &lt;openssl/x509.h&gt=
;</span><br><span> #include &lt;openssl/err.h&gt;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define the type of error=
. This is something that is less</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * intrusive than casts everywhere */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t openssl_err_t;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef unsigned long openssl_err_t;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /* Functionality missing in 1.1.0=
 */</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x10101000L &amp;&amp;=
 !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> #define SSL_CTX_set1_grou=
ps SSL_CTX_set1_curves</span><br><span>@@ -157,12 +166,12 @@</span><br><spa=
n>     /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static inline unsigned long</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static inline openssl_err_t</span><br><span> ERR_ge=
t_error_all(const char **file, int *line, const char **func, const char **d=
ata, int *flags)</span><br><span> {</span><br><span>     static const char =
*empty =3D &quot;&quot;;</span><br><span>     *func =3D empty;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    unsigned long err =3D ERR_get_=
error_line_data(file, line, data, flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    openssl_err_t err =3D ERR_get_error_line_data(fil=
e, line, data, flags);</span><br><span>     return err;</span><br><span> }<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail">change 1578</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4adbdf0c8b82fd7de309aa5f6f3=
b0c8157c5ffe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1578 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--eOfHtxpX/CI=--

