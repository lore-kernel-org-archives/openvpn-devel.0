From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 16 Jan 2024 11:13:12 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c179cac81c63ad6ba0aff8017500c4f63a005889-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nX+Cg46sYM4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement the
 --tls-export-cert feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nX+Cg46sYM4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#13) to the change originally created b=
y plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Implement the --tls-export-cert feature
......................................................................

Implement the --tls-export-cert feature

This is a re-implementation of the --tls-export-cert feature. This
was necessary to due to missing approval to re-license the old
(now removed) code. The re-implementation is based on the following
description of the feature provided by David:

  Add an option to export certificate in PEM format of the remote
  peer to a given directory.

  For example: --tls-export-cert /var/tmp

  This option should use a randomised filename, which is provided via a
  "peer_cert" environment variable for the --tls-verify script or the
  OPENVPN_PLUGIN_TLS_VERIFY plug-in hook.

Once the script or plugin call has completed, OpenVPN should delete
this file.

Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240116101556.2257-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
014.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/script-options.rst
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
9 files changed, 145 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/466/13

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 6f90e14..e05100a 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -423,6 +423,14 @@
   See the `Environmental Variables`_ section below for additional
   parameters passed as environmental variables.

+--tls-export-cert dir
+  Adds an environment variable ``peer_cert`` when calling the
+  ``--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin
+  hook to verify the certificate.
+
+  The environment variable contains the path to a PEM encoded certificate
+  of the current peer certificate in the directory ``dir``.
+
 --up cmd
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
@@ -633,6 +641,7 @@
     Name of first ``--config`` file. Set on program initiation and reset on
     SIGHUP.

+
 :code:`daemon`
     Set to "1" if the ``--daemon`` directive is specified, or "0" otherwis=
e.
     Set on program initiation and reset on SIGHUP.
@@ -763,6 +772,11 @@
     modifier is specified, and deleted from the environment after the scri=
pt
     returns.

+:code:`peer_cert`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format.
+    See also the argument certificate_depth to the ``--tls-verify`` comman=
d.
+
 :code:`proto`
     The ``--proto`` parameter. Set on program initiation and reset on
     SIGHUP.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..c5cc154 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3336,6 +3336,7 @@
     to.auth_user_pass_verify_script_via_file =3D options->auth_user_pass_v=
erify_script_via_file;
     to.client_crresponse_script =3D options->client_crresponse_script;
     to.tmp_dir =3D options->tmp_dir;
+    to.export_peer_cert_dir =3D options->tls_export_peer_cert_dir;
     if (options->ccd_exclusive)
     {
         to.client_config_dir_exclusive =3D options->client_config_dir;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f54f276..6975cbe 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1995,6 +1995,7 @@
     SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
+    SHOW_STR(tls_export_peer_cert_dir);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
     SHOW_STR_INLINE(crl_file);
@@ -3062,6 +3063,7 @@
         MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
+        MUST_BE_UNDEF(tls_export_peer_cert_dir);
         MUST_BE_UNDEF(verify_x509_name);
         MUST_BE_UNDEF(tls_timeout);
         MUST_BE_UNDEF(renegotiate_bytes);
@@ -4092,6 +4094,13 @@
                                                 R_OK, "--crl-verify");
     }

+    if (options->tls_export_peer_cert_dir)
+    {
+        errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FIL=
E,
+                                         options->tls_export_peer_cert_dir,
+                                         W_OK, "--tls-export-cert");
+    }
+
     ASSERT(options->connection_list);
     for (int i =3D 0; i < options->connection_list->len; ++i)
     {
@@ -9041,6 +9050,11 @@
                         string_substitute(p[1], ',', ' ', &options->gc),
                         "tls-verify", true);
     }
+    else if (streq(p[0], "tls-export-cert") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        options->tls_export_peer_cert_dir =3D p[1];
+    }
     else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cbfff18..85de887 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -592,6 +592,7 @@
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
+    const char *tls_export_peer_cert_dir;
     int verify_x509_type;
     const char *verify_x509_name;
     const char *crl_file;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 925660b..f085e0d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -374,6 +374,7 @@
     const char *client_crresponse_script;
     bool auth_user_pass_verify_script_via_file;
     const char *tmp_dir;
+    const char *export_peer_cert_dir;
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index bd7e512..75a4b2e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -31,6 +31,7 @@
 #endif

 #include "syshead.h"
+#include <string.h>

 #include "base64.h"
 #include "manage.h"
@@ -457,6 +458,30 @@
     gc_free(&gc);
 }

