From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 17:34:56 +0000
In-Reply-To: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
References: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7929155b70e063dddef7a5b60068593718850992-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LXgxrQkXNWQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LXgxrQkXNWQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
0?usp=3Demail )

Change subject: ssl_openssl: Clean up unused functions and add missing "sta=
tic"
......................................................................

ssl_openssl: Clean up unused functions and add missing "static"

Just some misc cleanups found while looking at the code.

Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250114164938.12828-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
453.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
3 files changed, 5 insertions(+), 50 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--LXgxrQkXNWQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/860?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">ssl_openssl: Clean up unused functions and add=
 missing &quot;static&quot;<br><br>Just some misc cleanups found while look=
ing at the code.<br><br>Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162=
c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250114164938.128=
28-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg30453.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/ssl=
_mbedtls.c<br>M src/openvpn/ssl_openssl.c<br>3 files changed, 5 insertions(=
+), 50 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h</span=
><br><span>index a6a9695..e25727f 100644</span><br><span>--- a/src/openvpn/=
ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl_backend.h</span><br><sp=
an>@@ -529,12 +529,12 @@</span><br><span>  *</span><br><span>  ************=
***************************/</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span>  * Print a one line summary of SSL/TLS session=
 handshake.</span><br><span>  */</span><br><span> void print_details(struct=
 key_state_ssl *ks_ssl, const char *prefix);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span>  * Show the TLS ciphers that a=
re available for us to use in the</span><br><span>  * library depending on =
the TLS version. This function prints</span><br><span>  * a list of ciphers=
 without headers/footers.</span><br><span>@@ -549,17 +549,11 @@</span><br><=
span>                                 const char *tls_cert_profile,</span><=
br><span>                                 bool tls13);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Show the availabl=
e elliptic curves in the crypto library</span><br><span>  */</span><br><spa=
n> void show_available_curves(void);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * The OpenSSL library has a notion of preference in TLS ciph=
ers.  Higher</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * prefer=
ence =3D=3D more secure. Return the highest preference cipher.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void get_highest_preference_tls_cipher(char *buf, in=
t size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  * return a pointer to a static memory area conta=
ining the</span><br><span>  * name and version number of the SSL library in=
 use</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/s=
sl_mbedtls.c</span><br><span>index 56eef36..92b52fe 100644</span><br><span>=
--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedt=
ls.c</span><br><span>@@ -1585,20 +1585,6 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_highes=
t_preference_tls_cipher(char *buf, int size)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const char *cipher_name;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const int *ciphers =3D mbedtls_ssl_list_ciphersuites();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (*ciphers =3D=3D 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Cannot retr=
ieve list of supported SSL ciphers.&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher_name=
 =3D mbedtls_ssl_get_ciphersuite_name(*ciphers);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    strncpynt(buf, cipher_name, size);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> const char *</span><br><span> get=
_ssl_library_version(void)</span><br><span> {</span><br><span>diff --git a/=
src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index=
 98eba9d..89d0328 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</s=
pan><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -354,7 +35=
4,7 @@</span><br><span>     return true;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> conve=
rt_tls_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphe=
rs)</span><br><span> {</span><br><span>     /* Parse supplied cipher list a=
nd pass on to OpenSSL */</span><br><span>@@ -461,7 +461,7 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span> convert_tls13_list_to_openssl(char *o=
penssl_ciphers, size_t len,</span><br><span>                               =
const char *ciphers)</span><br><span> {</span><br><span>@@ -2638,31 +2638,6=
 @@</span><br><span> #endif /* ifndef OPENSSL_NO_EC */</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_highest_preference=
_tls_cipher(char *buf, int size)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL_C=
TX *ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SSL *ssl;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *ciphe=
r_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ctx =3D SSL_CTX_new(SSLv23_meth=
od());</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ctx)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;Canno=
t create SSL_CTX object&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ss=
l =3D SSL_new(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!ssl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL=
, &quot;Cannot create SSL object&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher_name =
=3D SSL_get_cipher_list(ssl, 0);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    strncpynt(buf, cipher_name, size);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    SSL_free(ssl);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    SSL_CTX_free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> const char *</span><br><span> get_ssl_library_version(void)</span><br><s=
pan> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail">change 860</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/860?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa06a3cb843dbf6a9639164d12a=
abe572aab162c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--LXgxrQkXNWQ=--

