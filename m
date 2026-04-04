From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 18:35:49 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7640e3688ac60baffdd1179f0afde0599c8e55e2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2BEq0u9b+gM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Fix
 some CRL mixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davidben <davidben@...410...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2BEq0u9b+gM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: davidben, flichtenheld.

flichtenheld has uploaded a new patch set (#12) to the change originally cr=
eated by davidben. ( http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail=
 )

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: ssl_openssl: Fix some CRL mixups
......................................................................

ssl_openssl: Fix some CRL mixups

There are two ways to load CRLs in OpenSSL. They can be loaded at the
X509_STORE, shared across verifications, or loaded per verification at
the X509_STORE_CTX.

OpenVPN currently does the former. However, it also supports CRL
reloading, and tries to reload the CRL file before each connection.
OpenSSL does not really have a good way to unload objects from an
X509_STORE. OpenVPN currently does it by grabbing the
STACK_OF(X509_OBJECT) out of the X509_STORE and manually deleting all
the CRLs from it.

This mutates an OpenSSL internal object which bumps into problems if
OpenSSL ever switches to a more efficient representation. See
https://github.com/openssl/openssl/pull/28599

(It's also not thread-safe, though it doesn't look like that impacts
OpenVPN? Actually even reading that list doesn't work. See
CVE-2024-0397. This OpenSSL API was simply broken.)

Additionally, this seems to cause two OpenVPN features to not work
together. I gather backend_tls_ctx_reload_crl is trying to clear the
CRLs loaded from last time it ran. But tls_ctx_load_ca with a ca_file
can also load CRLs. tls_ctx_load_ca with ca_path will also pick up CRLs
and backend_tls_ctx_reload_crl actually ends up clobbering some state
X509_LOOKUP_hash_dir internally maintains on the X509_STORE. Likewise,
tls_verify_crl_missing can get confused between
backend_tls_ctx_reload_crl's crl_file-based CRLs and CRLs from
tls_ctx_load_ca.

Avoid all this by tracking the two CRLs separately. crl_file-based CRLs
now go onto a STACK_OF(X509_CRL) tracked on the tls_root_ctx. Now this
field can be freely reloaded by OpenVPN without reconfiguring OpenSSL.
Instead, pass the current value into OpenSSL at verification time.  To
do so, we need to use the SSL_CTX_set_cert_verify_callback, which allows
swapping out the X509_verify_cert call, and also tweaking the
X509_STORE_CTX configuration before starting certificate verification.

Context: SSL_CTX_set_cert_verify_callback and the existing
verify_callback are not the same. SSL_CTX_set_cert_verify_callback wraps
the verification while verify_callback is called multiple times
throughout verification. It's too late to reconfigure X509_STORE_CTX in
verify_callback. verify_callback is usually not what you want.
Sometimes current_cert and error_depth don't quite line up, and
cert_hash_remember may end up called multiple times for a single
certificate.

I suspect some of the other verify_callback logic would also be better
done in the new callback, but I've left it alone to keep this change
minimal. verify_callback is really only usable for suppressing errors.
Application bookkeeping is better down elsewhere.

Add .clang-format section for STACK_OF since we otherwise format the
line as STACK_OF(X509_CRL) * crls

Signed-off-by: David Benjamin <davidben@...410...>
Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .clang-format
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_openssl.h
M src/openvpn/ssl_verify_openssl.c
5 files changed, 38 insertions(+), 55 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1289/12

diff --git a/.clang-format b/.clang-format
index cbec0a4..4774d1e 100644
--- a/.clang-format
+++ b/.clang-format
@@ -43,7 +43,10 @@
 SpacesBeforeTrailingComments: '2'
 SpacesInParens: Never
 TabWidth: '4'
-TypeNames: [DWORD]
+TypeNames:
+  - 'DWORD'
+  - 'STACK_OF'
+TypenameMacros: ['STACK_OF']
 UseTab: Never
 WhitespaceSensitiveMacros: [_STRINGIFY]
 ---
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8fdb39a..3494ce6 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -61,21 +61,6 @@

 /* Functionality missing in LibreSSL before 3.5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x305000=
0fL
-/**
- * Destroy a X509 object
- *
- * @param obj                X509 object
- */
-static inline void
-X509_OBJECT_free(X509_OBJECT *obj)
-{
-    if (obj)
-    {
-        X509_OBJECT_free_contents(obj);
-        OPENSSL_free(obj);
-    }
-}
-
 #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
 #define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e8d7262..04e3521 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -141,6 +141,8 @@
     ASSERT(NULL !=3D ctx);
     SSL_CTX_free(ctx->ctx);
     ctx->ctx =3D NULL;
+    sk_X509_CRL_pop_free(ctx->crls, X509_CRL_free);
+    ctx->crls =3D NULL;
     unload_xkey_provider(); /* in case it is loaded */
 }

