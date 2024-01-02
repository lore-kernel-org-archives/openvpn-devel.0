From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 13:46:40 +0000
References: <gerrit.1704203193000.Ic494d43c835220ae71f10e3afbe53db918887370@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <fec0381cb912c2749608d1e69054cdcf9bacf3b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NcU9hHR7P8c="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Keep exported
 certificate files for following calls
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

--NcU9hHR7P8c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail

to review the following change.


Change subject: Keep exported certificate files for following calls
......................................................................

Keep exported certificate files for following calls

Since the lifetime of environment variables is quite different, we
need to tie the lifetime of these files to their environment variables
which in turn requires a special function to be called on the removal
of these env variables.

Change-Id: Ic494d43c835220ae71f10e3afbe53db918887370
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify.c
1 file changed, 31 insertions(+), 37 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/487/1

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 35d3377..ff1a932 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -39,6 +39,7 @@
 #include "run_command.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
+#include "platform.h"

 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
@@ -459,53 +460,51 @@
 }

 /**
+ * Unlinks a file specified by in the env item that has the form
+ * key=3Dfilename.
+ */
+static void
+unlink_file_env(struct env_item *env)
+{
+    /* values in env are always x=3Dy */
+    const char *filename =3D strchr(env->string, '=3D');
+    ASSERT(filename);
+
+    /* Move just past the =3D */
+    filename +=3D 1;
+
+    platform_unlink((const char *) filename);
+}
+
+/**
  * Exports the certificate in \c peer_cert into the environment and adds
  * the filname
  */
 static bool
-verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_=
cert,
-                            int cert_depth, const char *pem_export_fname)
+verify_cert_cert_export_env(const struct tls_options *opt,
+                            openvpn_x509_cert_t *peer_cert, int cert_depth)
 {
-    char envname[64];
-    /* Make copy of the filename to manage that copy by the gc_arena */
-    char *pem_export_filename =3D strdup(pem_export_fname);
-
-    if (!pem_export_filename)
-    {
-        return false;
-    }
+    struct gc_arena gc =3D gc_new();
+    const char *pem_export_filename =3D platform_create_temp_file(opt->exp=
ort_peer_cert_dir,
+                                                                "pef", &gc=
);
+    char envstr[128];

     /* export the path to the certificate in pem file format */
-    openvpn_snprintf(envname, sizeof(envname), "peer_cert_%d", cert_depth);
-    setenv_str(es, envname, pem_export_filename);
+    openvpn_snprintf(envstr, sizeof(envstr), "peer_cert_%d=3D%s", cert_dep=
th,
+                     pem_export_filename);
+    setenv_str(opt->es, envstr, pem_export_filename);
+    env_set_add_specialfree(opt->es, envstr, &unlink_file_env);

     /* compatibility with older scripts/plugins that expect peer_cert with=
out
      * suffix */
     if (cert_depth =3D=3D 0)
     {
-        setenv_str(es, "peer_cert", pem_export_filename);
+        setenv_str(opt->es, "peer_cert", pem_export_filename);
     }

     return backend_x509_write_pem(peer_cert, pem_export_filename) =3D=3D S=
UCCESS;
 }

-static void
-verify_cert_cert_delete_env(struct env_set *es, int cert_depth,
-                            const char *pem_export_fname)
-{
-    char envname[64];
-    openvpn_snprintf(envname, sizeof(envname), "peer_cert_%d", cert_depth);
-    env_set_del(es, envname);
-
-    /* compatibility with older scripts/plugins that expect peer_cert with=
out
-     * suffix */
-    if (cert_depth =3D=3D 0)
-    {
-        env_set_del(es, "peer_cert");
-    }
-    unlink(pem_export_fname);
-}
-
 /*
  * call --tls-verify plug-in(s)
  */
@@ -625,7 +624,6 @@
      * them defined */
     result_t ret =3D FAILURE;
     struct gc_arena gc =3D gc_new();
-    const char *pem_export_fname =3D NULL;

     const struct tls_options *opt =3D session->opt;
     ASSERT(opt);