+/**
+ * Exports the certificate in \c peer_cert into the environment and adds
+ * the filname
+ */
+static bool
+verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_=
cert,
+                            const char *pem_export_fname)
+{
+    /* export the path to the current certificate in pem file format */
+    setenv_str(es, "peer_cert", pem_export_fname);
+
+    return backend_x509_write_pem(peer_cert, pem_export_fname) =3D=3D SUCC=
ESS;
+}
+
+static void
+verify_cert_cert_delete_env(struct env_set *es, const char *pem_export_fna=
me)
+{
+    env_set_del(es, "peer_cert");
+    if (pem_export_fname)
+    {
+        unlink(pem_export_fname);
+    }
+}
+
 /*
  * call --tls-verify plug-in(s)
  */
@@ -572,18 +597,19 @@
 result_t
 verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int ce=
rt_depth)
 {
+    /* need to define these variables here so goto cleanup will always have
+     * them defined */
     result_t ret =3D FAILURE;
-    char *subject =3D NULL;
-    const struct tls_options *opt;
     struct gc_arena gc =3D gc_new();
+    const char *pem_export_fname =3D NULL;

-    opt =3D session->opt;
+    const struct tls_options *opt =3D session->opt;
     ASSERT(opt);

     session->verified =3D false;

     /* get the X509 name */
-    subject =3D x509_get_subject(cert, &gc);
+    char *subject =3D x509_get_subject(cert, &gc);
     if (!subject)
     {
         msg(D_TLS_ERRORS, "VERIFY ERROR: depth=3D%d, could not extract X50=
9 "
@@ -706,6 +732,19 @@

     session->verify_maxlevel =3D max_int(session->verify_maxlevel, cert_de=
pth);

+    if (opt->export_peer_cert_dir)
+    {
+        pem_export_fname =3D platform_create_temp_file(opt->export_peer_ce=
rt_dir,
+                                                     "pef", &gc);
+
+        if (!pem_export_fname
+            || !verify_cert_cert_export_env(opt->es, cert, pem_export_fnam=
e))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: Failed to export certificate for=
 "
+                "--tls-export-cert in %s", opt->export_peer_cert_dir);
+            goto cleanup;
+        }
+    }
     /* export certificate values to the environment */
     verify_cert_set_env(opt->es, cert, cert_depth, subject, common_name,
                         opt->x509_track);
@@ -757,12 +796,13 @@
     ret =3D SUCCESS;
=20
 cleanup:
-
+    verify_cert_cert_delete_env(opt->es, pem_export_fname);
     if (ret !=3D SUCCESS)
     {
         tls_clear_error(); /* always? */
         session->verified =3D false; /* double sure? */
     }
+
     gc_free(&gc);

     return ret;
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index d402b1f..5301a51 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -161,6 +161,17 @@
                                   struct gc_arena *gc);

 /*
+ * Write the certificate to the file in PEM format.
+ *
+ *
+ * @param cert          Certificate to serialise.
+ *
+ * @return              \c FAILURE, \c or SUCCESS
+ */
+result_t backend_x509_write_pem(openvpn_x509_cert_t *cert,
+                                const char *filename);
+
+/*
  * Save X509 fields to environment, using the naming convention:
  *
  * X509_{cert_depth}_{name}=3D{value}
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 5612139..24a89c3 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -218,6 +218,41 @@
     return buf;
 }

+result_t
+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)
+{
+    /* mbed TLS does not make it easy to write a certificate in PEM format.
+     * The only way is to directly access the DER encoded raw certificate
+     * and PEM encode it ourselves */
+
+    struct gc_arena gc =3D gc_new();
+    /* just do a very loose upper bound for the base64 based PEM encoding
+     * using 3 times the space for the base64 and 100 bytes for the
+     * headers and footer */
+    struct buffer pem =3D alloc_buf_gc(cert->raw.len * 3 + 100, &gc);
+
+    struct buffer der =3D {};
+    buf_set_read(&der, cert->raw.p, cert->raw.len);
+
+    if (!crypto_pem_encode("CERTIFICATE", &pem,  &der, &gc))
+    {
+        goto err;
+    }
+
+    if (!buffer_write_file(filename, &pem))
+    {
+        goto err;
+    }
+
+    gc_free(&gc);
+    return SUCCESS;
+err:
+    msg(D_TLS_DEBUG_LOW, "Error writing X509 certificate to file %s",
+        filename);
+    gc_free(&gc);
+    return FAILURE;
+}
+
 static struct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *c=
ert,
                      struct gc_arena *gc)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 5afffc1..00fdec3 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -320,6 +320,29 @@
     return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
 }

