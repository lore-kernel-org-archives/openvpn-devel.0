From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Apr 2026 10:21:28 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <250b31b135eb0f7167171361fbbb6f8f2969a6cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MkTZ4kBitN8="; charset=UTF-8
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
To: davidben <davidben@...410...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MkTZ4kBitN8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
89?usp=3Demail )

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

Github: see also openssl/openssl#28599
Signed-off-by: David Benjamin <davidben@...410...>
Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1289
Message-Id: <20260416174142.28918-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
641.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .clang-format
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_openssl.h
M src/openvpn/ssl_verify_openssl.c
5 files changed, 38 insertions(+), 55 deletions(-)




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
index fd05f43..efe5b5b 100644
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

@@ -1321,6 +1340,7 @@
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_f=
ile, bool crl_inline)
 {
     BIO *in =3D NULL;
+    STACK_OF(X509_CRL) *crls =3D NULL;

     X509_STORE *store =3D SSL_CTX_get_cert_store(ssl_ctx->ctx);
     if (!store)
@@ -1328,20 +1348,8 @@
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

@@ -1357,7 +1365,13 @@
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
@@ -1383,18 +1397,14 @@
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
index 115b8d2..a30099d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -808,23 +808,7 @@
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 13
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MkTZ4kBitN8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1289?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_openssl: Fix some CRL mixups<br><br>There ar=
e two ways to load CRLs in OpenSSL. They can be loaded at the<br>X509_STORE=
, shared across verifications, or loaded per verification at<br>the X509_ST=
ORE_CTX.<br><br>OpenVPN currently does the former. However, it also support=
s CRL<br>reloading, and tries to reload the CRL file before each connection=
.<br>OpenSSL does not really have a good way to unload objects from an<br>X=
509_STORE. OpenVPN currently does it by grabbing the<br>STACK_OF(X509_OBJEC=
T) out of the X509_STORE and manually deleting all<br>the CRLs from it.<br>=
<br>This mutates an OpenSSL internal object which bumps into problems if<br=
>OpenSSL ever switches to a more efficient representation. See<br>https://g=
ithub.com/openssl/openssl/pull/28599<br><br>(It&#39;s also not thread-safe,=
 though it doesn&#39;t look like that impacts<br>OpenVPN? Actually even rea=
ding that list doesn&#39;t work. See<br>CVE-2024-0397. This OpenSSL API was=
 simply broken.)<br><br>Additionally, this seems to cause two OpenVPN featu=
res to not work<br>together. I gather backend_tls_ctx_reload_crl is trying =
to clear the<br>CRLs loaded from last time it ran. But tls_ctx_load_ca with=
 a ca_file<br>can also load CRLs. tls_ctx_load_ca with ca_path will also pi=
ck up CRLs<br>and backend_tls_ctx_reload_crl actually ends up clobbering so=
me state<br>X509_LOOKUP_hash_dir internally maintains on the X509_STORE. Li=
kewise,<br>tls_verify_crl_missing can get confused between<br>backend_tls_c=
tx_reload_crl&#39;s crl_file-based CRLs and CRLs from<br>tls_ctx_load_ca.<b=
r><br>Avoid all this by tracking the two CRLs separately. crl_file-based CR=
Ls<br>now go onto a STACK_OF(X509_CRL) tracked on the tls_root_ctx. Now thi=
s<br>field can be freely reloaded by OpenVPN without reconfiguring OpenSSL.=
<br>Instead, pass the current value into OpenSSL at verification time.  To<=
br>do so, we need to use the SSL_CTX_set_cert_verify_callback, which allows=
<br>swapping out the X509_verify_cert call, and also tweaking the<br>X509_S=
TORE_CTX configuration before starting certificate verification.<br><br>Con=
text: SSL_CTX_set_cert_verify_callback and the existing<br>verify_callback =
are not the same. SSL_CTX_set_cert_verify_callback wraps<br>the verificatio=
n while verify_callback is called multiple times<br>throughout verification=
. It&#39;s too late to reconfigure X509_STORE_CTX in<br>verify_callback. ve=
rify_callback is usually not what you want.<br>Sometimes current_cert and e=
rror_depth don&#39;t quite line up, and<br>cert_hash_remember may end up ca=
lled multiple times for a single<br>certificate.<br><br>I suspect some of t=
he other verify_callback logic would also be better<br>done in the new call=
back, but I&#39;ve left it alone to keep this change<br>minimal. verify_cal=
lback is really only usable for suppressing errors.<br>Application bookkeep=
ing is better down elsewhere.<br><br>Add .clang-format section for STACK_OF=
 since we otherwise format the<br>line as STACK_OF(X509_CRL) * crls<br><br>=
Github: see also openssl/openssl#28599<br>Signed-off-by: David Benjamin &lt=
;davidben@...410...&gt;<br>Change-Id: I31ac2a763209114267c35c4a9182a12d8d82=
f6fe<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: MaxF &lt;max@...2854...=
6...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1289<br>Mess=
age-Id: &lt;20260416174142.28918-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36641.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .clang-format<br=
>M src/openvpn/openssl_compat.h<br>M src/openvpn/ssl_openssl.c<br>M src/ope=
nvpn/ssl_openssl.h<br>M src/openvpn/ssl_verify_openssl.c<br>5 files changed=
, 38 insertions(+), 55 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.clang-format b/.clang-format</span><br><span>index cbec0a4=
..4774d1e 100644</span><br><span>--- a/.clang-format</span><br><span>+++ b/=
.clang-format</span><br><span>@@ -43,7 +43,10 @@</span><br><span> SpacesBef=
oreTrailingComments: &#39;2&#39;</span><br><span> SpacesInParens: Never</sp=
an><br><span> TabWidth: &#39;4&#39;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-TypeNames: [DWORD]</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+TypeNames:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  - &#39;DWORD&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  - &#39;STACK_OF&#39;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+TypenameMacros: [&#39;STACK_OF&#39;]</span><br><span> UseTab: Never<=
/span><br><span> WhitespaceSensitiveMacros: [_STRINGIFY]</span><br><span> -=
--</span><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/=
openssl_compat.h</span><br><span>index 8fdb39a..3494ce6 100644</span><br><s=
pan>--- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/op=
enssl_compat.h</span><br><span>@@ -61,21 +61,6 @@</span><br><span> </span><=
br><span> /* Functionality missing in LibreSSL before 3.5 */</span><br><spa=
n> #if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER =
&lt; 0x3050000fL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Destroy a X509 objec=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param obj                X509 objec=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-X509_OBJECT_free(X509_OBJECT *obj)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (obj)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        X509_OBJECT_free_contents(obj);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        OPENSSL_free(obj);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG</span><br><span> =
#define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG</span><br><span> #endif<=
/span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_op=
enssl.c</span><br><span>index fd05f43..efe5b5b 100644</span><br><span>--- a=
/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c<=
/span><br><span>@@ -141,6 +141,8 @@</span><br><span>     ASSERT(NULL !=3D c=
tx);</span><br><span>     SSL_CTX_free(ctx-&gt;ctx);</span><br><span>     c=
tx-&gt;ctx =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    sk_X509_CRL_pop_free(ctx-&gt;crls, X509_CRL_free);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;crls =3D NULL;</span><br><s=
pan>     unload_xkey_provider(); /* in case it is loaded */</span><br><span=
> }</span><br><span> </span><br><span>@@ -304,6 +306,22 @@</span><br><span>=
     return true;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+cert_verify_callback(X509_STORE_CTX *ctx, void *a=
rg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_session *session;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SSL *ssl;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ssl =3D X509_STORE_CTX_get_ex_data(ctx, SS=
L_get_ex_data_X509_STORE_CTX_idx());</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(ssl);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    session =3D SSL_get_ex_data(ssl, mydata_index);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(session);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Configure CRLs. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    X509_STORE_CTX_set0_crls(ctx, session=
-&gt;opt-&gt;ssl_ctx-&gt;crls);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return X509_verify_cert(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> bool</span><br><span> tls_ctx_set_options(struct =
tls_root_ctx *ctx, unsigned int ssl_flags)</span><br><span> {</span><br><sp=
an>@@ -346,6 +364,7 @@</span><br><span>         verify_flags =3D SSL_VERIFY=
_PEER;</span><br><span>     }</span><br><span>     SSL_CTX_set_verify(ctx-&=
gt;ctx, verify_flags, verify_callback);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    SSL_CTX_set_cert_verify_callback(ctx-&gt;ctx, cert_=
verify_callback, NULL);</span><br><span> </span><br><span>     SSL_CTX_set_=
info_callback(ctx-&gt;ctx, info_callback);</span><br><span> </span><br><spa=
n>@@ -1321,6 +1340,7 @@</span><br><span> backend_tls_ctx_reload_crl(struct =
tls_root_ctx *ssl_ctx, const char *crl_file, bool crl_inline)</span><br><sp=
an> {</span><br><span>     BIO *in =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    STACK_OF(X509_CRL) *crls =3D NULL;</span><br><=
span> </span><br><span>     X509_STORE *store =3D SSL_CTX_get_cert_store(ss=
l_ctx-&gt;ctx);</span><br><span>     if (!store)</span><br><span>@@ -1328,2=
0 +1348,8 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot get =
certificate store&quot;);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* Always start with a cle=
ared CRL list, for that we</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * we need to manually find the CRL object from the stack</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * and remove it */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    STACK_OF(X509_OBJECT) *o=
bjs =3D X509_STORE_get0_objects(store);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (int i =3D 0; i &lt; sk_X509_OBJECT_num(objs); i+=
+)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        X509_OBJECT *obj =3D sk_X50=
9_OBJECT_value(objs, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ASSERT(obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (X509_OBJECT_get_type(obj) =3D=3D X509_LU_CRL)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            sk_X509_OBJECT_delete(objs, i);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            X509_OBJECT_fre=
e(obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    sk_X509_CRL_pop_free(ssl_ctx-&gt;crl=
s, X509_CRL_free);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ssl_ctx-&gt;crls =3D NULL;</span><br><span> </span><br><span>     X509_S=
TORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);</=
span><br><span> </span><br><span>@@ -1357,7 +1365,13 @@</span><br><span>   =
  if (in =3D=3D NULL)</span><br><span>     {</span><br><span>         msg(M=
_WARN, &quot;CRL: cannot read: %s&quot;, print_key_filename(crl_file, crl_i=
nline));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto =
end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    crls =3D sk_X509_CRL_new_null();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (crls =3D=3D NULL)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;CRL: ca=
nnot create CRL list&quot;);</span><br><span>     }</span><br><span> </span=
><br><span>     int num_crls_loaded =3D 0;</span><br><span>@@ -1383,18 +139=
7,14 @@</span><br><span>             break;</span><br><span>         }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (!X509_STORE_add_crl(store, crl))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!sk_X509_CRL_push(crls, crl))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 X509_CRL_free(crl);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           crypto_msg(M_WARN, &quot;CRL: cannot add %s to store&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                       pri=
nt_key_filename(crl_file, crl_inline));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            crypto_msg(M_FATAL, &quot;CRL: cannot add CRL =
to list&quot;);</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        X509_CRL_free(crl);</span><br><span>         n=
um_crls_loaded++;</span><br><span>     }</span><br><span>     msg(M_INFO, &=
quot;CRL: loaded %d CRLs from file %s&quot;, num_crls_loaded, crl_file);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-end:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ssl_ctx-&gt;crls =3D crls;</span><b=
r><span>     BIO_free(in);</span><br><span> }</span><br><span> </span><br><=
span>diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h</sp=
an><br><span>index 3926e91..373dc10 100644</span><br><span>--- a/src/openvp=
n/ssl_openssl.h</span><br><span>+++ b/src/openvpn/ssl_openssl.h</span><br><=
span>@@ -41,6 +41,7 @@</span><br><span>     SSL_CTX *ctx;</span><br><span> =
    time_t crl_last_mtime;</span><br><span>     off_t crl_last_size;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    STACK_OF(X509_CRL) *cr=
ls;</span><br><span> };</span><br><span> </span><br><span> struct key_state=
_ssl</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/op=
envpn/ssl_verify_openssl.c</span><br><span>index 115b8d2..a30099d 100644</s=
pan><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/=
src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -808,23 +808,7 @@</span=
><br><span>         return false;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_STORE *store =
=3D SSL_CTX_get_cert_store(opt-&gt;ssl_ctx-&gt;ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!store)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        crypto_msg(M_FATAL, &quot;Cannot get certificate store&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_o=
bjects(store);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for=
 (int i =3D 0; i &lt; sk_X509_OBJECT_num(objs); i++)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(obj);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (X509_OBJEC=
T_get_type(obj) =3D=3D X509_LU_CRL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return opt-&gt;ssl_ct=
x-&gt;crls =3D=3D NULL || sk_X509_CRL_num(opt-&gt;ssl_ctx-&gt;crls) =3D=3D =
0;</span><br><span> }</span><br><span> </span><br><span> #endif /* defined(=
ENABLE_CRYPTO_OPENSSL) */</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">change=
 1289</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MkTZ4kBitN8=--