@@ -758,12 +756,9 @@

     if (opt->export_peer_cert_dir)
     {
-        pem_export_fname =3D platform_create_temp_file(opt->export_peer_ce=
rt_dir,
-                                                     "pef", &gc);

-        if (!pem_export_fname
-            || !verify_cert_cert_export_env(opt->es, cert, cert_depth,
-                                            pem_export_fname))
+
+        if (!verify_cert_cert_export_env(opt, cert, cert_depth))
         {
             msg(D_TLS_ERRORS, "TLS Error: Failed to export certificate for=
 "
                 "--tls-export-cert in %s", opt->export_peer_cert_dir);
@@ -821,7 +816,6 @@
     ret =3D SUCCESS;

 cleanup:
-    verify_cert_cert_delete_env(opt->es, cert_depth, pem_export_fname);
     if (ret !=3D SUCCESS)
     {
         tls_clear_error(); /* always? */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic494d43c835220ae71f10e3afbe53db918887370
Gerrit-Change-Number: 487
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--NcU9hHR7P8c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Keep exported certificate files for following calls<br><br>Si=
nce the lifetime of environment variables is quite different, we<br>need to=
 tie the lifetime of these files to their environment variables<br>which in=
 turn requires a special function to be called on the removal<br>of these e=
nv variables.<br><br>Change-Id: Ic494d43c835220ae71f10e3afbe53db918887370<b=
r>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openv=
pn/ssl_verify.c<br>1 file changed, 31 insertions(+), 37 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/487/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</sp=
an><br><span>index 35d3377..ff1a932 100644</span><br><span>--- a/src/openvp=
n/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><sp=
an>@@ -39,6 +39,7 @@</span><br><span> #include &quot;run_command.h&quot;</s=
pan><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #include =
&quot;ssl_verify_backend.h&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;platform.h&quot;</span><br><span> </span><br><s=
pan> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span> #include &quot;ssl_verif=
y_openssl.h&quot;</span><br><span>@@ -459,53 +460,51 @@</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Unlinks a file specified by in the env item that has =
the form</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * key=3Dfi=
lename.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+unlink_file_env(struct env_item *env=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* values in env are always x=3D=
y */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*filename =3D strchr(env-&gt;string, &#39;=3D&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(filename);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Move just past the =3D */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    filename +=3D 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    platform_unlink((const char *) filename);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span>  * Exports the certificate in \c peer_cert into the e=
nvironment and adds</span><br><span>  * the filname</span><br><span>  */</s=
pan><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *p=
eer_cert,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                int cert_depth, const char *pem_export_fname)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+verify_cert_cert_export_env(const=
 struct tls_options *opt,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            openvpn_x509_cert_t *peer_cert, int cert_=
depth)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    char envname[64];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* Make copy of the filename to manage that copy by the gc_arena */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *pem_export_=
filename =3D strdup(pem_export_fname);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!pem_export_filename)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *pem_export_filename =3D platform_create_temp_file(opt-&gt;export_pee=
r_cert_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                                        &quot;pef&quot;, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char env=
str[128];</span><br><span> </span><br><span>     /* export the path to the =
certificate in pem file format */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    openvpn_snprintf(envname, sizeof(envname), &quot;peer_cert_=
%d&quot;, cert_depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    setenv_str(es, envname, pem_export_filename);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(envstr, sizeof(envstr),=
 &quot;peer_cert_%d=3D%s&quot;, cert_depth,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     pem_export_filename);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(opt-&gt;es, e=
nvstr, pem_export_filename);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    env_set_add_specialfree(opt-&gt;es, envstr, &amp;unlink_file_e=
nv);</span><br><span> </span><br><span>     /* compatibility with older scr=
ipts/plugins that expect peer_cert without</span><br><span>      * suffix *=
/</span><br><span>     if (cert_depth =3D=3D 0)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_str(es, &qu=
ot;peer_cert&quot;, pem_export_filename);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        setenv_str(opt-&gt;es, &quot;peer_cert&quot;,=
 pem_export_filename);</span><br><span>     }</span><br><span> </span><br><=
span>     return backend_x509_write_pem(peer_cert, pem_export_filename) =3D=
=3D SUCCESS;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-verify_cert_cert_delete_env(struct env_set *es, int cert_=
depth,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
             const char *pem_export_fname)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    char envname[64];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    openvpn_snprintf(envname, sizeof(envname), &quot;peer_cert_%d&quot;, c=
ert_depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    env_se=
t_del(es, envname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* compatibility wi=
th older scripts/plugins that expect peer_cert without</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * suffix */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (cert_depth =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        env_set_del(es, &quot;peer_cert&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unlink(pem_export_fname);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * call --tls-verify=
 plug-in(s)</span><br><span>  */</span><br><span>@@ -625,7 +624,6 @@</span>=
<br><span>      * them defined */</span><br><span>     result_t ret =3D FAI=
LURE;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const char *pem_export_fname =3D =
NULL;</span><br><span> </span><br><span>     const struct tls_options *opt =
=3D session-&gt;opt;</span><br><span>     ASSERT(opt);</span><br><span>@@ -=
758,12 +756,9 @@</span><br><span> </span><br><span>     if (opt-&gt;export_=
peer_cert_dir)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        pem_export_fname =3D platform_create_temp_file(opt-=
&gt;export_peer_cert_dir,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                                     &quot;pef&quot;, &=
amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (!pem_export_fname</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            || !verify_cert_cert_export_env(opt-&gt;es, cert, =
cert_depth,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                                  pem_export_fname))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!verify_cert_cert_export_env(opt, cert, cert_dep=
th))</span><br><span>         {</span><br><span>             msg(D_TLS_ERRO=
RS, &quot;TLS Error: Failed to export certificate for &quot;</span><br><spa=
n>                 &quot;--tls-export-cert in %s&quot;, opt-&gt;export_peer=
_cert_dir);</span><br><span>@@ -821,7 +816,6 @@</span><br><span>     ret =
=3D SUCCESS;</span><br><span> </span><br><span> cleanup:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    verify_cert_cert_delete_env(opt-&gt;=
es, cert_depth, pem_export_fname);</span><br><span>     if (ret !=3D SUCCES=
S)</span><br><span>     {</span><br><span>         tls_clear_error(); /* al=
ways? */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail">change 487</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/487?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic494d43c835220ae71f10e3afbe=
53db918887370 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 487 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--NcU9hHR7P8c=--