+result_t
+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)
+{
+    BIO *out =3D BIO_new_file(filename, "w");
+    if (!out)
+    {
+        goto err;
+    }
+
+    if (!PEM_write_bio_X509(out, cert))
+    {
+        goto err;
+    }
+    BIO_free(out);
+
+    return SUCCESS;
+err:
+    BIO_free(out);
+    crypto_msg(D_TLS_DEBUG_LOW, "Error writing X509 certificate to file %s=
",
+               filename);
+    return FAILURE;
+}
+
 struct buffer
 x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Gerrit-Change-Number: 466
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--nX+Cg46sYM4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #13</strong> to the change originally c=
reated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/466?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Implement the --tls-export-cert feature<br><br>This =
is a re-implementation of the --tls-export-cert feature. This<br>was necess=
ary to due to missing approval to re-license the old<br>(now removed) code.=
 The re-implementation is based on the following<br>description of the feat=
ure provided by David:<br><br>  Add an option to export certificate in PEM =
format of the remote<br>  peer to a given directory.<br><br>  For example: =
--tls-export-cert /var/tmp<br><br>  This option should use a randomised fil=
ename, which is provided via a<br>  &quot;peer_cert&quot; environment varia=
ble for the --tls-verify script or the<br>  OPENVPN_PLUGIN_TLS_VERIFY plug-=
in hook.<br><br>Once the script or plugin call has completed, OpenVPN shoul=
d delete<br>this file.<br><br>Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0=
bf19ce2<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240116101556.225=
7-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg28014.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M doc/man-sections/script-options.rst<br>M src/op=
envpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src=
/openvpn/ssl_common.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_ve=
rify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_v=
erify_openssl.c<br>9 files changed, 145 insertions(+), 5 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/466/13=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/doc/man-sections/script-options.rst b/doc/man-section=
s/script-options.rst</span><br><span>index 6f90e14..e05100a 100644</span><b=
r><span>--- a/doc/man-sections/script-options.rst</span><br><span>+++ b/doc=
/man-sections/script-options.rst</span><br><span>@@ -423,6 +423,14 @@</span=
><br><span>   See the `Environmental Variables`_ section below for addition=
al</span><br><span>   parameters passed as environmental variables.</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--tls-exp=
ort-cert dir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Adds =
an environment variable ``peer_cert`` when calling the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``--tls-verify`` script or executing t=
he OPENVPN_PLUGIN_TLS_VERIFY plugin</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  hook to verify the certificate.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  The environment variable contains the path to a PEM encoded ce=
rtificate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of the c=
urrent peer certificate in the directory ``dir``.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> --up cmd</span><br><span>  =
 Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``</=
span><br><span>   UID change).</span><br><span>@@ -633,6 +641,7 @@</span><b=
r><span>     Name of first ``--config`` file. Set on program initiation and=
 reset on</span><br><span>     SIGHUP.</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> :code:`daemon`</span=
><br><span>     Set to &quot;1&quot; if the ``--daemon`` directive is speci=
fied, or &quot;0&quot; otherwise.</span><br><span>     Set on program initi=
ation and reset on SIGHUP.</span><br><span>@@ -763,6 +772,11 @@</span><br><=
span>     modifier is specified, and deleted from the environment after the=
 script</span><br><span>     returns.</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+:code:`peer_cert`</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    If the option ``--tls-export-cert`` i=
s enabled, this option contains</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    the path to the current peer certificate to be verified in =
PEM format.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    See =
also the argument certificate_depth to the ``--tls-verify`` command.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> :code:`p=
roto`</span><br><span>     The ``--proto`` parameter. Set on program initia=
tion and reset on</span><br><span>     SIGHUP.</span><br><span>diff --git a=
/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 9e2b3845..c5=
cc154 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b=
/src/openvpn/init.c</span><br><span>@@ -3336,6 +3336,7 @@</span><br><span> =
    to.auth_user_pass_verify_script_via_file =3D options-&gt;auth_user_pass=
