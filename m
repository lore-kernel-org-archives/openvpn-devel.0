From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 16:56:18 +0000
In-Reply-To: <gerrit.1704203193000.Ic494d43c835220ae71f10e3afbe53db918887370@...2715...>
References: <gerrit.1704203193000.Ic494d43c835220ae71f10e3afbe53db918887370@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7768395139ca8a42c59c80512d6ab1ad766ef269-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="notIj/vIzzw="; charset=UTF-8
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

--notIj/vIzzw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail

to look at the new patch set (#2).


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
M doc/man-sections/script-options.rst
M src/openvpn/ssl_verify.c
2 files changed, 44 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/487/2

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index e05100a..32943d2 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -424,7 +424,8 @@
   parameters passed as environmental variables.

 --tls-export-cert dir
-  Adds an environment variable ``peer_cert`` when calling the
+  Adds an environment variable ``peer_cert_{x}`` (and an alias
+  ``peer_cert`` for the current certificate depth) when calling the
   ``--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin
   hook to verify the certificate.
=20
@@ -777,6 +778,11 @@
     the path to the current peer certificate to be verified in PEM format.
     See also the argument certificate_depth to the ``--tls-verify`` comman=
d.

+:code:`peer_cert_{n}`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format
+    where ``n`` is the verification level.
+
 :code:`proto`
     The ``--proto`` parameter. Set on program initiation and reset on
     SIGHUP.
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 55b3cf0..de0d59c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -39,6 +39,7 @@
 #include "run_command.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
+#include "platform.h"

 #ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
@@ -459,24 +460,45 @@
 }
=20
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
-                            const char *pem_export_fname)
+verify_cert_cert_export_env(const struct tls_options *opt,
+                            openvpn_x509_cert_t *peer_cert, int cert_depth)
 {
-    /* export the path to the current certificate in pem file format */
-    setenv_str(es, "peer_cert", pem_export_fname);
+    struct gc_arena gc =3D gc_new();
+    const char *pem_export_filename =3D platform_create_temp_file(opt->exp=
ort_peer_cert_dir,
+                                                                "pef", &gc=
);
+    char envstr[128];

-    return backend_x509_write_pem(peer_cert, pem_export_fname) =3D=3D SUCC=
ESS;
-}
+    /* export the path to the certificate in pem file format */
+    openvpn_snprintf(envstr, sizeof(envstr), "peer_cert_%d=3D%s", cert_dep=
th,
+                     pem_export_filename);
+    setenv_str(opt->es, envstr, pem_export_filename);
+    env_set_add_specialfree(opt->es, envstr, &unlink_file_env);

-static void
-verify_cert_cert_delete_env(struct env_set *es, const char *pem_export_fna=
me)
-{
-    env_set_del(es, "peer_cert");
-    unlink(pem_export_fname);
+    /* compatibility with older scripts/plugins that expect peer_cert with=
out
+     * suffix */
+    setenv_str(opt->es, "peer_cert", pem_export_filename);
+    return backend_x509_write_pem(peer_cert, pem_export_filename) =3D=3D S=
UCCESS;
 }

 /*
@@ -598,7 +620,6 @@
      * them defined */
     result_t ret =3D FAILURE;
     struct gc_arena gc =3D gc_new();
-    const char *pem_export_fname =3D NULL;

     const struct tls_options *opt =3D session->opt;
     ASSERT(opt);
