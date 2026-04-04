From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 15:51:41 +0000
In-Reply-To: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
References: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7287d953fbc8ff38fed48a477a09f92fc6feef07-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/cIea8iUzc8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: OpenSSL 4.0: Make
 X509 objects const
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/cIea8iUzc8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
96?usp=3Demail )

Change subject: OpenSSL 4.0: Make X509 objects const
......................................................................

OpenSSL 4.0: Make X509 objects const

In OpenSSL 4.0 a lot of the APIs have changed to return const objects.
Adjust our source code to use const objects as well.

Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1596
Message-Id: <20260402121049.41102-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
437.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_openssl.c
2 files changed, 39 insertions(+), 29 deletions(-)




diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a26663a..fd05f43 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1789,7 +1789,6 @@
     STACK_OF(X509_NAME) *cert_names =3D NULL;
     X509_LOOKUP *lookup =3D NULL;
     X509_STORE *store =3D NULL;
-    X509_NAME *xn =3D NULL;
     BIO *in =3D NULL;
     int i, added =3D 0, prev =3D 0;

@@ -1853,21 +1852,26 @@
                         }
                     }

-                    xn =3D X509_get_subject_name(info->x509);
+                    /* OpenSSL 4.0 has made X509_get_subject_name return c=
onst
+                     * but not adjusted the other functions to take const
+                     * arguments, and other libraries do not have const
+                     * arguments, so just ignore const here */
+                    X509_NAME *xn =3D (X509_NAME *)X509_get_subject_name(i=
nfo->x509);
                     if (!xn)
                     {
                         continue;
                     }

+
                     /* Don't add duplicate CA names */
-                    if (sk_X509_NAME_find(cert_names, xn) =3D=3D -1)
+                    if (sk_X509_NAME_find(cert_names, (X509_NAME *)xn) =3D=
=3D -1)
                     {
-                        xn =3D X509_NAME_dup(xn);
-                        if (!xn)
+                        X509_NAME *xn_dup =3D X509_NAME_dup(xn);
+                        if (!xn_dup)
                         {
                             continue;
                         }
-                        sk_X509_NAME_push(cert_names, xn);
+                        sk_X509_NAME_push(cert_names, xn_dup);
                     }
                 }

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index c70022f..96ca1a4 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -191,7 +191,7 @@
  * to contain result is grounds for error).
  */
 static result_t
-extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,=
 size_t size)