@@ -304,6 +306,22 @@
     return true;
 }

+static int
+cert_verify_callback(X509_STORE_CTX *ctx, void *arg)
+{
+    struct tls_session *session;
+    SSL *ssl;
+
+    ssl =3D X509_STORE_CTX_get_ex_data(ctx, SSL_get_ex_data_X509_STORE_CTX=
_idx());
+    ASSERT(ssl);
+    session =3D SSL_get_ex_data(ssl, mydata_index);
+    ASSERT(session);
+
+    /* Configure CRLs. */
+    X509_STORE_CTX_set0_crls(ctx, session->opt->ssl_ctx->crls);
+    return X509_verify_cert(ctx);
+}
+
 bool
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -346,6 +364,7 @@
         verify_flags =3D SSL_VERIFY_PEER;
     }
     SSL_CTX_set_verify(ctx->ctx, verify_flags, verify_callback);
+    SSL_CTX_set_cert_verify_callback(ctx->ctx, cert_verify_callback, NULL);

     SSL_CTX_set_info_callback(ctx->ctx, info_callback);

@@ -1374,6 +1393,7 @@
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_f=
ile, bool crl_inline)
 {
     BIO *in =3D NULL;
+    STACK_OF(X509_CRL) *crls =3D NULL;

     X509_STORE *store =3D SSL_CTX_get_cert_store(ssl_ctx->ctx);
     if (!store)
@@ -1381,20 +1401,8 @@
         crypto_msg(M_FATAL, "Cannot get certificate store");
     }

-    /* Always start with a cleared CRL list, for that we
-     * we need to manually find the CRL object from the stack
-     * and remove it */
-    STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
-    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
-    {
-        X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
-        ASSERT(obj);
-        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)
-        {
-            sk_X509_OBJECT_delete(objs, i);
-            X509_OBJECT_free(obj);
-        }
-    }
+    sk_X509_CRL_pop_free(ssl_ctx->crls, X509_CRL_free);
+    ssl_ctx->crls =3D NULL;

     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CH=
ECK_ALL);

@@ -1410,7 +1418,13 @@
     if (in =3D=3D NULL)
     {
         msg(M_WARN, "CRL: cannot read: %s", print_key_filename(crl_file, c=
rl_inline));
-        goto end;
+        return;
+    }
+
+    crls =3D sk_X509_CRL_new_null();
+    if (crls =3D=3D NULL)
+    {
+        crypto_msg(M_FATAL, "CRL: cannot create CRL list");
     }

     int num_crls_loaded =3D 0;
@@ -1436,18 +1450,14 @@
             break;
         }

-        if (!X509_STORE_add_crl(store, crl))
+        if (!sk_X509_CRL_push(crls, crl))
         {
-            X509_CRL_free(crl);
-            crypto_msg(M_WARN, "CRL: cannot add %s to store",
-                       print_key_filename(crl_file, crl_inline));
-            break;
+            crypto_msg(M_FATAL, "CRL: cannot add CRL to list");
         }
-        X509_CRL_free(crl);
         num_crls_loaded++;
     }
     msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded, crl_f=
ile);
-end:
+    ssl_ctx->crls =3D crls;
     BIO_free(in);
 }

diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 3926e91..373dc10 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -41,6 +41,7 @@
     SSL_CTX *ctx;
     time_t crl_last_mtime;
     off_t crl_last_size;
+    STACK_OF(X509_CRL) *crls;
 };

 struct key_state_ssl
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 96ca1a4..ef8231c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -798,23 +798,7 @@
         return false;
     }