_verify_script_via_file;</span><br><span>     to.client_crresponse_script =
=3D options-&gt;client_crresponse_script;</span><br><span>     to.tmp_dir =
=3D options-&gt;tmp_dir;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    to.export_peer_cert_dir =3D options-&gt;tls_export_peer_cert_dir;<=
/span><br><span>     if (options-&gt;ccd_exclusive)</span><br><span>     {<=
/span><br><span>         to.client_config_dir_exclusive =3D options-&gt;cli=
ent_config_dir;</span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index f54f276..6975cbe 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -1995,6 +1995,7 @@</span><br><span>     SHOW_STR(cipher_=
list_tls13);</span><br><span>     SHOW_STR(tls_cert_profile);</span><br><sp=
an>     SHOW_STR(tls_verify);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_STR(tls_export_peer_cert_dir);</span><br><span>     SHOW=
_INT(verify_x509_type);</span><br><span>     SHOW_STR(verify_x509_name);</s=
pan><br><span>     SHOW_STR_INLINE(crl_file);</span><br><span>@@ -3062,6 +3=
063,7 @@</span><br><span>         MUST_BE_UNDEF(cipher_list_tls13);</span><=
br><span>         MUST_BE_UNDEF(tls_cert_profile);</span><br><span>        =
 MUST_BE_UNDEF(tls_verify);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        MUST_BE_UNDEF(tls_export_peer_cert_dir);</span><br><span>  =
       MUST_BE_UNDEF(verify_x509_name);</span><br><span>         MUST_BE_UN=
DEF(tls_timeout);</span><br><span>         MUST_BE_UNDEF(renegotiate_bytes)=
;</span><br><span>@@ -4092,6 +4094,13 @@</span><br><span>                  =
                               R_OK, &quot;--crl-verify&quot;);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (options-&gt;tls_export_peer_cert_dir)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        errs |=3D check_file_access_chroot(options-&g=
t;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                         options-&gt;tls_export_peer=
_cert_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                W_OK, &quot;--tls-export-cert&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(options-&g=
t;connection_list);</span><br><span>     for (int i =3D 0; i &lt; options-&=
gt;connection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>@@ =
-9041,6 +9050,11 @@</span><br><span>                         string_substit=
ute(p[1], &#39;,&#39;, &#39; &#39;, &amp;options-&gt;gc),</span><br><span> =
                        &quot;tls-verify&quot;, true);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (stre=
q(p[0], &quot;tls-export-cert&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_SCRIPT=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;tls_export_peer_cert_dir =3D p[1];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;com=
pat-names&quot;))</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn/options.h=
 b/src/openvpn/options.h</span><br><span>index cbfff18..85de887 100644</spa=
n><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/o=
ptions.h</span><br><span>@@ -592,6 +592,7 @@</span><br><span>     const cha=
r *tls_cert_profile;</span><br><span>     const char *ecdh_curve;</span><br=
><span>     const char *tls_verify;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *tls_export_peer_cert_dir;</span><br><span> =
    int verify_x509_type;</span><br><span>     const char *verify_x509_name=
;</span><br><span>     const char *crl_file;</span><br><span>diff --git a/s=
rc/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 92=
5660b..f085e0d 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span>=
<br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -374,6 +374,7 @=
@</span><br><span>     const char *client_crresponse_script;</span><br><spa=
n>     bool auth_user_pass_verify_script_via_file;</span><br><span>     con=
st char *tmp_dir;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *export_peer_cert_dir;</span><br><span>     const char *auth_u=
ser_pass_file;</span><br><span>     bool auth_user_pass_file_inline;</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/ope=
nvpn/ssl_verify.c</span><br><span>index bd7e512..75a4b2e 100644</span><br><=
span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_v=
erify.c</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #endif</span><br=
><span> </span><br><span> #include &quot;syshead.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><s=
pan> </span><br><span> #include &quot;base64.h&quot;</span><br><span> #incl=
ude &quot;manage.h&quot;</span><br><span>@@ -457,6 +458,30 @@</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Exports the certificate in \c peer_cert into =
the environment and adds</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * the filname</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+verify_cert_cert_export_=
env(struct env_set *es, openvpn_x509_cert_t *peer_cert,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            const char =
*pem_export_fname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* export the p=
ath to the current certificate in pem file format */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, &quot;peer_cert&quot;,=
 pem_export_fname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return backend_=
x509_write_pem(peer_cert, pem_export_fname) =3D=3D SUCCESS;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+verif=
y_cert_cert_delete_env(struct env_set *es, const char *pem_export_fname)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    env_set_del(es, &quot;peer_cert&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pem_expo=
rt_fname)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        unlink(pem_expor=
t_fname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
call --tls-verify plug-in(s)</span><br><span>  */</span><br><span>@@ -572,1=
8 +597,19 @@</span><br><span> result_t</span><br><span> verify_cert(struct =
tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* need=
 to define these variables here so goto cleanup will always have</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * them defined */</span><=
br><span>     result_t ret =3D FAILURE;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    char *subject =3D NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const struct tls_options *opt;</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *pem_export_fname =3D NULL;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt =3D sessio=
n-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct tls_options *opt =3D session-&gt;opt;</span><br><span>     ASSERT(o=
pt);</span><br><span> </span><br><span>     session-&gt;verified =3D false;=
</span><br><span> </span><br><span>     /* get the X509 name */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    subject =3D x509_get_subject(=
cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *subject =3D x509_get_subject(cert, &amp;gc);</span><br><span>     if =
(!subject)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS=
, &quot;VERIFY ERROR: depth=3D%d, could not extract X509 &quot;</span><br><=
span>@@ -706,6 +732,19 @@</span><br><span> </span><br><span>     session-&g=
t;verify_maxlevel =3D max_int(session-&gt;verify_maxlevel, cert_depth);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (opt-&gt;export_peer_cert_dir)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       pem_export_fname =3D platform_create_temp_file(opt-&gt;export_peer_c=
ert_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                          &quot;pef&quot;, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!pem_export_fname</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            || !verify_cert_cert_ex=
port_env(opt-&gt;es, cert, pem_export_fname))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: Failed to ex=
port certificate for &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;--tls-export-cert in %s&quot;, opt-&gt;export=
_peer_cert_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span>     /* export certificate values to the environment */</spa=
n><br><span>     verify_cert_set_env(opt-&gt;es, cert, cert_depth, subject,=
 common_name,</span><br><span>                         opt-&gt;x509_track);=
</span><br><span>@@ -757,12 +796,13 @@</span><br><span>     ret =3D SUCCESS=
;</span><br><span> </span><br><span> cleanup:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    verify_cert_cert_delete_env(opt-&gt;es, pem_export_fname);</span><=
br><span>     if (ret !=3D SUCCESS)</span><br><span>     {</span><br><span>=
         tls_clear_error(); /* always? */</span><br><span>         session-=
&gt;verified =3D false; /* double sure? */</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     gc_free=
(&amp;gc);</span><br><span> </span><br><span>     return ret;</span><br><sp=
an>diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_b=
ackend.h</span><br><span>index d402b1f..5301a51 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_backend.h</span><br><span>@@ -161,6 +161,17 @@</span><br><span>       =
                            struct gc_arena *gc);</span><br><span> </span><=
br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Writ=
e the certificate to the file in PEM format.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 cert          Certificate to serialise.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return              \c FAILURE, \c or SUCCESS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+result_t backend_x509_write_pem(openvpn_x509_cert_t *cert=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
              const char *filename);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span>  * Save X509 fields to environment, using the naming conv=
ention:</span><br><span>  *</span><br><span>  * X509_{cert_depth}_{name}=3D=
{value}</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src=
/openvpn/ssl_verify_mbedtls.c</span><br><span>index 5612139..24a89c3 100644=
</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++=
 b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -218,6 +218,41 @@</s=
pan><br><span>     return buf;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+result_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+backend_x509_write_pem(openvpn_x509_ce=
rt_t *cert, const char *filename)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* mbed TLS does not make it easy to write a certificate in PEM format.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * The only way is =
to directly access the DER encoded raw certificate</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * and PEM encode it ourselves */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* just do a very loose =
upper bound for the base64 based PEM encoding</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * using 3 times the space for the base64 and=
 100 bytes for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * headers and footer */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer pem =3D alloc_buf_gc(cert-&gt;raw.len * 3 + 100, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer der =3D {};=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&a=
mp;der, cert-&gt;raw.p, cert-&gt;raw.len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!crypto_pem_encode(&quot;CERTIFICATE&quot;, &amp;pem,  &amp;der=
, &amp;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!buffer_write_file(filename, &amp;pem))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return SUCCESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TL=
S_DEBUG_LOW, &quot;Error writing X509 certificate to file %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        filename);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static struct buffer</span=
><br><span> x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_=
x509_crt *cert,</span><br><span>                      struct gc_arena *gc)<=
/span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn=
/ssl_verify_openssl.c</span><br><span>index 5afffc1..00fdec3 100644</span><=
br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/o=
penvpn/ssl_verify_openssl.c</span><br><span>@@ -320,6 +320,29 @@</span><br>=
<span>     return format_hex_ex(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1, &=
quot;:&quot;, gc);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+result_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+backend_x509_write_pem(openvpn_x509_cert_t *cert, =
const char *filename)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO *out =3D=
 BIO_new_file(filename, &quot;w&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!out)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!PEM_write_bio_X509(out, ce=
rt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    BIO_free(out);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return SUCCESS;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    B=
IO_free(out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cr=
ypto_msg(D_TLS_DEBUG_LOW, &quot;Error writing X509 certificate to file %s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
 filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct b=
uffer</span><br><span> x509_get_sha1_fingerprint(X509 *cert, struct gc_aren=
a *gc)</span><br><span> {</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">change =
466</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nX+Cg46sYM4=--

