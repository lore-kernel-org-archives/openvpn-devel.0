From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sun, 1 Oct 2023 19:06:43 +0000
In-Reply-To: <gerrit.1696183368000.Ic7ec25ac0503a91d5869b8da966d0065f264af22@...2715...>
References: <gerrit.1696183368000.Ic7ec25ac0503a91d5869b8da966d0065f264af22@...2715...>
Reply-To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7e9aa940e06c40ecf0ef4cac23904686d1f59df8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PHmN5OEK58Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Log OpenSSL errors
 on failure to set certificate
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

--PHmN5OEK58Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/363?usp=3Demail

to look at the new patch set (#2).


Change subject: Log OpenSSL errors on failure to set certificate
......................................................................

Log OpenSSL errors on failure to set certificate

Currently we log a bogus error message saying private key password verifica=
tion
failed when SSL_CTX_use_cert_and_key() fails in pkcs11_openssl.c. Instead p=
rint
OpenSSL error queue and exit promptly.

Also log OpenSSL errors when SSL_CTX_use_certiifcate() fails in cryptoapi.c
and elsewhere. Such logging could be useful especially when the ceritficate=
 is
rejected by OpenSSL due to stricter security restrictions in recent versions
of the library.

Change-Id: Ic7ec25ac0503a91d5869b8da966d0065f264af22
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/cryptoapi.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/ssl_openssl.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkcs11.c
5 files changed, 32 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/363/2

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 3b92e48..f7e5b67 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -51,6 +51,7 @@
 #include "openssl_compat.h"
 #include "win32.h"
 #include "xkey_common.h"
+#include "crypto_openssl.h"

 #ifndef HAVE_XKEY_PROVIDER

@@ -505,6 +506,7 @@
     if (SSL_CTX_use_certificate(ssl_ctx, cert)
         && SSL_CTX_use_PrivateKey(ssl_ctx, privkey))
     {
+        crypto_print_openssl_errors(M_WARN);
         ret =3D 1;
     }

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 40080ef..aa0819f 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -302,7 +302,8 @@

     if (!SSL_CTX_use_cert_and_key(ctx->ctx, x509, pkey, NULL, 0))
     {
-        msg(M_WARN, "PKCS#11: Failed to set cert and private key for OpenS=
SL");
+        crypto_print_openssl_errors(M_WARN);
+        msg(M_FATAL, "PKCS#11: Failed to set cert and private key for Open=
SSL");
         goto cleanup;
     }
     ret =3D 1;
@@ -369,7 +370,8 @@

     if (!SSL_CTX_use_certificate(ssl_ctx->ctx, x509))
     {
-        msg(M_WARN, "PKCS#11: Cannot set certificate for openssl");
+        crypto_print_openssl_errors(M_WARN);
+        msg(M_FATAL, "PKCS#11: Cannot set certificate for openssl");
         goto cleanup;
     }
     ret =3D 0;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0b310de..b5cc9a7 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -857,6 +857,7 @@
     /* Load Certificate */
     if (!SSL_CTX_use_certificate(ctx->ctx, cert))
     {
+        crypto_print_openssl_errors(M_WARN);
         crypto_msg(M_FATAL, "Cannot use certificate");
     }

@@ -1007,6 +1008,7 @@
 end:
     if (!ret)
     {
+        crypto_print_openssl_errors(M_WARN);
         if (cert_file_inline)
         {
             crypto_msg(M_FATAL, "Cannot load inline certificate file");
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 008f41c..d90bfc3 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -58,6 +58,17 @@
     return NULL;
 }

+/* replacement for crypto_print_openssl_errors() */
+void
+crypto_print_openssl_errors(const unsigned int flags)
+{
+    unsigned long e;
+    while ((e =3D ERR_get_error()))
+    {
+        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL)=
);
+    }
+}
+
 /* tls_libctx is defined in ssl_openssl.c which we do not want to compile =
in */
 OSSL_LIB_CTX *tls_libctx;

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 235cc43..870ab93 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -44,6 +44,19 @@

 struct management *management; /* global */

+/* replacement for crypto_print_openssl_errors() */
+#if defined (ENABLE_CRYPTO_OPENSSL)
+void
+crypto_print_openssl_errors(const unsigned int flags)
+{
+    unsigned long e;
+    while ((e =3D ERR_get_error()))
+    {
+        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL)=
);
+    }
+}
+#endif
+
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/363?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7ec25ac0503a91d5869b8da966d0065f264af22
Gerrit-Change-Number: 363
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--PHmN5OEK58Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/363?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Log OpenSSL errors on failure to set certificate<br><br>Currently we =
log a bogus error message saying private key password verification<br>faile=
d when SSL_CTX_use_cert_and_key() fails in pkcs11_openssl.c. Instead print<=
br>OpenSSL error queue and exit promptly.<br><br>Also log OpenSSL errors wh=
en SSL_CTX_use_certiifcate() fails in cryptoapi.c<br>and elsewhere. Such lo=
gging could be useful especially when the ceritficate is<br>rejected by Ope=
nSSL due to stricter security restrictions in recent versions<br>of the lib=
rary.<br><br>Change-Id: Ic7ec25ac0503a91d5869b8da966d0065f264af22<br>Signed=
-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpn/cr=
yptoapi.c<br>M src/openvpn/pkcs11_openssl.c<br>M src/openvpn/ssl_openssl.c<=
br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests/unit_tests/openvp=
n/test_pkcs11.c<br>5 files changed, 32 insertions(+), 2 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/363/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</span=
><br><span>index 3b92e48..f7e5b67 100644</span><br><span>--- a/src/openvpn/=
cryptoapi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</span><br><span>@=
@ -51,6 +51,7 @@</span><br><span> #include &quot;openssl_compat.h&quot;</sp=
an><br><span> #include &quot;win32.h&quot;</span><br><span> #include &quot;=
xkey_common.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;crypto_openssl.h&quot;</span><br><span> </span><br><span> #i=
fndef HAVE_XKEY_PROVIDER</span><br><span> </span><br><span>@@ -505,6 +506,7=
 @@</span><br><span>     if (SSL_CTX_use_certificate(ssl_ctx, cert)</span><=
br><span>         &amp;&amp; SSL_CTX_use_PrivateKey(ssl_ctx, privkey))</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       crypto_print_openssl_errors(M_WARN);</span><br><span>         ret =
=3D 1;</span><br><span>     }</span><br><span> </span><br><span>diff --git =
a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br><sp=
an>index 40080ef..aa0819f 100644</span><br><span>--- a/src/openvpn/pkcs11_o=
penssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><span=
>@@ -302,7 +302,8 @@</span><br><span> </span><br><span>     if (!SSL_CTX_us=
e_cert_and_key(ctx-&gt;ctx, x509, pkey, NULL, 0))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quo=
t;PKCS#11: Failed to set cert and private key for OpenSSL&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_print_openssl_=
errors(M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_FATAL, &quot;PKCS#11: Failed to set cert and private key for Open=
SSL&quot;);</span><br><span>         goto cleanup;</span><br><span>     }</=
span><br><span>     ret =3D 1;</span><br><span>@@ -369,7 +370,8 @@</span><b=
r><span> </span><br><span>     if (!SSL_CTX_use_certificate(ssl_ctx-&gt;ctx=
, x509))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;PKCS#11: Cannot set certificate for ope=
nssl&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 crypto_print_openssl_errors(M_WARN);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg(M_FATAL, &quot;PKCS#11: Cannot set certificat=
e for openssl&quot;);</span><br><span>         goto cleanup;</span><br><spa=
n>     }</span><br><span>     ret =3D 0;</span><br><span>diff --git a/src/o=
penvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 0b31=
0de..b5cc9a7 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><=
br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -857,6 +857,7 @=
@</span><br><span>     /* Load Certificate */</span><br><span>     if (!SSL=
_CTX_use_certificate(ctx-&gt;ctx, cert))</span><br><span>     {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        crypto_print_openssl_er=
rors(M_WARN);</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot use=
 certificate&quot;);</span><br><span>     }</span><br><span> </span><br><sp=
