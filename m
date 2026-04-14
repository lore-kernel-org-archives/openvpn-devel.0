From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 14 Apr 2026 12:11:51 +0000
References: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <575692006c6ac31549bdf8414c3bc8439c745940-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J2r5rxavWcM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Use
 openssl_stack_size_t for declaring stack size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J2r5rxavWcM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1627?usp=3Demail )


Change subject: AWS-LC: Use openssl_stack_size_t for declaring stack size
......................................................................

AWS-LC: Use openssl_stack_size_t for declaring stack size

OpenSSL and AWS-LC disagree on the type that they use for
stack size. Instead of doing a lot of various casts, use
a typedef to avoid these casts and use the right type for
each library.

Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_openssl.c
3 files changed, 17 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1627/1

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8fdb39a..757e45d 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -49,8 +49,12 @@
  * intrusive than casts everywhere */
 #if defined(OPENSSL_IS_AWSLC)
 typedef uint32_t openssl_err_t;
+typedef size_t openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "zu"
 #else
 typedef unsigned long openssl_err_t;
+typedef int openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "d"
 #endif


diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index fd05f43..aaf57a8 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -907,7 +907,6 @@
     X509 *cert;
     STACK_OF(X509) *ca =3D NULL;
     PKCS12 *p12;
-    int i;
     char password[256];

     ASSERT(NULL !=3D ctx);
@@ -991,7 +990,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(ca); i++)
             {
                 X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx->ctx=
);
                 if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca, i)))
