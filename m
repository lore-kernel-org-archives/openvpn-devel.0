From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 12:34:22 +0000
References: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4ebb2404ad86ec3d03d8fb9960aca0f016ce8cb1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QBfGAfCyGuo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Clean
 up unused functions and add missing "static"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QBfGAfCyGuo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail

to review the following change.


Change subject: ssl_openssl: Clean up unused functions and add missing "sta=
tic"
......................................................................

ssl_openssl: Clean up unused functions and add missing "static"

Just some misc cleanups found while looking at the code.

Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
3 files changed, 5 insertions(+), 50 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/860/1

diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index a6a9695..e25727f 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -529,12 +529,12 @@
  *
  ***************************************/

-/*
+/**
  * Print a one line summary of SSL/TLS session handshake.
  */
 void print_details(struct key_state_ssl *ks_ssl, const char *prefix);

-/*
+/**
  * Show the TLS ciphers that are available for us to use in the
  * library depending on the TLS version. This function prints
  * a list of ciphers without headers/footers.
@@ -549,17 +549,11 @@
                                 const char *tls_cert_profile,
                                 bool tls13);

-/*
+/**
  * Show the available elliptic curves in the crypto library
  */
 void show_available_curves(void);

-/*
- * The OpenSSL library has a notion of preference in TLS ciphers.  Higher
- * preference =3D=3D more secure. Return the highest preference cipher.
- */
-void get_highest_preference_tls_cipher(char *buf, int size);
-
 /**
  * return a pointer to a static memory area containing the
  * name and version number of the SSL library in use
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 56eef36..92b52fe 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1585,20 +1585,6 @@
     }
 }

-void
-get_highest_preference_tls_cipher(char *buf, int size)
-{
-    const char *cipher_name;
-    const int *ciphers =3D mbedtls_ssl_list_ciphersuites();
-    if (*ciphers =3D=3D 0)
-    {
-        msg(M_FATAL, "Cannot retrieve list of supported SSL ciphers.");
-    }
-
-    cipher_name =3D mbedtls_ssl_get_ciphersuite_name(*ciphers);
-    strncpynt(buf, cipher_name, size);
-}
-
 const char *
 get_ssl_library_version(void)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 98eba9d..89d0328 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -354,7 +354,7 @@
     return true;
 }
=20
-void
+static void
 convert_tls_list_to_openssl(char *openssl_ciphers, size_t len, const char =
*ciphers)
 {
     /* Parse supplied cipher list and pass on to OpenSSL */
@@ -461,7 +461,7 @@
     }
 }

-void
+static void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len,
                               const char *ciphers)
 {
@@ -2638,31 +2638,6 @@
 #endif /* ifndef OPENSSL_NO_EC */
 }

-void
-get_highest_preference_tls_cipher(char *buf, int size)
-{
-    SSL_CTX *ctx;
-    SSL *ssl;
-    const char *cipher_name;
-
-    ctx =3D SSL_CTX_new(SSLv23_method());
-    if (!ctx)
-    {
-        crypto_msg(M_FATAL, "Cannot create SSL_CTX object");
-    }
-    ssl =3D SSL_new(ctx);
-    if (!ssl)
-    {
-        crypto_msg(M_FATAL, "Cannot create SSL object");
-    }
-
-    cipher_name =3D SSL_get_cipher_list(ssl, 0);
-    strncpynt(buf, cipher_name, size);
-
-    SSL_free(ssl);
-    SSL_CTX_free(ctx);
-}
-
 const char *
 get_ssl_library_version(void)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c
Gerrit-Change-Number: 860
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--QBfGAfCyGuo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">ssl_openssl: Clean up unused functions and add missing &quot;=
static&quot;<br><br>Just some misc cleanups found while looking at the code=
.<br><br>Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl=
_backend.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_openssl.c<br=
>3 files changed, 5 insertions(+), 50 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/60/860/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h</span><br><span>in=
dex a6a9695..e25727f 100644</span><br><span>--- a/src/openvpn/ssl_backend.h=
</span><br><span>+++ b/src/openvpn/ssl_backend.h</span><br><span>@@ -529,12=
 +529,12 @@</span><br><span>  *</span><br><span>  *************************=
**************/</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span>  * Print a one line summary of SSL/TLS session handshake.</=
span><br><span>  */</span><br><span> void print_details(struct key_state_ss=
l *ks_ssl, const char *prefix);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span>  * Show the TLS ciphers that are available =
for us to use in the</span><br><span>  * library depending on the TLS versi=
on. This function prints</span><br><span>  * a list of ciphers without head=
ers/footers.</span><br><span>@@ -549,17 +549,11 @@</span><br><span>        =
                         const char *tls_cert_profile,</span><br><span>    =
                             bool tls13);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span>  * Show the available elliptic cu=
rves in the crypto library</span><br><span>  */</span><br><span> void show_=
available_curves(void);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * The OpenSSL library has a notion of preference in TLS ciphers.  Higher<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * preference =3D=3D m=
ore secure. Return the highest preference cipher.</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void get_highest_preference_tls_cipher(char *buf, int size);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</spa=
n><br><span>  * return a pointer to a static memory area containing the</sp=
an><br><span>  * name and version number of the SSL library in use</span><b=
r><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c<=
/span><br><span>index 56eef36..92b52fe 100644</span><br><span>--- a/src/ope=
nvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><b=
r><span>@@ -1585,20 +1585,6 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_highest_preference_=
tls_cipher(char *buf, int size)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
char *cipher_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const int *ciphers =3D mbedtls_ssl_list_ciphersuites();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (*ciphers =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Cannot retrieve list of =
supported SSL ciphers.&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher_name =3D mbedtls_=
ssl_get_ciphersuite_name(*ciphers);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    strncpynt(buf, cipher_name, size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> const char *</span><br><span> get_ssl_library=
_version(void)</span><br><span> {</span><br><span>diff --git a/src/openvpn/=
ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 98eba9d..89=
d0328 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><spa=
n>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -354,7 +354,7 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span> convert_tls_list_=
to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)</span><b=
r><span> {</span><br><span>     /* Parse supplied cipher list and pass on t=
o OpenSSL */</span><br><span>@@ -461,7 +461,7 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> convert_tls13_list_to_openssl(char *openssl_ciphe=
rs, size_t len,</span><br><span>                               const char *=
ciphers)</span><br><span> {</span><br><span>@@ -2638,31 +2638,6 @@</span><b=
r><span> #endif /* ifndef OPENSSL_NO_EC */</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-get_highest_preference_tls_cipher(=
char *buf, int size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_CTX *ctx;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL *ssl;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const char *cipher_name;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ctx =3D SSL_CTX_new(SSLv23_method());</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ctx)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;Cannot create SSL=
_CTX object&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ssl =3D SSL_ne=
w(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ssl)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;Cann=
ot create SSL object&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    cipher_name =3D SSL_get_ci=
pher_list(ssl, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 strncpynt(buf, cipher_name, size);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL=
_free(ssl);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_CT=
X_free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const char =
*</span><br><span> get_ssl_library_version(void)</span><br><span> {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/860?usp=3Demail">change 860</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa06a3cb843dbf6a9639164d12a=
abe572aab162c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--QBfGAfCyGuo=--

