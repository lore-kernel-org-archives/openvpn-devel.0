From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Mar 2026 13:32:11 +0000
References: <gerrit.1773754326000.I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <aa7e590865174a76674e5d5aca8f0f42d864280e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="drc13MVPaeM="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--drc13MVPaeM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1578?usp=3Demail )


Change subject: Use openssl_err_t typedef to deal with difference between T=
LS libraries
......................................................................

Use openssl_err_t typedef to deal with difference between TLS libraries

AWS-LC and OpenSSL disagree on the type of that errors are reported in.

Instead of having a lot of glue code and casting back and forth, use a
typedef to always use the right type.

Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
2 files changed, 12 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1578/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4adbdf0c8b82fd7de309aa5f6f3b0c8157c5ffe7
Gerrit-Change-Number: 1578
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--drc13MVPaeM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1578?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Use openssl_err_t typedef to deal with difference between TLS libraries=
<br><br>AWS-LC and OpenSSL disagree on the type of that errors are reported=
 in.<br><br>Instead of having a lot of glue code and casting back and forth=
, use a<br>typedef to always use the right type.<br><br>Change-Id: I4adbdf0=
c8b82fd7de309aa5f6f3b0c8157c5ffe7<br>Signed-off-by: Arne Schwabe &lt;arne@...220...=
..1227...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/ope=
nssl_compat.h<br>2 files changed, 12 insertions(+), 3 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/78/1578/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/open=
vpn/crypto_openssl.c</span><br><span>index 19cb9a9..9900d06 100644</span><b=
r><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvp=
n/crypto_openssl.c</span><br><span>@@ -229,7 +229,7 @@</span><br><span> voi=
d</span><br><span> crypto_print_openssl_errors(const unsigned int flags)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned long err =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    openssl_err_t err =3D 0;</span><br><span>     int line, errflags;</=
span><br><span>     const char *file, *data, *func;</span><br><span> </span=
><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_=
compat.h</span><br><span>index ab011d3..8fdb39a 100644</span><br><span>--- =
a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_co=
mpat.h</span><br><span>@@ -45,6 +45,15 @@</span><br><span> #include &lt;ope=
nssl/x509.h&gt;</span><br><span> #include &lt;openssl/err.h&gt;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define the=
 type of error. This is something that is less</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * intrusive than casts everywhere */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_AWSLC)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t ope=
nssl_err_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef unsigned long =
openssl_err_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Functionality mi=
ssing in 1.1.0 */</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x101010=
00L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> #define SSL=
_CTX_set1_groups SSL_CTX_set1_curves</span><br><span>@@ -157,12 +166,12 @@<=
/span><br><span>     /* OpenSSL 1.1.1 and lower use only const EVP_MD, noth=
ing to free */</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline unsigned long</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline openssl_err_t</span><=
br><span> ERR_get_error_all(const char **file, int *line, const char **func=
, const char **data, int *flags)</span><br><span> {</span><br><span>     st=
atic const char *empty =3D &quot;&quot;;</span><br><span>     *func =3D emp=
ty;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned long =
err =3D ERR_get_error_line_data(file, line, data, flags);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    openssl_err_t err =3D ERR_get_err=
or_line_data(file, line, data, flags);</span><br><span>     return err;</sp=
an><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail=
">change 1578</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1578?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4adbdf0c8b82fd7de309aa5f6f3=
b0c8157c5ffe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1578 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--drc13MVPaeM=--