an>@@ -1007,6 +1008,7 @@</span><br><span> end:</span><br><span>     if (!re=
t)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        crypto_print_openssl_errors(M_WARN);</span><br><span>        =
 if (cert_file_inline)</span><br><span>         {</span><br><span>         =
    crypto_msg(M_FATAL, &quot;Cannot load inline certificate file&quot;);</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tes=
ts/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index 008f41c..d90bf=
c3 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><s=
pan>@@ -58,6 +58,17 @@</span><br><span>     return NULL;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* replacement for crypto_print_openssl_errors() */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+crypto_print_openssl_errors(const unsigned int flags)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned long e;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while ((e =3D ERR_get_error()))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(flags, &quot;OpenSSL error=
 %lu: %s\n&quot;, e, ERR_error_string(e, NULL));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> /* tls_libctx is defined in ssl_openssl.c which we do not wa=
nt to compile in */</span><br><span> OSSL_LIB_CTX *tls_libctx;</span><br><s=
pan> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b=
/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>index 235cc43..870a=
b93 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@=
@ -44,6 +44,19 @@</span><br><span> </span><br><span> struct management *man=
agement; /* global */</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* replacement for crypto_print_openssl_errors() */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined (ENABLE_CRY=
PTO_OPENSSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_print_openssl_e=
rrors(const unsigned int flags)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed long e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile ((e =3D ERR_get_error()))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(flags, &quot;OpenSSL error %lu: %s\n&quot;, e, ERR_error_string(e,=
 NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* stubs for some unused functions i=
nstead of pulling in too many dependencies */</span><br><span> int</span><b=
r><span> parse_line(const char *line, char **p, const int n, const char *fi=
le,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/363?usp=3Demail">change 363</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/363?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic7ec25ac0503a91d5869b8da966=
d0065f264af22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 363 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PHmN5OEK58Q=--

