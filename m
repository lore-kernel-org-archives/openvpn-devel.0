From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 2 Apr 2026 11:24:25 +0000
In-Reply-To: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
References: <gerrit.1774974242000.Iea1d13c160599f134587c6f1c2f4a90e7f5e3991@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <00073bfd9e34199d719fbe988b1cc66854b9cb8b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xkczZ+mh/cU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xkczZ+mh/cU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1596?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: OpenSSL 4.0: Make X509 objects const
......................................................................

OpenSSL 4.0: Make X509 objects const

In OpenSSL 4.0 a lot of the APIs have changed to return const objects.
Adjust our source code to use const objects as well.

Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_openssl.c
2 files changed, 39 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1596/5

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
index 08946cd..c5c4acd 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991
Gerrit-Change-Number: 1596
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--xkczZ+mh/cU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1596?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">OpenSSL 4.0: Make X509 objec=
ts const<br><br>In OpenSSL 4.0 a lot of the APIs have changed to return con=
st objects.<br>Adjust our source code to use const objects as well.<br><br>=
Change-Id: Iea1d13c160599f134587c6f1c2f4a90e7f5e3991<br>Signed-off-by: Arne=
 Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_openssl.c<br>M=
 src/openvpn/ssl_verify_openssl.c<br>2 files changed, 39 insertions(+), 29 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/96/1596/5</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_op=
enssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index a26663a..fd05f43 =
100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ =
b/src/openvpn/ssl_openssl.c</span><br><span>@@ -1789,7 +1789,6 @@</span><br=
><span>     STACK_OF(X509_NAME) *cert_names =3D NULL;</span><br><span>     =
X509_LOOKUP *lookup =3D NULL;</span><br><span>     X509_STORE *store =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME *xn =
=3D NULL;</span><br><span>     BIO *in =3D NULL;</span><br><span>     int i=
, added =3D 0, prev =3D 0;</span><br><span> </span><br><span>@@ -1853,21 +1=
852,26 @@</span><br><span>                         }</span><br><span>      =
               }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    xn =3D X509_get_subject_name(info-&gt;x509=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   /* OpenSSL 4.0 has made X509_get_subject_name return const</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     * but not ad=
justed the other functions to take const</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     * arguments, and other libraries =
do not have const</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   * arguments, so just ignore const here */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    X509_NAME *xn =
=3D (X509_NAME *)X509_get_subject_name(info-&gt;x509);</span><br><span>    =
                 if (!xn)</span><br><span>                     {</span><br>=
<span>                         continue;</span><br><span>                  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>                     /* Don&#39;t add duplicate CA name=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   if (sk_X509_NAME_find(cert_names, xn) =3D=3D -1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (sk_X509_NAME_find=
(cert_names, (X509_NAME *)xn) =3D=3D -1)</span><br><span>                  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       xn =3D X509_NAME_dup(xn);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        if (!xn)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        X509_NAME *xn_dup =3D X509_=
NAME_dup(xn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  if (!xn_dup)</span><br><span>                         {</=
span><br><span>                             continue;</span><br><span>     =
                    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        sk_X509_NAME_push(cert_names, xn);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        sk_X509_NAME=
_push(cert_names, xn_dup);</span><br><span>                     }</span><br=
><span>                 }</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br=
><span>index 08946cd..c5c4acd 100644</span><br><span>--- a/src/openvpn/ssl_=
verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</sp=
an><br><span>@@ -191,7 +191,7 @@</span><br><span>  * to contain result is g=
rounds for error).</span><br><span>  */</span><br><span> static result_t</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-extract_x509_field_ssl(X=
509_NAME *x509, const char *field_name, char *out, size_t size)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+extract_x509_field_ssl(const X5=
09_NAME *x509, const char *field_name, char *out, size_t size)</span><br><s=
pan> {</span><br><span>     int lastpos =3D -1;</span><br><span>     int tm=
p =3D -1;</span><br><span>@@ -209,7 +209,12 @@</span><br><span>     do</spa=
n><br><span>     {</span><br><span>         lastpos =3D tmp;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt;=3D=
 0x30000000L</span><br><span>         tmp =3D X509_NAME_get_index_by_OBJ(x5=
09, field_name_obj, lastpos);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* OpenSSL 1.1.x has the argument as non-const */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tmp =3D X509_NAME_get_index_by_OB=
J((X509_NAME *)x509, field_name_obj, lastpos);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span>     } while (tmp &gt; -1=
);</span><br><span> </span><br><span>     ASN1_OBJECT_free(field_name_obj);=
</span><br><span>@@ -269,7 +274,7 @@</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        X509_NAME *x509_subject_name =3D X509_get_subject_name(=
peer_cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_cert);</s=
pan><br><span>         if (x509_subject_name =3D=3D NULL)</span><br><span> =
        {</span><br><span>             msg(D_TLS_ERRORS, &quot;X509 subject=
 name is NULL&quot;);</span><br><span>@@ -457,7 +462,12 @@</span><br><span>=
 x509_setenv_track(const struct x509_track *xt, struct env_set *es, const i=
nt depth, X509 *x509)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* OpenSSL 1.1.x APIs all take non-const argume=
nts */</span><br><span>     X509_NAME *x509_name =3D X509_get_subject_name(=
x509);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const X509_NAME *x509_n=
ame =3D X509_get_subject_name(x509);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span>     const char nullc =3D &#39;\0&#=
39;;</span><br><span> </span><br><span>     while (xt)</span><br><span>@@ -=
491,10 +501,10 @@</span><br><span>                     int i =3D X509_NAME_=
get_index_by_NID(x509_name, xt-&gt;nid, -1);</span><br><span>              =
       if (i &gt;=3D 0)</span><br><span>                     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        X509_NAME_=
ENTRY *ent =3D X509_NAME_get_entry(x509_name, i);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        const X509_NAME_ENTRY=
 *ent =3D X509_NAME_get_entry(x509_name, i);</span><br><span>              =
           if (ent)</span><br><span>                         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                            ASN1_S=
TRING *val =3D X509_NAME_ENTRY_get_data(ent);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                            const ASN1_STRING *va=
l =3D X509_NAME_ENTRY_get_data(ent);</span><br><span>                      =
       unsigned char *buf =3D NULL;</span><br><span>                       =
      if (ASN1_STRING_to_UTF8(&amp;buf, val) &gt;=3D 0)</span><br><span>   =
                          {</span><br><span>@@ -508,7 +518,11 @@</span><br>=
<span>                         i =3D X509_get_ext_by_NID(x509, xt-&gt;nid, =
-1);</span><br><span>                         if (i &gt;=3D 0)</span><br><s=
pan>                         {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x40000000L</span><br><span>    =
                         X509_EXTENSION *ext =3D X509_get_ext(x509, i);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                            const X50=
9_EXTENSION *ext =3D X509_get_ext(x509, i);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span>                            =
 if (ext)</span><br><span>                             {</span><br><span>  =
                               BIO *bio =3D BIO_new(BIO_s_mem());</span><br=
><span>@@ -544,51 +558,43 @@</span><br><span> void</span><br><span> x509_se=
tenv(struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt i, n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int fn_ni=
d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASN1_OBJECT *fn=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASN1_STRING *val=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENTRY =
*ent;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *=
objbuf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned c=
har *buf =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 char *name_expand;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  size_t name_expand_size;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    X509_NAME *x509 =3D X509_get_subject_name(peer_cert);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const X509_NAME *x509 =3D X5=
09_get_subject_name(peer_cert);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    n =3D X509_NAME_entry_count(x509);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n =3D X50=
9_NAME_entry_count(x509);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int i =3D 0; i &lt; n; ++i)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ent =3D X509_NAME_get_e=
ntry(x509, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const X509_NAME_ENTRY *ent =3D X509_NAME_get_entry(x509, i);</span><br><=
span>         if (!ent)</span><br><span>         {</span><br><span>        =
     continue;</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        fn =3D X509_NAME_ENTRY_get_object(ent);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const ASN1_OBJECT *=
fn =3D X509_NAME_ENTRY_get_object(ent);</span><br><span>         if (!fn)</=
span><br><span>         {</span><br><span>             continue;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   val =3D X509_NAME_ENTRY_get_data(ent);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const ASN1_STRING *val =3D X509_NAME_ENTRY_ge=
t_data(ent);</span><br><span>         if (!val)</span><br><span>         {<=
/span><br><span>             continue;</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        fn_nid =3D OBJ_obj2nid(=
fn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int fn_=
nid =3D OBJ_obj2nid(fn);</span><br><span>         if (fn_nid =3D=3D NID_und=
ef)</span><br><span>         {</span><br><span>             continue;</span=
><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        objbuf =3D OBJ_nid2sn(fn_nid);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const char *objbuf =3D OBJ_nid2sn(fn_nid);</span=
><br><span>         if (!objbuf)</span><br><span>         {</span><br><span=
>             continue;</span><br><span>         }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        unsigned char *buf =3D NULL;</span><=
br><span>         if (ASN1_STRING_to_UTF8(&amp;buf, val) &lt; 0)</span><br>=
<span>         {</span><br><span>             continue;</span><br><span>   =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name_e=
xpand_size =3D 64 + strlen(objbuf);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        name_expand =3D (char *)malloc(name_expand_size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t name_exp=
and_size =3D 64 + strlen(objbuf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        char *name_expand =3D malloc(name_expand_size);</span=
><br><span>         check_malloc_return(name_expand);</span><br><span>     =
    snprintf(name_expand, name_expand_size, &quot;X509_%d_%s&quot;, cert_de=
pth, objbuf);</span><br><span>         string_mod(name_expand, CC_PRINT, CC=
_CRLF, &#39;_&#39;);</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1596?usp=3Demail">change 1596=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1596?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1d13c160599f134587c6f1c2f=
4a90e7f5e3991 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1596 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--xkczZ+mh/cU=--

