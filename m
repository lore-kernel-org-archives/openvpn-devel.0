From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 16 Dec 2025 17:23:05 +0000
In-Reply-To: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
References: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <080f743bc9fbcd05dfb67ea96ca94d049be4b361-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FEFGNwGNmQc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change ssl_ctx in
 struct tls_options to be a pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FEFGNwGNmQc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: Change ssl_ctx in struct tls_options to be a pointer
......................................................................

Change ssl_ctx in struct tls_options to be a pointer

The SSL CTX is shared between all of the instances. So any change to the
SSL CTX will affect all instances. Currently the CRL is also reloaded
potentially multiple times as each copy of tls_root_ctx has its own
crl_last_mtime and crl_last_size values that will be checked if the CRL
reload is necessary.

Changing it to a pointer will make it more clear that this is shared
and also the CRL being reloaded multiple times.

Change-Id: I21251a42f94fa1d9de083d2acd95b887658c5760
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1431
Message-Id: <20251216144207.12171-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
116.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/openvpn.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
9 files changed, 35 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1431/7

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd01520..ee198ce 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2964,9 +2964,10 @@
 key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
 {
     free_key_ctx_bi(&ks->static_key);
-    if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
+    if (tls_ctx_initialised(ks->ssl_ctx) && free_ssl_ctx)
     {
-        tls_ctx_free(&ks->ssl_ctx);
+        tls_ctx_free(ks->ssl_ctx);
+        free(ks->ssl_ctx);
         free_key_ctx(&ks->auth_token_key);
     }
     CLEAR(*ks);
@@ -3121,14 +3122,15 @@
 {
     const struct options *options =3D &c->options;

-    if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
+    if (!tls_ctx_initialised(c->c1.ks.ssl_ctx))
     {
         /*
          * Initialize the OpenSSL library's global
          * SSL context.
          */
-        init_ssl(options, &(c->c1.ks.ssl_ctx), c->c0 && c->c0->uid_gid_chr=
oot_set);
-        if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
+        ASSERT(NULL =3D=3D c->c1.ks.ssl_ctx);
+        c->c1.ks.ssl_ctx =3D init_ssl(options, c->c0 && c->c0->uid_gid_chr=
oot_set);
+        if (!tls_ctx_initialised(c->c1.ks.ssl_ctx))
         {
             switch (auth_retry_get())
             {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3e1ae78..9325e21 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -60,7 +60,7 @@
     struct key_ctx_bi static_key;

     /* our global SSL context */
-    struct tls_root_ctx ssl_ctx;
+    struct tls_root_ctx *ssl_ctx;

     /* optional TLS control channel wrapping */
     struct key_type tls_auth_key_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 741f40a..5ee51e9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -507,11 +507,9 @@
  * Initialize SSL context.
  * All files are in PEM format.
  */
-void
-init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool=
 in_chroot)
+struct tls_root_ctx *
+init_ssl(const struct options *options, bool in_chroot)
 {
-    ASSERT(NULL !=3D new_ctx);
-
     tls_clear_error();

     if (key_is_external(options))
@@ -519,6 +517,9 @@
         load_xkey_provider();
     }

+    struct tls_root_ctx *new_ctx;
+    ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);
+
     if (options->tls_server)
     {
         tls_ctx_server_new(new_ctx);
@@ -664,12 +665,13 @@
 #endif

     tls_clear_error();
-    return;
+    return new_ctx;

 err:
     tls_clear_error();
     tls_ctx_free(new_ctx);
-    return;
+    free(new_ctx);
+    return NULL;
 }

 /*
@@ -821,7 +823,7 @@
      * Build TLS object that reads/writes ciphertext
      * to/from memory BIOs.
      */
-    key_state_ssl_init(&ks->ks_ssl, &session->opt->ssl_ctx, session->opt->=
server, session);
+    key_state_ssl_init(&ks->ks_ssl, session->opt->ssl_ctx, session->opt->s=
erver, session);

     /* Set control-channel initiation mode */
     ks->initial_opcode =3D session->initial_opcode;
@@ -872,11 +874,12 @@

     /*
      * Attempt CRL reload before TLS negotiation. Won't be performed if
-     * the file was not modified since the last reload
+     * the file was not modified since the last reload. This affects
+     * all instances (all instances share the same context).
      */
     if (session->opt->crl_file && !(session->opt->ssl_flags & SSLF_CRL_VER=
IFY_DIR))
     {
-        tls_ctx_reload_crl(&session->opt->ssl_ctx, session->opt->crl_file,
+        tls_ctx_reload_crl(session->opt->ssl_ctx, session->opt->crl_file,
                            session->opt->crl_file_inline);
     }
 }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index db8a798..9ee9f38 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -144,7 +144,7 @@
  * Build master SSL context object that serves for the whole of OpenVPN
  * instantiation
  */
-void init_ssl(const struct options *options, struct tls_root_ctx *ctx, boo=
l in_chroot);
+struct tls_root_ctx *init_ssl(const struct options *options, bool in_chroo=
t);

 /** @addtogroup control_processor
  *  @{ */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3129299..2764840 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -305,8 +305,10 @@
  */
 struct tls_options
 {
-    /* our master TLS context from which all SSL objects derived */
-    struct tls_root_ctx ssl_ctx;
+    /* our master TLS context from which all SSL objects are derived,
+     * this context is shared between all instances in p2pm with
+     * inherit_context_child. */
+    struct tls_root_ctx *ssl_ctx;

     /* data channel cipher, hmac, and key lengths */
     struct key_type key_type;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 3440319..28b92ed 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -157,8 +157,10 @@
 bool
 tls_ctx_initialised(struct tls_root_ctx *ctx)
 {
-    ASSERT(NULL !=3D ctx);
-    return ctx->initialised;
+    /* either this should be NULL or should be non-null and then have a
+     * valid TLS ctx inside as well */
+    ASSERT(NULL =3D=3D ctx || ctx->initialised);
+    return ctx !=3D NULL;
 }
 #if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
 /*
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a4a6863..48bbdfc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -147,8 +147,10 @@
 bool
 tls_ctx_initialised(struct tls_root_ctx *ctx)
 {
-    ASSERT(NULL !=3D ctx);
-    return NULL !=3D ctx->ctx;
+    /* either this should be NULL or should be non-null and then have a
+     * valid TLS ctx inside as well */
+    ASSERT(ctx =3D=3D NULL || ctx->ctx !=3D NULL);
+    return ctx !=3D NULL;
 }

 bool
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 250c806..b7de550 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -572,7 +572,7 @@
 tls_verify_crl_missing(const struct tls_options *opt)
 {
     if (opt->crl_file && !(opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
-        && (opt->ssl_ctx.crl =3D=3D NULL || opt->ssl_ctx.crl->version =3D=
=3D 0))
+        && (opt->ssl_ctx->crl =3D=3D NULL || opt->ssl_ctx->crl->version =
=3D=3D 0))
     {
         return true;
     }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 6cb04ee..633f78d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -799,7 +799,7 @@
         return false;
     }

-    X509_STORE *store =3D SSL_CTX_get_cert_store(opt->ssl_ctx.ctx);
+    X509_STORE *store =3D SSL_CTX_get_cert_store(opt->ssl_ctx->ctx);
     if (!store)
     {
         crypto_msg(M_FATAL, "Cannot get certificate store");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd95b887658c5760
Gerrit-Change-Number: 1431
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FEFGNwGNmQc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">Change ssl_ctx in struct tls_options=
 to be a pointer<br><br>The SSL CTX is shared between all of the instances.=
 So any change to the<br>SSL CTX will affect all instances. Currently the C=
RL is also reloaded<br>potentially multiple times as each copy of tls_root_=
ctx has its own<br>crl_last_mtime and crl_last_size values that will be che=
cked if the CRL<br>reload is necessary.<br><br>Changing it to a pointer wil=
l make it more clear that this is shared<br>and also the CRL being reloaded=
 multiple times.<br><br>Change-Id: I21251a42f94fa1d9de083d2acd95b887658c576=
0<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: MaxF =
&lt;max@...2606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/=
+/1431<br>Message-Id: &lt;20251216144207.12171-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35116=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/init.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/ssl.c<br>M src=
/openvpn/ssl.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_mbedtls.c=
<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M =
src/openvpn/ssl_verify_openssl.c<br>9 files changed, 35 insertions(+), 24 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/31/1431/7</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c =
b/src/openvpn/init.c</span><br><span>index cd01520..ee198ce 100644</span><b=
r><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</=
span><br><span>@@ -2964,9 +2964,10 @@</span><br><span> key_schedule_free(st=
ruct key_schedule *ks, bool free_ssl_ctx)</span><br><span> {</span><br><spa=
n>     free_key_ctx_bi(&amp;ks-&gt;static_key);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (tls_ctx_initialised(&amp;ks-&gt;ssl_ctx) =
&amp;&amp; free_ssl_ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (tls_ctx_initialised(ks-&gt;ssl_ctx) &amp;&amp; free_ssl_ctx)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        tls_ctx_free(&amp;ks-&gt;ssl_ctx);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tls_ctx_free(ks-&gt;ssl_ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        free(ks-&gt;ssl_ctx);</spa=
n><br><span>         free_key_ctx(&amp;ks-&gt;auth_token_key);</span><br><s=
pan>     }</span><br><span>     CLEAR(*ks);</span><br><span>@@ -3121,14 +31=
22,15 @@</span><br><span> {</span><br><span>     const struct options *opti=
ons =3D &amp;c-&gt;options;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (!tls_ctx_initialised(&amp;c-&gt;c1.ks.ssl_c=
tx))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_ct=
x_initialised(c-&gt;c1.ks.ssl_ctx))</span><br><span>     {</span><br><span>=
         /*</span><br><span>          * Initialize the OpenSSL library&#39;=
s global</span><br><span>          * SSL context.</span><br><span>         =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        init_ssl(o=
ptions, &amp;(c-&gt;c1.ks.ssl_ctx), c-&gt;c0 &amp;&amp; c-&gt;c0-&gt;uid_gi=
d_chroot_set);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!tls_ctx_initialised(&amp;c-&gt;c1.ks.ssl_ctx))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(NULL =3D=3D c-&gt;c1.ks.ss=
l_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&g=
t;c1.ks.ssl_ctx =3D init_ssl(options, c-&gt;c0 &amp;&amp; c-&gt;c0-&gt;uid_=
gid_chroot_set);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!tls_ctx_initialised(c-&gt;c1.ks.ssl_ctx))</span><br><span>       =
  {</span><br><span>             switch (auth_retry_get())</span><br><span>=
             {</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/ope=
nvpn/openvpn.h</span><br><span>index 3e1ae78..9325e21 100644</span><br><spa=
n>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</=
span><br><span>@@ -60,7 +60,7 @@</span><br><span>     struct key_ctx_bi sta=
tic_key;</span><br><span> </span><br><span>     /* our global SSL context *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_root_=
ctx ssl_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct tls_root_ctx *ssl_ctx;</span><br><span> </span><br><span>     /* option=
al TLS control channel wrapping */</span><br><span>     struct key_type tls=
_auth_key_type;</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvp=
n/ssl.c</span><br><span>index 741f40a..5ee51e9 100644</span><br><span>--- a=
/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>=
@@ -507,11 +507,9 @@</span><br><span>  * Initialize SSL context.</span><br>=
<span>  * All files are in PEM format.</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-init_ssl(const struct options *options, struct tls_roo=
t_ctx *new_ctx, bool in_chroot)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct tls_root_ctx *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+init_ssl(const struct options *options, bool in_chroot)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSE=
RT(NULL !=3D new_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     tls_clear_error();</span><br><span> </span><br><span=
>     if (key_is_external(options))</span><br><span>@@ -519,6 +517,9 @@</sp=
an><br><span>         load_xkey_provider();</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 tls_root_ctx *new_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (options-&gt;tl=
s_server)</span><br><span>     {</span><br><span>         tls_ctx_server_ne=
w(new_ctx);</span><br><span>@@ -664,12 +665,13 @@</span><br><span> #endif</=
span><br><span> </span><br><span>     tls_clear_error();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return new_ctx;</span><br><span> </span><br>=
<span> err:</span><br><span>     tls_clear_error();</span><br><span>     tl=
s_ctx_free(new_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(=
new_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 NULL;</span><br><span> }</span><br><span> </span><br><span> /*</span><br><=
span>@@ -821,7 +823,7 @@</span><br><span>      * Build TLS object that read=
s/writes ciphertext</span><br><span>      * to/from memory BIOs.</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key=
_state_ssl_init(&amp;ks-&gt;ks_ssl, &amp;session-&gt;opt-&gt;ssl_ctx, sessi=
on-&gt;opt-&gt;server, session);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    key_state_ssl_init(&amp;ks-&gt;ks_ssl, session-&gt;opt-&gt=
;ssl_ctx, session-&gt;opt-&gt;server, session);</span><br><span> </span><br=
><span>     /* Set control-channel initiation mode */</span><br><span>     =
ks-&gt;initial_opcode =3D session-&gt;initial_opcode;</span><br><span>@@ -8=
72,11 +874,12 @@</span><br><span> </span><br><span>     /*</span><br><span>=
      * Attempt CRL reload before TLS negotiation. Won&#39;t be performed i=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the file was =
not modified since the last reload</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * the file was not modified since the last reload. This=
 affects</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * all =
instances (all instances share the same context).</span><br><span>      */<=
/span><br><span>     if (session-&gt;opt-&gt;crl_file &amp;&amp; !(session-=
&gt;opt-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_ctx_reload_c=
rl(&amp;session-&gt;opt-&gt;ssl_ctx, session-&gt;opt-&gt;crl_file,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tls_ctx_reload_crl(s=
ession-&gt;opt-&gt;ssl_ctx, session-&gt;opt-&gt;crl_file,</span><br><span> =
                           session-&gt;opt-&gt;crl_file_inline);</span><br>=
<span>     }</span><br><span> }</span><br><span>diff --git a/src/openvpn/ss=
l.h b/src/openvpn/ssl.h</span><br><span>index db8a798..9ee9f38 100644</span=
><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h<=
/span><br><span>@@ -144,7 +144,7 @@</span><br><span>  * Build master SSL co=
ntext object that serves for the whole of OpenVPN</span><br><span>  * insta=
ntiation</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void init_ssl(const struct options *options, struct tls_root_ctx *c=
tx, bool in_chroot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct tls_root_ctx *init_ssl(const struct options *options, bool in_chroo=
t);</span><br><span> </span><br><span> /** @addtogroup control_processor</s=
pan><br><span>  *  @{ */</span><br><span>diff --git a/src/openvpn/ssl_commo=
n.h b/src/openvpn/ssl_common.h</span><br><span>index 3129299..2764840 10064=
4</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/=
openvpn/ssl_common.h</span><br><span>@@ -305,8 +305,10 @@</span><br><span> =
 */</span><br><span> struct tls_options</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* our master TLS context from whi=
ch all SSL objects derived */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct tls_root_ctx ssl_ctx;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* our master TLS context from which all SSL objec=
ts are derived,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * this context is shared between all instances in p2pm with</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * inherit_context_child. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_root_c=
tx *ssl_ctx;</span><br><span> </span><br><span>     /* data channel cipher,=
 hmac, and key lengths */</span><br><span>     struct key_type key_type;</s=
pan><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbed=
tls.c</span><br><span>index 3440319..28b92ed 100644</span><br><span>--- a/s=
rc/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</s=
pan><br><span>@@ -157,8 +157,10 @@</span><br><span> bool</span><br><span> t=
ls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return ctx-&gt;initialis=
ed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* either th=
is should be NULL or should be non-null and then have a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * valid TLS ctx inside as well */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(NULL =3D=
=3D ctx || ctx-&gt;initialised);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return ctx !=3D NULL;</span><br><span> }</span><br><span> =
#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span> /*</span>=
<br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.=
c</span><br><span>index a4a6863..48bbdfc 100644</span><br><span>--- a/src/o=
penvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span>=
<br><span>@@ -147,8 +147,10 @@</span><br><span> bool</span><br><span> tls_c=
tx_initialised(struct tls_root_ctx *ctx)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return NULL !=3D ctx-&gt;ctx=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* either this=
 should be NULL or should be non-null and then have a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * valid TLS ctx inside as well */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ctx =3D=3D =
NULL || ctx-&gt;ctx !=3D NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ctx !=3D NULL;</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span>diff --git a/src/openvpn/ssl_verify_m=
bedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>index 250c806..=
b7de550 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span=
><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -572,7=
 +572,7 @@</span><br><span> tls_verify_crl_missing(const struct tls_options=
 *opt)</span><br><span> {</span><br><span>     if (opt-&gt;crl_file &amp;&a=
mp; !(opt-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; (opt-&gt;ssl_ctx.crl =3D=3D=
 NULL || opt-&gt;ssl_ctx.crl-&gt;version =3D=3D 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (opt-&gt;ssl_ctx-&gt;c=
rl =3D=3D NULL || opt-&gt;ssl_ctx-&gt;crl-&gt;version =3D=3D 0))</span><br>=
<span>     {</span><br><span>         return true;</span><br><span>     }</=
span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/=
ssl_verify_openssl.c</span><br><span>index 6cb04ee..633f78d 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/op=
envpn/ssl_verify_openssl.c</span><br><span>@@ -799,7 +799,7 @@</span><br><s=
pan>         return false;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_STORE *store =3D SSL=
_CTX_get_cert_store(opt-&gt;ssl_ctx.ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    X509_STORE *store =3D SSL_CTX_get_cert_store(opt-=
&gt;ssl_ctx-&gt;ctx);</span><br><span>     if (!store)</span><br><span>    =
 {</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot get certificat=
e store&quot;);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail">change 1431</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1431?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21251a42f94fa1d9de083d2acd9=
5b887658c5760 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1431 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--FEFGNwGNmQc=--