@@ -1016,7 +1015,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(ca); i++)
             {
                 if (!SSL_CTX_add_extra_chain_cert(ctx->ctx, sk_X509_value(=
ca, i)))
                 {
@@ -1790,7 +1789,7 @@
     X509_LOOKUP *lookup =3D NULL;
     X509_STORE *store =3D NULL;
     BIO *in =3D NULL;
-    int i, added =3D 0, prev =3D 0;
+    openssl_stack_size_t added =3D 0, prev =3D 0;

     ASSERT(NULL !=3D ctx);

@@ -1819,7 +1818,7 @@

         if (info_stack)
         {
-            for (i =3D 0; i < sk_X509_INFO_num(info_stack); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_INFO_num(info_s=
tack); i++)
             {
                 X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);
                 if (info->crl)
@@ -1877,11 +1876,11 @@

                 if (tls_server)
                 {
-                    int cnum =3D sk_X509_NAME_num(cert_names);
+                    openssl_stack_size_t cnum =3D sk_X509_NAME_num(cert_na=
mes);
                     if (cnum !=3D (prev + 1))
                     {
                         crypto_msg(M_WARN,
-                                   "Cannot load CA certificate file %s (en=
try %d did not validate)",
+                                   "Cannot load CA certificate file %s (en=
try %" PRI_OPENSSL_STACK " did not validate)",
                                    print_key_filename(ca_file, ca_file_inl=
ine), added);
                     }
                     prev =3D cnum;
@@ -1889,7 +1888,7 @@
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
-        int cnum;
+        openssl_stack_size_t cnum;
         if (tls_server)
         {
             cnum =3D sk_X509_NAME_num(cert_names);
@@ -1907,8 +1906,8 @@
             if (cnum !=3D added)
             {
                 crypto_msg(M_FATAL,
-                           "Cannot load CA certificate file %s (only %d "
-                           "of %d entries were valid X509 names)",
+                           "Cannot load CA certificate file %s (only %" PR=
I_OPENSSL_STACK
+                           "of %" PRI_OPENSSL_STACK "entries were valid X5=
09 names)",
                            print_key_filename(ca_file, ca_file_inline), cn=
um, added);
             }
         }
@@ -2557,7 +2556,7 @@
 #else
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int i =3D 0; i < sk_SSL_CIPHER_num(sk); i++)
+    for (openssl_stack_size_t i =3D 0; i < sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c =3D sk_SSL_CIPHER_value(sk, i);

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 115b8d2..af19459 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -138,10 +138,10 @@
          * one, but we don't depend on it...
          */

-        int numalts =3D sk_GENERAL_NAME_num(extensions);
+        openssl_stack_size_t numalts =3D sk_GENERAL_NAME_num(extensions);

         /* loop through all alternatives */
-        for (int i =3D 0; i < numalts; i++)
+        for (openssl_stack_size_t i =3D 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extensions,=
 i);
@@ -763,10 +763,8 @@
     }
     else
     {
-        int i;
-
         msg(D_HANDSHAKE, "Validating certificate extended key usage");
-        for (i =3D 0; SUCCESS !=3D fFound && i < sk_ASN1_OBJECT_num(eku); =
i++)
+        for (openssl_stack_size_t i =3D 0; SUCCESS !=3D fFound && i < sk_A=
SN1_OBJECT_num(eku); i++)
         {
             ASN1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku, i);
             char szOid[1024];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1627?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
Gerrit-Change-Number: 1627
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J2r5rxavWcM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1627?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">AWS-LC: Use openssl_stack_size_t for declaring stack size<br><br>OpenSS=
L and AWS-LC disagree on the type that they use for<br>stack size. Instead =
of doing a lot of various casts, use<br>a typedef to avoid these casts and =
use the right type for<br>each library.<br><br>Change-Id: Ifd29485524674c64=
d56fc5f7ef8bdd1e00215fc9<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>---<br>M src/openvpn/openssl_compat.h<br>M src/openvpn/ssl_openssl.=
c<br>M src/openvpn/ssl_verify_openssl.c<br>3 files changed, 17 insertions(+=
), 16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/27/1627/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index 8fdb3=
9a..757e45d 100644</span><br><span>--- a/src/openvpn/openssl_compat.h</span=
><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -49,8 +49,=
12 @@</span><br><span>  * intrusive than casts everywhere */</span><br><spa=
n> #if defined(OPENSSL_IS_AWSLC)</span><br><span> typedef uint32_t openssl_=
err_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef size_=
t openssl_stack_size_t;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PRI_OPENSSL_STACK &quot;zu&quot;</span><br><span> #else</span><=
br><span> typedef unsigned long openssl_err_t;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+typedef int openssl_stack_size_t;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define PRI_OPENSSL_STACK &quot;d&=
quot;</span><br><span> #endif</span><br><span> </span><br><span> </span><br=
><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</=
span><br><span>index fd05f43..aaf57a8 100644</span><br><span>--- a/src/open=
vpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br=
><span>@@ -907,7 +907,6 @@</span><br><span>     X509 *cert;</span><br><span=
>     STACK_OF(X509) *ca =3D NULL;</span><br><span>     PKCS12 *p12;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span> =
    char password[256];</span><br><span> </span><br><span>     ASSERT(NULL =
!=3D ctx);</span><br><span>@@ -991,7 +990,7 @@</span><br><span>          */=
</span><br><span>         if (ca &amp;&amp; sk_X509_num(ca))</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            for (openssl_stack_size_t i =3D 0; i =
&lt; sk_X509_num(ca); i++)</span><br><span>             {</span><br><span> =
                X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx-&gt;c=
tx);</span><br><span>                 if (!X509_STORE_add_cert(cert_store, =
sk_X509_value(ca, i)))</span><br><span>@@ -1016,7 +1015,7 @@</span><br><spa=
n>          */</span><br><span>         if (ca &amp;&amp; sk_X509_num(ca))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            for (openssl_stack_size=
_t i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span>             {</sp=
an><br><span>                 if (!SSL_CTX_add_extra_chain_cert(ctx-&gt;ctx=
, sk_X509_value(ca, i)))</span><br><span>                 {</span><br><span=
>@@ -1790,7 +1789,7 @@</span><br><span>     X509_LOOKUP *lookup =3D NULL;</=
span><br><span>     X509_STORE *store =3D NULL;</span><br><span>     BIO *i=
n =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i,=
 added =3D 0, prev =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    openssl_stack_size_t added =3D 0, prev =3D 0;</span><br><span> </=
span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><spa=
n>@@ -1819,7 +1818,7 @@</span><br><span> </span><br><span>         if (info=
_stack)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            for (i =3D 0; i &lt; sk_X509_INFO_num(info_stack);=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fo=
r (openssl_stack_size_t i =3D 0; i &lt; sk_X509_INFO_num(info_stack); i++)<=
/span><br><span>             {</span><br><span>                 X509_INFO *=
info =3D sk_X509_INFO_value(info_stack, i);</span><br><span>               =
  if (info-&gt;crl)</span><br><span>@@ -1877,11 +1876,11 @@</span><br><span=
> </span><br><span>                 if (tls_server)</span><br><span>       =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          int cnum =3D sk_X509_NAME_num(cert_names);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    openssl_stack_size_t =
cnum =3D sk_X509_NAME_num(cert_names);</span><br><span>                    =
 if (cnum !=3D (prev + 1))</span><br><span>                     {</span><br=
><span>                         crypto_msg(M_WARN,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                   &quot;Canno=
t load CA certificate file %s (entry %d did not validate)&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
     &quot;Cannot load CA certificate file %s (entry %&quot; PRI_OPENSSL_ST=
ACK &quot; did not validate)&quot;,</span><br><span>                       =
             print_key_filename(ca_file, ca_file_inline), added);</span><br=
><span>                     }</span><br><span>                     prev =3D=
 cnum;</span><br><span>@@ -1889,7 +1888,7 @@</span><br><span>             }=
</span><br><span>             sk_X509_INFO_pop_free(info_stack, X509_INFO_f=
ree);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        int cnum;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        openssl_stack_size_t cnum;</span><br><span>         if (tl=
s_server)</span><br><span>         {</span><br><span>             cnum =3D =
sk_X509_NAME_num(cert_names);</span><br><span>@@ -1907,8 +1906,8 @@</span><=
br><span>             if (cnum !=3D added)</span><br><span>             {</=
span><br><span>                 crypto_msg(M_FATAL,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           &quot;Cannot loa=
d CA certificate file %s (only %d &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                           &quot;of %d entries were vali=
d X509 names)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           &quot;Cannot load CA certificate file %s (only =
%&quot; PRI_OPENSSL_STACK</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                           &quot;of %&quot; PRI_OPENSSL_STACK &quot;e=
ntries were valid X509 names)&quot;,</span><br><span>                      =
      print_key_filename(ca_file, ca_file_inline), cnum, added);</span><br>=
<span>             }</span><br><span>         }</span><br><span>@@ -2557,7 =
+2556,7 @@</span><br><span> #else</span><br><span>     STACK_OF(SSL_CIPHER)=
 *sk =3D SSL_get1_supported_ciphers(ssl);</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; sk=
_SSL_CIPHER_num(sk); i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (openssl_stack_size_t i =3D 0; i &lt; sk_SSL_CIPHER_num(sk); =
i++)</span><br><span>     {</span><br><span>         const SSL_CIPHER *c =
=3D sk_SSL_CIPHER_value(sk, i);</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</sp=
an><br><span>index 115b8d2..af19459 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=
.c</span><br><span>@@ -138,10 +138,10 @@</span><br><span>          * one, b=
ut we don&#39;t depend on it...</span><br><span>          */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int numalt=
s =3D sk_GENERAL_NAME_num(extensions);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        openssl_stack_size_t numalts =3D sk_GENERAL_NAME=
_num(extensions);</span><br><span> </span><br><span>         /* loop throug=
h all alternatives */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (int i =3D 0; i &lt; numalts; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (openssl_stack_size_t i =3D 0; i &lt=
; numalts; i++)</span><br><span>         {</span><br><span>             /* =
get a handle to alternative name number i */</span><br><span>             c=
onst GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extensions, i);</span><br=
><span>@@ -763,10 +763,8 @@</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>         msg(D_HANDSHAKE, &quot;Validating certificate extende=
d key usage&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      for (i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt; sk_ASN1_OBJECT_nu=
m(eku); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (openssl_stack_size_t i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt; s=
k_ASN1_OBJECT_num(eku); i++)</span><br><span>         {</span><br><span>   =
          ASN1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku, i);</span><br><spa=
n>             char szOid[1024];</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1627?usp=3Demail"=
>change 1627</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1627?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8=
bdd1e00215fc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1627 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--J2r5rxavWcM=--