-    X509_STORE *store =3D SSL_CTX_get_cert_store(opt->ssl_ctx->ctx);
-    if (!store)
-    {
-        crypto_msg(M_FATAL, "Cannot get certificate store");
-    }
-
-    STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
-    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
-    {
-        X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
-        ASSERT(obj);
-        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)
-        {
-            return false;
-        }
-    }
-    return true;
+    return opt->ssl_ctx->crls =3D=3D NULL || sk_X509_CRL_num(opt->ssl_ctx-=
>crls) =3D=3D 0;
 }

 #endif /* defined(ENABLE_CRYPTO_OPENSSL) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 12
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: davidben <davidben@...410...>

--2BEq0u9b+gM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: davidben, flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #12</strong> to the change origi=
nally created by davidben.</p><p><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1289?usp=3Demail">View Change</a></p><p>The change is no longer subm=
ittable: checks~ChecksSubmitRule is unsatisfied now.</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl_o=
penssl: Fix some CRL mixups<br><br>There are two ways to load CRLs in OpenS=
SL. They can be loaded at the<br>X509_STORE, shared across verifications, o=
r loaded per verification at<br>the X509_STORE_CTX.<br><br>OpenVPN currentl=
y does the former. However, it also supports CRL<br>reloading, and tries to=
 reload the CRL file before each connection.<br>OpenSSL does not really hav=
e a good way to unload objects from an<br>X509_STORE. OpenVPN currently doe=
s it by grabbing the<br>STACK_OF(X509_OBJECT) out of the X509_STORE and man=
ually deleting all<br>the CRLs from it.<br><br>This mutates an OpenSSL inte=
rnal object which bumps into problems if<br>OpenSSL ever switches to a more=
 efficient representation. See<br>https://github.com/openssl/openssl/pull/2=
8599<br><br>(It&#39;s also not thread-safe, though it doesn&#39;t look like=
 that impacts<br>OpenVPN? Actually even reading that list doesn&#39;t work.=
 See<br>CVE-2024-0397. This OpenSSL API was simply broken.)<br><br>Addition=
ally, this seems to cause two OpenVPN features to not work<br>together. I g=
ather backend_tls_ctx_reload_crl is trying to clear the<br>CRLs loaded from=
 last time it ran. But tls_ctx_load_ca with a ca_file<br>can also load CRLs=
. tls_ctx_load_ca with ca_path will also pick up CRLs<br>and backend_tls_ct=
x_reload_crl actually ends up clobbering some state<br>X509_LOOKUP_hash_dir=
 internally maintains on the X509_STORE. Likewise,<br>tls_verify_crl_missin=
g can get confused between<br>backend_tls_ctx_reload_crl&#39;s crl_file-bas=
ed CRLs and CRLs from<br>tls_ctx_load_ca.<br><br>Avoid all this by tracking=
 the two CRLs separately. crl_file-based CRLs<br>now go onto a STACK_OF(X50=
9_CRL) tracked on the tls_root_ctx. Now this<br>field can be freely reloade=
d by OpenVPN without reconfiguring OpenSSL.<br>Instead, pass the current va=
lue into OpenSSL at verification time.  To<br>do so, we need to use the SSL=
_CTX_set_cert_verify_callback, which allows<br>swapping out the X509_verify=
_cert call, and also tweaking the<br>X509_STORE_CTX configuration before st=
arting certificate verification.<br><br>Context: SSL_CTX_set_cert_verify_ca=
llback and the existing<br>verify_callback are not the same. SSL_CTX_set_ce=
rt_verify_callback wraps<br>the verification while verify_callback is calle=
d multiple times<br>throughout verification. It&#39;s too late to reconfigu=
re X509_STORE_CTX in<br>verify_callback. verify_callback is usually not wha=
t you want.<br>Sometimes current_cert and error_depth don&#39;t quite line =
up, and<br>cert_hash_remember may end up called multiple times for a single=
<br>certificate.<br><br>I suspect some of the other verify_callback logic w=
ould also be better<br>done in the new callback, but I&#39;ve left it alone=
 to keep this change<br>minimal. verify_callback is really only usable for =
