From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 17:34:53 +0000
In-Reply-To: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
References: <gerrit.1736858059000.Ifa06a3cb843dbf6a9639164d12aabe572aab162c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7929155b70e063dddef7a5b60068593718850992-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SR0sSLmrZvE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SR0sSLmrZvE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/860/2

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
=20
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
Gerrit-MessageType: newpatchset

--SR0sSLmrZvE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/860?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">ssl_openssl: Clean up unused functions and add missi=
ng &quot;static&quot;<br><br>Just some misc cleanups found while looking at=
 the code.<br><br>Change-Id: Ifa06a3cb843dbf6a9639164d12aabe572aab162c<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert =
Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250114164938.12828-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg30453.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/ssl_mbedt=
ls.c<br>M src/openvpn/ssl_openssl.c<br>3 files changed, 5 insertions(+), 50=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/60/860/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_backend.h b/src/ope=
nvpn/ssl_backend.h</span><br><span>index a6a9695..e25727f 100644</span><br>=
<span>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl=
_backend.h</span><br><span>@@ -529,12 +529,12 @@</span><br><span>  *</span>=
<br><span>  ***************************************/</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Print a one line =
summary of SSL/TLS session handshake.</span><br><span>  */</span><br><span>=
 void print_details(struct key_state_ssl *ks_ssl, const char *prefix);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * S=
how the TLS ciphers that are available for us to use in the</span><br><span=
>  * library depending on the TLS version. This function prints</span><br><=
span>  * a list of ciphers without headers/footers.</span><br><span>@@ -549=
,17 +549,11 @@</span><br><span>                                 const char =
*tls_cert_profile,</span><br><span>                                 bool tl=
s13);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span>  * Show the available elliptic curves in the crypto library</span><br=
><span>  */</span><br><span> void show_available_curves(void);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * The OpenSSL library has a notion=
 of preference in TLS ciphers.  Higher</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * preference =3D=3D more secure. Return the highest prefe=
rence cipher.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void get_highest_preferenc=
e_tls_cipher(char *buf, int size);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> /**</span><br><span>  * return a pointer to =
a static memory area containing the</span><br><span>  * name and version nu=
mber of the SSL library in use</span><br><span>diff --git a/src/openvpn/ssl=
_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 56eef36..92b52=
fe 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+=
++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1585,20 +1585,6 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_highest_preference_tls_cipher(char *buf, int size)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *cipher_name;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int *ciphers =3D mbedtls_ssl_=
list_ciphersuites();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (*ciphers =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_FATAL, &quot;Cannot retrieve list of supported SSL ciphers.&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    cipher_name =3D mbedtls_ssl_get_ciphersuite_name(*ciphers);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(buf, cip=
her_name, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> const c=
har *</span><br><span> get_ssl_library_version(void)</span><br><span> {</sp=
an><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_opens=
sl.c</span><br><span>index 98eba9d..89d0328 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</sp=
an><br><span>@@ -354,7 +354,7 @@</span><br><span>     return true;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span> convert_tls_list_to_openssl(char *openssl_ciphers, siz=
e_t len, const char *ciphers)</span><br><span> {</span><br><span>     /* Pa=
rse supplied cipher list and pass on to OpenSSL */</span><br><span>@@ -461,=
7 +461,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> convert_tls=
13_list_to_openssl(char *openssl_ciphers, size_t len,</span><br><span>     =
                          const char *ciphers)</span><br><span> {</span><br=
><span>@@ -2638,31 +2638,6 @@</span><br><span> #endif /* ifndef OPENSSL_NO_=
EC */</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-get_highest_preference_tls_cipher(char *buf, int size)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SSL_CTX *ctx;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SSL *ssl;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const char *cipher_name;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx =
=3D SSL_CTX_new(SSLv23_method());</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cryp=
to_msg(M_FATAL, &quot;Cannot create SSL_CTX object&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ssl =3D SSL_new(ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!ssl)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        crypto_msg(M_FATAL, &quot;Cannot create SSL object&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    cipher_name =3D SSL_get_cipher_list(ssl, 0);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    strncpynt(buf, cipher_name, size)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SSL_free(ssl);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    SSL_CTX_free(ctx);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> const char *</span><br><span> get_ssl_librar=
y_version(void)</span><br><span> {</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail=
">change 860</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/860?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SR0sSLmrZvE=--