@@ -731,11 +752,7 @@

     if (opt->export_peer_cert_dir)
     {
-        pem_export_fname =3D platform_create_temp_file(opt->export_peer_ce=
rt_dir,
-                                                     "pef", &gc);
-
-        if (!pem_export_fname
-            || !verify_cert_cert_export_env(opt->es, cert, pem_export_fnam=
e))
+        if (!verify_cert_cert_export_env(opt, cert, cert_depth))
         {
             msg(D_TLS_ERRORS, "TLS Error: Failed to export certificate for=
 "
                 "--tls-export-cert in %s", opt->export_peer_cert_dir);
@@ -793,7 +810,9 @@
     ret =3D SUCCESS;

 cleanup:
-    verify_cert_cert_delete_env(opt->es, pem_export_fname);
+    /* delete the variable for the current depth if present as it does not=
 make
+     * sense going forward in other calls of other scripts */
+    env_set_del(opt->es, "peer_cert");
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--notIj/vIzzw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Keep exported certificate files for following calls<br><br>Since the =
lifetime of environment variables is quite different, we<br>need to tie the=
 lifetime of these files to their environment variables<br>which in turn re=
quires a special function to be called on the removal<br>of these env varia=
bles.<br><br>Change-Id: Ic494d43c835220ae71f10e3afbe53db918887370<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/=
script-options.rst<br>M src/openvpn/ssl_verify.c<br>2 files changed, 44 ins=
ertions(+), 19 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/87/487/2</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/scri=
pt-options.rst b/doc/man-sections/script-options.rst</span><br><span>index =
e05100a..32943d2 100644</span><br><span>--- a/doc/man-sections/script-optio=
ns.rst</span><br><span>+++ b/doc/man-sections/script-options.rst</span><br>=
<span>@@ -424,7 +424,8 @@</span><br><span>   parameters passed as environme=
ntal variables.</span><br><span> </span><br><span> --tls-export-cert dir</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  Adds an environment va=
riable ``peer_cert`` when calling the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Adds an environment variable ``peer_cert_{x}`` (and an =
alias</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``peer_cert`=
` for the current certificate depth) when calling the</span><br><span>   ``=
--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin</sp=
an><br><span>   hook to verify the certificate.</span><br><span> </span><br=
><span>@@ -777,6 +778,11 @@</span><br><span>     the path to the current pe=
er certificate to be verified in PEM format.</span><br><span>     See also =
the argument certificate_depth to the ``--tls-verify`` command.</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`peer_c=
ert_{n}`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    If the =
option ``--tls-export-cert`` is enabled, this option contains</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    the path to the current peer =
certificate to be verified in PEM format</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    where ``n`` is the verification level.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> :code:`proto`=
</span><br><span>     The ``--proto`` parameter. Set on program initiation =
and reset on</span><br><span>     SIGHUP.</span><br><span>diff --git a/src/=
openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 55b3c=
f0..de0d59c 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br=
><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -39,6 +39,7 @@</sp=
an><br><span> #include &quot;run_command.h&quot;</span><br><span> #include =
&quot;ssl_verify.h&quot;</span><br><span> #include &quot;ssl_verify_backend=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;platform.h&quot;</span><br><span> </span><br><span> #ifdef ENABLE_CRYPT=
O_OPENSSL</span><br><span> #include &quot;ssl_verify_openssl.h&quot;</span>=
<br><span>@@ -459,24 +460,45 @@</span><br><span> }</span><br><span> </span>=
<br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Un=
links a file specified by in the env item that has the form</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * key=3Dfilename.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+unlink_file_env(struct env_item *env)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* values in env are always x=3Dy */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *filename =3D strchr(en=
v-&gt;string, &#39;=3D&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(filename);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Move just past the =3D */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    filename +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    platform=
_unlink((const char *) filename);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  *=
 Exports the certificate in \c peer_cert into the environment and adds</spa=
n><br><span>  * the filname</span><br><span>  */</span><br><span> static bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_cert_cert_ex=
port_env(struct env_set *es, openvpn_x509_cert_t *peer_cert,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                            const ch=
ar *pem_export_fname)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+verify_cert_cert_export_env(const struct tls_options *opt,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                            openvp=
n_x509_cert_t *peer_cert, int cert_depth)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* export the path to the curren=
t certificate in pem file format */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    setenv_str(es, &quot;peer_cert&quot;, pem_export_fname);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *pem_export_filename =3D platform_create_temp_file(opt-&gt;expo=
rt_peer_cert_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                              &quot;pef&quo=
t;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar envstr[128];</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return backend_x509_write_pem(peer_cert, pem_export_fname) =
=3D=3D SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* export the path t=
o the certificate in pem file format */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    openvpn_snprintf(envstr, sizeof(envstr), &quot;peer=
_cert_%d=3D%s&quot;, cert_depth,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     pem_export_filename);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    setenv_str(opt-&gt;es, envstr, pem_=
export_filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  env_set_add_specialfree(opt-&gt;es, envstr, &amp;unlink_file_env);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify_cert_cert_del=
ete_env(struct env_set *es, const char *pem_export_fname)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    env_set_del(es, &quot;peer_cert&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    unlink(pem_export_fname);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* compatibility with o=
lder scripts/plugins that expect peer_cert without</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * suffix */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    setenv_str(opt-&gt;es, &quot;peer_cert&quot=
;, pem_export_filename);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return backend_x509_write_pem(peer_cert, pem_export_filename) =3D=
=3D SUCCESS;</span><br><span> }</span><br><span> </span><br><span> /*</span=
><br><span>@@ -598,7 +620,6 @@</span><br><span>      * them defined */</spa=
n><br><span>     result_t ret =3D FAILURE;</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const char *pem_export_fname =3D NULL;</span><br><span> </span><br><spa=
n>     const struct tls_options *opt =3D session-&gt;opt;</span><br><span> =
    ASSERT(opt);</span><br><span>@@ -731,11 +752,7 @@</span><br><span> </sp=
an><br><span>     if (opt-&gt;export_peer_cert_dir)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pem_export_fna=
me =3D platform_create_temp_file(opt-&gt;export_peer_cert_dir,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
                   &quot;pef&quot;, &amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (!pem_export_fname</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            || !verify_cert_cert_export_env(opt-&gt;es, cert, pe=
m_export_fname))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!verify_cert_cert_export_env(opt, cert, cert_depth))</span><br><sp=
an>         {</span><br><span>             msg(D_TLS_ERRORS, &quot;TLS Erro=
r: Failed to export certificate for &quot;</span><br><span>                =
 &quot;--tls-export-cert in %s&quot;, opt-&gt;export_peer_cert_dir);</span>=
<br><span>@@ -793,7 +810,9 @@</span><br><span>     ret =3D SUCCESS;</span><=
br><span> </span><br><span> cleanup:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    verify_cert_cert_delete_env(opt-&gt;es, pem_export_fname=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* delete the=
 variable for the current depth if present as it does not make</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * sense going forward in ot=
her calls of other scripts */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    env_set_del(opt-&gt;es, &quot;peer_cert&quot;);</span><br><sp=
an>     if (ret !=3D SUCCESS)</span><br><span>     {</span><br><span>      =
   tls_clear_error(); /* always? */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demai=
l">change 487</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/487?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic494d43c835220ae71f10e3afbe=
53db918887370 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 487 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--notIj/vIzzw=--