suppressing errors.<br>Application bookkeeping is better down elsewhere.<br=
><br>Add .clang-format section for STACK_OF since we otherwise format the<b=
r>line as STACK_OF(X509_CRL) * crls<br><br>Signed-off-by: David Benjamin &l=
t;davidben@...410...&gt;<br>Change-Id: I31ac2a763209114267c35c4a9182a12d8d8=
2f6fe<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M .c=
lang-format<br>M src/openvpn/openssl_compat.h<br>M src/openvpn/ssl_openssl.=
c<br>M src/openvpn/ssl_openssl.h<br>M src/openvpn/ssl_verify_openssl.c<br>5=
 files changed, 38 insertions(+), 55 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1289/12=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/.clang-format b/.clang-format</span><br><span>index c=
bec0a4..4774d1e 100644</span><br><span>--- a/.clang-format</span><br><span>=
+++ b/.clang-format</span><br><span>@@ -43,7 +43,10 @@</span><br><span> Spa=
cesBeforeTrailingComments: &#39;2&#39;</span><br><span> SpacesInParens: Nev=
er</span><br><span> TabWidth: &#39;4&#39;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-TypeNames: [DWORD]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+TypeNames:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  - &#39;DWORD&#39;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  - &#39;STACK_OF&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+TypenameMacros: [&#39;STACK_OF&#39;]</span><br><span> UseTab: =
Never</span><br><span> WhitespaceSensitiveMacros: [_STRINGIFY]</span><br><s=
pan> ---</span><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/op=
envpn/openssl_compat.h</span><br><span>index 8fdb39a..3494ce6 100644</span>=
<br><span>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/open=
vpn/openssl_compat.h</span><br><span>@@ -61,21 +61,6 @@</span><br><span> </=
span><br><span> /* Functionality missing in LibreSSL before 3.5 */</span><b=
r><span> #if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_N=
UMBER &lt; 0x3050000fL</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Destroy a X509=
 object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param obj                X509=
 object</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-X509_OBJECT_free(X509_OBJECT *obj)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (obj)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        X509_OBJECT_free_contents(obj);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        OPENSSL_free(obj);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG</span><br>=
<span> #define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG</span><br><span> =
#endif</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn=
/ssl_openssl.c</span><br><span>index e8d7262..04e3521 100644</span><br><spa=
n>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ope=
nssl.c</span><br><span>@@ -141,6 +141,8 @@</span><br><span>     ASSERT(NULL=
 !=3D ctx);</span><br><span>     SSL_CTX_free(ctx-&gt;ctx);</span><br><span=