+extract_x509_field_ssl(const X509_NAME *x509, const char *field_name, char=
 *out, size_t size)
 {
     int lastpos =3D -1;
     int tmp =3D -1;
@@ -209,7 +209,12 @@
     do
     {
         lastpos =3D tmp;
+#if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
         tmp =3D X509_NAME_get_index_by_OBJ(x509, field_name_obj, lastpos);
+#else
+        /* OpenSSL 1.1.x has the argument as non-const */
+        tmp =3D X509_NAME_get_index_by_OBJ((X509_NAME *)x509, field_name_o=
bj, lastpos);
+#endif
     } while (tmp > -1);

     ASN1_OBJECT_free(field_name_obj);
@@ -269,7 +274,7 @@
     }
     else
     {
-        X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_cert);
+        const X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_=
cert);
         if (x509_subject_name =3D=3D NULL)
         {
             msg(D_TLS_ERRORS, "X509 subject name is NULL");
@@ -457,7 +462,12 @@
 x509_setenv_track(const struct x509_track *xt, struct env_set *es, const i=
nt depth, X509 *x509)
 {
     struct gc_arena gc =3D gc_new();
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+    /* OpenSSL 1.1.x APIs all take non-const arguments */
     X509_NAME *x509_name =3D X509_get_subject_name(x509);
+#else
+    const X509_NAME *x509_name =3D X509_get_subject_name(x509);
+#endif
     const char nullc =3D '\0';

     while (xt)
@@ -491,10 +501,10 @@
                     int i =3D X509_NAME_get_index_by_NID(x509_name, xt->ni=
d, -1);
                     if (i >=3D 0)
                     {
-                        X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_=
name, i);
+                        const X509_NAME_ENTRY *ent =3D X509_NAME_get_entry=
(x509_name, i);
                         if (ent)
                         {
-                            ASN1_STRING *val =3D X509_NAME_ENTRY_get_data(=
ent);
+                            const ASN1_STRING *val =3D X509_NAME_ENTRY_get=
_data(ent);
                             unsigned char *buf =3D NULL;
                             if (ASN1_STRING_to_UTF8(&buf, val) >=3D 0)
                             {
@@ -508,7 +518,11 @@
                         i =3D X509_get_ext_by_NID(x509, xt->nid, -1);
                         if (i >=3D 0)
                         {
+#if OPENSSL_VERSION_NUMBER < 0x40000000L
                             X509_EXTENSION *ext =3D X509_get_ext(x509, i);
+#else
+                            const X509_EXTENSION *ext =3D X509_get_ext(x50=
9, i);
+#endif
                             if (ext)
                             {
                                 BIO *bio =3D BIO_new(BIO_s_mem());
@@ -544,51 +558,43 @@
 void
 x509_setenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_=
cert)
 {
-    int i, n;
-    int fn_nid;
-    ASN1_OBJECT *fn;
-    ASN1_STRING *val;
-    X509_NAME_ENTRY *ent;
-    const char *objbuf;
-    unsigned char *buf =3D NULL;
-    char *name_expand;
-    size_t name_expand_size;
-    X509_NAME *x509 =3D X509_get_subject_name(peer_cert);
+    const X509_NAME *x509 =3D X509_get_subject_name(peer_cert);

-    n =3D X509_NAME_entry_count(x509);
-    for (i =3D 0; i < n; ++i)
+    int n =3D X509_NAME_entry_count(x509);
+    for (int i =3D 0; i < n; ++i)
     {
-        ent =3D X509_NAME_get_entry(x509, i);
+        const X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509, i);
         if (!ent)
         {
             continue;
         }
-        fn =3D X509_NAME_ENTRY_get_object(ent);
+        const ASN1_OBJECT *fn =3D X509_NAME_ENTRY_get_object(ent);
         if (!fn)
         {
             continue;
         }
-        val =3D X509_NAME_ENTRY_get_data(ent);
+        const ASN1_STRING *val =3D X509_NAME_ENTRY_get_data(ent);
         if (!val)
         {
             continue;
         }
-        fn_nid =3D OBJ_obj2nid(fn);
+        int fn_nid =3D OBJ_obj2nid(fn);
         if (fn_nid =3D=3D NID_undef)
         {
             continue;
         }
-        objbuf =3D OBJ_nid2sn(fn_nid);
+        const char *objbuf =3D OBJ_nid2sn(fn_nid);
         if (!objbuf)
         {
             continue;
         }
+        unsigned char *buf =3D NULL;
         if (ASN1_STRING_to_UTF8(&buf, val) < 0)
         {
             continue;
         }
-        name_expand_size =3D 64 + strlen(objbuf);
-        name_expand =3D (char *)malloc(name_expand_size);
+        size_t name_expand_size =3D 64 + strlen(objbuf);
+        char *name_expand =3D malloc(name_expand_size);
         check_malloc_return(name_expand);
         snprintf(name_expand, name_expand_size, "X509_%d_%s", cert_depth, =
objbuf);
         string_mod(name_expand, CC_PRINT, CC_CRLF, '_');

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1596?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991
Gerrit-Change-Number: 1596
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/cIea8iUzc8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1596?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">OpenSSL 4.0: Make X509 objects const<br><br>In O=
penSSL 4.0 a lot of the APIs have changed to return const objects.<br>Adjus=
t our source code to use const objects as well.<br><br>Change-Id: Iea1d13c1=
60599f134587c6f1c2f4a90e7f5e3991<br>Signed-off-by: Arne Schwabe &lt;arne@...1186...=
.1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1596<br>Message-Id: &lt;202=
60402121049.41102-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg36437.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>M=
 src/openvpn/ssl_verify_openssl.c<br>2 files changed, 39 insertions(+), 29 =
deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span=
><br><span>index a26663a..fd05f43 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><sp=
an>@@ -1789,7 +1789,6 @@</span><br><span>     STACK_OF(X509_NAME) *cert_nam=
es =3D NULL;</span><br><span>     X509_LOOKUP *lookup =3D NULL;</span><br><=
span>     X509_STORE *store =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    X509_NAME *xn =3D NULL;</span><br><span>     BIO *in =
=3D NULL;</span><br><span>     int i, added =3D 0, prev =3D 0;</span><br><s=
pan> </span><br><span>@@ -1853,21 +1852,26 @@</span><br><span>             =
            }</span><br><span>                     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    xn =3D=
 X509_get_subject_name(info-&gt;x509);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    /* OpenSSL 4.0 has made X509_get_sub=
ject_name return const</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     * but not adjusted the other functions to take cons=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   * arguments, and other libraries do not have const</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     * arguments, so just=
 ignore const here */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    X509_NAME *xn =3D (X509_NAME *)X509_get_subject_name(=
info-&gt;x509);</span><br><span>                     if (!xn)</span><br><sp=
an>                     {</span><br><span>                         continue=
;</span><br><span>                     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>                   =
  /* Don&#39;t add duplicate CA names */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    if (sk_X509_NAME_find(cert_names, xn=
) =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             if (sk_X509_NAME_find(cert_names, (X509_NAME *)xn) =3D=3D -1)<=
/span><br><span>                     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        xn =3D X509_NAME_dup(xn);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        if (!x=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       X509_NAME *xn_dup =3D X509_NAME_dup(xn);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        if (!xn_dup)</span><br>=
<span>                         {</span><br><span>                          =
   continue;</span><br><span>                         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        sk_X509_NAME_push=
(cert_names, xn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      sk_X509_NAME_push(cert_names, xn_dup);</span><br><spa=
n>                     }</span><br><span>                 }</span><br><span=
> </span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/open=
vpn/ssl_verify_openssl.c</span><br><span>index c70022f..96ca1a4 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_openssl.c</span><br><span>@@ -191,7 +191,7 @@</span><b=
r><span>  * to contain result is grounds for error).</span><br><span>  */</=
span><br><span> static result_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-extract_x509_field_ssl(X509_NAME *x509, const char *field_name, c=
har *out, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+extract_x509_field_ssl(const X509_NAME *x509, const char *field_name, ch=
ar *out, size_t size)</span><br><span> {</span><br><span>     int lastpos =
=3D -1;</span><br><span>     int tmp =3D -1;</span><br><span>@@ -209,7 +209=
,12 @@</span><br><span>     do</span><br><span>     {</span><br><span>     =
    lastpos =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span>         tm=
p =3D X509_NAME_get_index_by_OBJ(x509, field_name_obj, lastpos);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* OpenSSL 1.1.x has the argument as=
 non-const */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tmp =3D X509_NAME_get_index_by_OBJ((X509_NAME *)x509, field_name_obj, las=
tpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span>     } while (tmp &gt; -1);</span><br><span> </span><br><span>   =
  ASN1_OBJECT_free(field_name_obj);</span><br><span>@@ -269,7 +274,7 @@</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        X509_NAME *x509_subj=
ect_name =3D X509_get_subject_name(peer_cert);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const X509_NAME *x509_subject_name =3D X=
509_get_subject_name(peer_cert);</span><br><span>         if (x509_subject_=
name =3D=3D NULL)</span><br><span>         {</span><br><span>             m=
sg(D_TLS_ERRORS, &quot;X509 subject name is NULL&quot;);</span><br><span>@@=
 -457,7 +462,12 @@</span><br><span> x509_setenv_track(const struct x509_tra=
ck *xt, struct env_set *es, const int depth, X509 *x509)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x300000=
00L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OpenSSL 1=
.1.x APIs all take non-const arguments */</span><br><span>     X509_NAME *x=
509_name =3D X509_get_subject_name(x509);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const X509_NAME *x509_name =3D X509_get_subject_name(x509);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
     const char nullc =3D &#39;\0&#39;;</span><br><span> </span><br><span> =
    while (xt)</span><br><span>@@ -491,10 +501,10 @@</span><br><span>      =
               int i =3D X509_NAME_get_index_by_NID(x509_name, xt-&gt;nid, =
-1);</span><br><span>                     if (i &gt;=3D 0)</span><br><span>=
                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_=
name, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              const X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509_name,=
 i);</span><br><span>                         if (ent)</span><br><span>    =
                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                            ASN1_STRING *val =3D X509_NAME_ENTRY_get_data(=
ent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
              const ASN1_STRING *val =3D X509_NAME_ENTRY_get_data(ent);</sp=
an><br><span>                             unsigned char *buf =3D NULL;</spa=
n><br><span>                             if (ASN1_STRING_to_UTF8(&amp;buf, =
val) &gt;=3D 0)</span><br><span>                             {</span><br><s=
pan>@@ -508,7 +518,11 @@</span><br><span>                         i =3D X50=
9_get_ext_by_NID(x509, xt-&gt;nid, -1);</span><br><span>                   =
      if (i &gt;=3D 0)</span><br><span>                         {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &l=
t; 0x40000000L</span><br><span>                             X509_EXTENSION =
*ext =3D X509_get_ext(x509, i);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          const X509_EXTENSION *ext =3D X509_get_ext(x509, =
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span>                             if (ext)</span><br><span>              =
               {</span><br><span>                                 BIO *bio =
=3D BIO_new(BIO_s_mem());</span><br><span>@@ -544,51 +558,43 @@</span><br><=
span> void</span><br><span> x509_setenv(struct env_set *es, int cert_depth,=
 openvpn_x509_cert_t *peer_cert)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i, n;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int fn_nid;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASN1_OBJECT *fn;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASN1_STRING *val;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    X509_NAME_ENTRY *ent;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const char *objbuf;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    unsigned char *buf =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    char *name_expand;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    size_t name_expand_size;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME *x509 =3D X509_get_=
subject_name(peer_cert);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const X509_NAME *x509 =3D X509_get_subject_name(peer_cert);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    n =3D =
X509_NAME_entry_count(x509);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int n =3D X509_NAME_entry_count(x509);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; =
++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ent =3D X509_NAME_get_entry(x509, i);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const X509_NAME_ENTRY *ent =3D X5=
09_NAME_get_entry(x509, i);</span><br><span>         if (!ent)</span><br><s=
pan>         {</span><br><span>             continue;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fn =3D X=
509_NAME_ENTRY_get_object(ent);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const ASN1_OBJECT *fn =3D X509_NAME_ENTRY_get_object(en=
t);</span><br><span>         if (!fn)</span><br><span>         {</span><br>=
<span>             continue;</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        val =3D X509_NAME_ENTRY_get_data(=
ent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
ASN1_STRING *val =3D X509_NAME_ENTRY_get_data(ent);</span><br><span>       =
  if (!val)</span><br><span>         {</span><br><span>             continu=
e;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        fn_nid =3D OBJ_obj2nid(fn);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        int fn_nid =3D OBJ_obj2nid(fn);</span><br><=
span>         if (fn_nid =3D=3D NID_undef)</span><br><span>         {</span=
><br><span>             continue;</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        objbuf =3D OBJ_nid2sn(fn_nid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const cha=
r *objbuf =3D OBJ_nid2sn(fn_nid);</span><br><span>         if (!objbuf)</sp=
an><br><span>         {</span><br><span>             continue;</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   unsigned char *buf =3D NULL;</span><br><span>         if (ASN1_STRING_to=
_UTF8(&amp;buf, val) &lt; 0)</span><br><span>         {</span><br><span>   =
          continue;</span><br><span>         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        name_expand_size =3D 64 + strlen(objbuf);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name_expand =
=3D (char *)malloc(name_expand_size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        size_t name_expand_size =3D 64 + strlen(objbuf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *name_e=
xpand =3D malloc(name_expand_size);</span><br><span>         check_malloc_r=
eturn(name_expand);</span><br><span>         snprintf(name_expand, name_exp=
and_size, &quot;X509_%d_%s&quot;, cert_depth, objbuf);</span><br><span>    =
     string_mod(name_expand, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1596?usp=3Demail">change 1596</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1596?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1d13c160599f134587c6f1c2f=
4a90e7f5e3991 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1596 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/cIea8iUzc8=--