>     ctx-&gt;ctx =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    sk_X509_CRL_pop_free(ctx-&gt;crls, X509_CRL_free);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;crls =3D NULL;</span=
><br><span>     unload_xkey_provider(); /* in case it is loaded */</span><b=
r><span> }</span><br><span> </span><br><span>@@ -304,6 +306,22 @@</span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cert_verify_callback(X509_STORE_CTX *ctx,=
 void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_session *se=
ssion;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SSL *ssl;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ssl =3D X509_STORE_CTX_get_ex_data=
(ctx, SSL_get_ex_data_X509_STORE_CTX_idx());</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(ssl);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    session =3D SSL_get_ex_data(ssl, mydata_index);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(session);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Configure CRLs. */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    X509_STORE_CTX_set0_crls(ctx,=
 session-&gt;opt-&gt;ssl_ctx-&gt;crls);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return X509_verify_cert(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> bool</span><br><span> tls_ctx_set_options=
(struct tls_root_ctx *ctx, unsigned int ssl_flags)</span><br><span> {</span=
><br><span>@@ -346,6 +364,7 @@</span><br><span>         verify_flags =3D SS=
L_VERIFY_PEER;</span><br><span>     }</span><br><span>     SSL_CTX_set_veri=
fy(ctx-&gt;ctx, verify_flags, verify_callback);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SSL_CTX_set_cert_verify_callback(ctx-&gt;ct=
x, cert_verify_callback, NULL);</span><br><span> </span><br><span>     SSL_=
CTX_set_info_callback(ctx-&gt;ctx, info_callback);</span><br><span> </span>=
<br><span>@@ -1374,6 +1393,7 @@</span><br><span> backend_tls_ctx_reload_crl=
(struct tls_root_ctx *ssl_ctx, const char *crl_file, bool crl_inline)</span=
><br><span> {</span><br><span>     BIO *in =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    STACK_OF(X509_CRL) *crls =3D NULL;</s=
pan><br><span> </span><br><span>     X509_STORE *store =3D SSL_CTX_get_cert=
_store(ssl_ctx-&gt;ctx);</span><br><span>     if (!store)</span><br><span>@=
@ -1381,20 +1401,8 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Ca=
nnot get certificate store&quot;);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Always start w=
ith a cleared CRL list, for that we</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * we need to manually find the CRL object from the stack=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and remove it =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    STACK_OF(X509_O=
BJECT) *objs =3D X509_STORE_get0_objects(store);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; sk_X509_OBJECT_num(=
objs); i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        X509_OBJECT *obj =
=3D sk_X509_OBJECT_value(objs, i);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(obj);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            sk_X509_OBJECT_delete(objs,=
 i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            X509_=
OBJECT_free(obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    sk_X509_CRL_pop_free(ssl_c=
tx-&gt;crls, X509_CRL_free);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ssl_ctx-&gt;crls =3D NULL;</span><br><span> </span><br><span> =
    X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHE=
CK_ALL);</span><br><span> </span><br><span>@@ -1410,7 +1418,13 @@</span><br=
><span>     if (in =3D=3D NULL)</span><br><span>     {</span><br><span>    =
     msg(M_WARN, &quot;CRL: cannot read: %s&quot;, print_key_filename(crl_f=
ile, crl_inline));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     goto end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    crls =3D sk_X509_CRL_new_null();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (crls =3D=3D NULL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quo=
t;CRL: cannot create CRL list&quot;);</span><br><span>     }</span><br><spa=
n> </span><br><span>     int num_crls_loaded =3D 0;</span><br><span>@@ -143=
6,18 +1450,14 @@</span><br><span>             break;</span><br><span>      =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (!X509_STORE_add_crl(store, crl))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!sk_X509_CRL_push(crls, crl))</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          X509_CRL_free(crl);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            crypto_msg(M_WARN, &quot;CRL: cannot add %s to store&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
      print_key_filename(crl_file, crl_inline));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            crypto_msg(M_FATAL, &quot;CRL: cannot=
 add CRL to list&quot;);</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        X509_CRL_free(crl);</span><br><span=
>         num_crls_loaded++;</span><br><span>     }</span><br><span>     ms=
g(M_INFO, &quot;CRL: loaded %d CRLs from file %s&quot;, num_crls_loaded, cr=
l_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-end:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ssl_ctx-&gt;crls =3D crl=
s;</span><br><span>     BIO_free(in);</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_op=
enssl.h</span><br><span>index 3926e91..373dc10 100644</span><br><span>--- a=
/src/openvpn/ssl_openssl.h</span><br><span>+++ b/src/openvpn/ssl_openssl.h<=
/span><br><span>@@ -41,6 +41,7 @@</span><br><span>     SSL_CTX *ctx;</span>=
<br><span>     time_t crl_last_mtime;</span><br><span>     off_t crl_last_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    STACK_OF(X5=
09_CRL) *crls;</span><br><span> };</span><br><span> </span><br><span> struc=
t key_state_ssl</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=
.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 96ca1a4..ef8231=
c 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><=
span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -798,23 +798=
,7 @@</span><br><span>         return false;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_ST=
ORE *store =3D SSL_CTX_get_cert_store(opt-&gt;ssl_ctx-&gt;ctx);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!store)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;Cannot get certificat=
e store&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    STACK_OF(X509_OBJECT) *objs =3D X509_ST=
ORE_get0_objects(store);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    for (int i =3D 0; i &lt; sk_X509_OBJECT_num(objs); i++)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        X509_OBJECT *obj =3D sk_X509_OBJECT_value(=
objs, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSE=
RT(obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (X=
509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return false;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return opt-&=
gt;ssl_ctx-&gt;crls =3D=3D NULL || sk_X509_CRL_num(opt-&gt;ssl_ctx-&gt;crls=
) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span> #endif /*=
 defined(ENABLE_CRYPTO_OPENSSL) */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demai=
l">change 1289</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: davidben &lt;davidben@...2975...=
...&gt; </div>

</body></html>=

--2BEq0u9b+gM=--

