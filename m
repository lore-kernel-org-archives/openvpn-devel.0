From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 18:24:04 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <d8bbeefe978c6468647b15d7c3ba262b43424faa-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NTr5rnxQ9oI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NTr5rnxQ9oI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
9 files changed, 151 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/466/5

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 38dcfa2..ba700a0 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -423,6 +423,15 @@
   See the `Environmental Variables`_ section below for additional
   parameters passed as environmental variables.

+--tls-export-cert-path dir
+  Adds an environment variable ``peer_cert_{x}`` (and an alias
+  ``peer_cert`` for ``peer_cert_0`` for compatibility)  when calling the
+  ``--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin
+  hook to verify the certificate.
+
+  The environment variable contains the path to a PEM encoded certificate
+  of the current peer certificate in the directory ``dir``.
+
 --up cmd
   Run command ``cmd`` after successful TUN/TAP device open (pre ``--user``
   UID change).
@@ -763,6 +772,15 @@
     modifier is specified, and deleted from the environment after the scri=
pt
     returns.

+:code:`peer_cert_{n}`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format
+    where ``n`` is the verification level.
+
+:code:`peer_cert`
+    Identical to `peer_cert_0` for compatibility with older
+    versions.
+
 :code:`proto`
     The ``--proto`` parameter. Set on program initiation and reset on
     SIGHUP.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9e2b3845..917ae33 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3336,6 +3336,7 @@
     to.auth_user_pass_verify_script_via_file =3D options->auth_user_pass_v=
erify_script_via_file;
     to.client_crresponse_script =3D options->client_crresponse_script;
     to.tmp_dir =3D options->tmp_dir;
+    to.export_peer_cert_dir =3D options->tls_export_peer_cert_path;
     if (options->ccd_exclusive)
     {
         to.client_config_dir_exclusive =3D options->client_config_dir;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1521872..503e832 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1986,6 +1986,7 @@
     SHOW_STR(cipher_list_tls13);
     SHOW_STR(tls_cert_profile);
     SHOW_STR(tls_verify);
+    SHOW_STR(tls_export_peer_cert_path);
     SHOW_INT(verify_x509_type);
     SHOW_STR(verify_x509_name);
     SHOW_STR_INLINE(crl_file);
@@ -3048,6 +3049,7 @@
         MUST_BE_UNDEF(cipher_list_tls13);
         MUST_BE_UNDEF(tls_cert_profile);
         MUST_BE_UNDEF(tls_verify);
+        MUST_BE_UNDEF(tls_export_peer_cert_path);
         MUST_BE_UNDEF(verify_x509_name);
         MUST_BE_UNDEF(tls_timeout);
         MUST_BE_UNDEF(renegotiate_bytes);
@@ -4053,6 +4055,13 @@
                                                 R_OK, "--crl-verify");
     }
=20
+    if (options->tls_export_peer_cert_path)
+    {
+        errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FIL=
E,
+                                         options->tls_export_peer_cert_pat=
h,
+                                         W_OK, "--tls-export-cert");
+    }
+
     ASSERT(options->connection_list);
     for (int i =3D 0; i < options->connection_list->len; ++i)
     {
@@ -8998,6 +9007,11 @@
                         string_substitute(p[1], ',', ' ', &options->gc),
                         "tls-verify", true);
     }
+    else if (streq(p[0], "tls-export-cert") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_SCRIPT);
+        options->tls_export_peer_cert_path =3D p[1];
+    }
     else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c4514e1..3b9a7f6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -592,6 +592,7 @@
     const char *tls_cert_profile;
     const char *ecdh_curve;
     const char *tls_verify;
+    const char *tls_export_peer_cert_path;
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
index bd7e512..5cf518e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -457,6 +457,30 @@
     gc_free(&gc);
 }

+static bool
+verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_=
cert,
+                            int cert_depth, const char *pem_export_fn)
+{
+    char envname[64];
+    struct gc_arena gc =3D gc_new();
+    /* export the path to the certificate in pem file format */
+    openvpn_snprintf(envname, sizeof(envname), "peer_cert_%d", cert_depth);
+    setenv_str(es, envname, pem_export_fn);
+
+    /* compatibility with older scripts/plugins that expect peer_cert with=
out
+     * suffix */
+    if (cert_depth =3D=3D 0)
+    {
+        setenv_str(es, "peer_cert", pem_export_fn);
+    }
+
+    bool ret =3D (backend_x509_write_pem(peer_cert, pem_export_fn) =3D=3D =
SUCCESS);
+
+    gc_free(&gc);
+    return ret;
+}
+
+
 /*
  * call --tls-verify plug-in(s)
  */
@@ -572,18 +596,19 @@
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
+    const char *pem_export_fn =3D NULL;

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
@@ -706,6 +731,19 @@

     session->verify_maxlevel =3D max_int(session->verify_maxlevel, cert_de=
pth);

+    if (opt->export_peer_cert_dir)
+    {
+        pem_export_fn =3D platform_create_temp_file(opt->export_peer_cert_=
dir,
+                                                  "pef", &gc);
+
+        if (!pem_export_fn
+            || !verify_cert_cert_export_env(opt->es, cert, cert_depth, pem=
_export_fn))
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
@@ -763,6 +801,11 @@
         tls_clear_error(); /* always? */
         session->verified =3D false; /* double sure? */
     }
+    if (pem_export_fn)
+    {
+        platform_unlink(pem_export_fn);
+    }
+
     gc_free(&gc);
=20
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--NTr5rnxQ9oI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement the --tls-export-cert feature<br><b=
r>This is a re-implementation of the --tls-export-cert feature. This<br>was=
 necessary to due to missing approval to re-license the old<br>(now removed=
) code. The re-implementation is based on the following<br>description of t=
he feature provided by David:<br><br>  Add an option to export certificate =
in PEM format of the remote<br>  peer to a given directory.<br><br>  For ex=
ample: --tls-export-cert /var/tmp<br><br>  This option should use a randomi=
sed filename, which is provided via a<br>  &quot;peer_cert&quot; environmen=
t variable for the --tls-verify script or the<br>  OPENVPN_PLUGIN_TLS_VERIF=
Y plug-in hook.<br><br>Once the script or plugin call has completed, OpenVP=
N should delete<br>this file.<br><br>Change-Id: Ia9b3f1813d2d0d492d17c87348=
b4cebd0bf19ce2<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>--=
-<br>M doc/man-sections/script-options.rst<br>M src/openvpn/init.c<br>M src=
/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/ssl_common.h=
<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify_backend.h<br>M s=
rc/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_openssl.c<br>9 =
files changed, 151 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/66/466/5</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst</=
span><br><span>index 38dcfa2..ba700a0 100644</span><br><span>--- a/doc/man-=
sections/script-options.rst</span><br><span>+++ b/doc/man-sections/script-o=
ptions.rst</span><br><span>@@ -423,6 +423,15 @@</span><br><span>   See the =
`Environmental Variables`_ section below for additional</span><br><span>   =
parameters passed as environmental variables.</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+--tls-export-cert-path dir</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Adds an environment va=
riable ``peer_cert_{x}`` (and an alias</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  ``peer_cert`` for ``peer_cert_0`` for compatibility)  =
when calling the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `=
`--tls-verify`` script or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  hook to verify the c=
ertificate.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  The environment variable =
contains the path to a PEM encoded certificate</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  of the current peer certificate in the directo=
ry ``dir``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> --up cmd</span><br><span>   Run command ``cmd`` after successful =
TUN/TAP device open (pre ``--user``</span><br><span>   UID change).</span><=
br><span>@@ -763,6 +772,15 @@</span><br><span>     modifier is specified, a=
nd deleted from the environment after the script</span><br><span>     retur=
ns.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+:code:`peer_cert_{n}`</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    If the option ``--tls-export-cert`` is enabled, this option contain=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the path to th=
e current peer certificate to be verified in PEM format</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    where ``n`` is the verification lev=
el.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+:code:`peer_cert`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    Identical to `peer_cert_0` for co=
mpatibility with older</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    versions.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> :code:`proto`</span><br><span>     The ``--proto`` parameter=
. Set on program initiation and reset on</span><br><span>     SIGHUP.</span=
><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><=
span>index 9e2b3845..917ae33 100644</span><br><span>--- a/src/openvpn/init.=
c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3336,6 +3336=
,7 @@</span><br><span>     to.auth_user_pass_verify_script_via_file =3D opt=
ions-&gt;auth_user_pass_verify_script_via_file;</span><br><span>     to.cli=
ent_crresponse_script =3D options-&gt;client_crresponse_script;</span><br><=
span>     to.tmp_dir =3D options-&gt;tmp_dir;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    to.export_peer_cert_dir =3D options-&gt;tls_e=
xport_peer_cert_path;</span><br><span>     if (options-&gt;ccd_exclusive)</=
span><br><span>     {</span><br><span>         to.client_config_dir_exclusi=
ve =3D options-&gt;client_config_dir;</span><br><span>diff --git a/src/open=
vpn/options.c b/src/openvpn/options.c</span><br><span>index 1521872..503e83=
2 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/=
src/openvpn/options.c</span><br><span>@@ -1986,6 +1986,7 @@</span><br><span=
>     SHOW_STR(cipher_list_tls13);</span><br><span>     SHOW_STR(tls_cert_p=
rofile);</span><br><span>     SHOW_STR(tls_verify);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(tls_export_peer_cert_path);<=
/span><br><span>     SHOW_INT(verify_x509_type);</span><br><span>     SHOW_=
STR(verify_x509_name);</span><br><span>     SHOW_STR_INLINE(crl_file);</spa=
n><br><span>@@ -3048,6 +3049,7 @@</span><br><span>         MUST_BE_UNDEF(ci=
pher_list_tls13);</span><br><span>         MUST_BE_UNDEF(tls_cert_profile);=
</span><br><span>         MUST_BE_UNDEF(tls_verify);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls_export_peer_cer=
t_path);</span><br><span>         MUST_BE_UNDEF(verify_x509_name);</span><b=
r><span>         MUST_BE_UNDEF(tls_timeout);</span><br><span>         MUST_=
BE_UNDEF(renegotiate_bytes);</span><br><span>@@ -4053,6 +4055,13 @@</span><=
br><span>                                                 R_OK, &quot;--crl=
-verify&quot;);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_export_peer_ce=
rt_path)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_f=
ile_access_chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
 options-&gt;tls_export_peer_cert_path,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                         W_OK, &quot;--=
tls-export-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     ASSERT(options-&gt;connection_list);</span><br><span>     for (=
int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span><br><sp=
an>     {</span><br><span>@@ -8998,6 +9007,11 @@</span><br><span>          =
               string_substitute(p[1], &#39;,&#39;, &#39; &#39;, &amp;optio=
ns-&gt;gc),</span><br><span>                         &quot;tls-verify&quot;=
, true);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;tls-export-cert&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_SCRIPT);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        options-&gt;tls_export_peer_cert_path =3D p[1];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
else if (streq(p[0], &quot;compat-names&quot;))</span><br><span>     {</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff=
 --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>inde=
x c4514e1..3b9a7f6 100644</span><br><span>--- a/src/openvpn/options.h</span=
><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -592,6 +592,7 @@<=
/span><br><span>     const char *tls_cert_profile;</span><br><span>     con=
st char *ecdh_curve;</span><br><span>     const char *tls_verify;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *tls_export_pe=
er_cert_path;</span><br><span>     int verify_x509_type;</span><br><span>  =
   const char *verify_x509_name;</span><br><span>     const char *crl_file;=
</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_co=
mmon.h</span><br><span>index 925660b..f085e0d 100644</span><br><span>--- a/=
src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</sp=
an><br><span>@@ -374,6 +374,7 @@</span><br><span>     const char *client_cr=
response_script;</span><br><span>     bool auth_user_pass_verify_script_via=
_file;</span><br><span>     const char *tmp_dir;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *export_peer_cert_dir;</span><b=
r><span>     const char *auth_user_pass_file;</span><br><span>     bool aut=
h_user_pass_file_inline;</span><br><span> </span><br><span>diff --git a/src=
/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index bd7e=
512..5cf518e 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><b=
r><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -457,6 +457,30 @@=
</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+verify_cert_cert_export_en=
v(struct env_set *es, openvpn_x509_cert_t *peer_cert,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            int cert_dept=
h, const char *pem_export_fn)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 envname[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* export the path to the certificate in pem file format */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf=
(envname, sizeof(envname), &quot;peer_cert_%d&quot;, cert_depth);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, envname, p=
em_export_fn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* compatibility wit=
h older scripts/plugins that expect peer_cert without</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * suffix */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (cert_depth =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        setenv_str(es, &quot;peer_cert&quot;, pem=
_export_fn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D (backend_x509_write_pem=
(peer_cert, pem_export_fn) =3D=3D SUCCESS);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><sp=
an>  * call --tls-verify plug-in(s)</span><br><span>  */</span><br><span>@@=
 -572,18 +596,19 @@</span><br><span> result_t</span><br><span> verify_cert(=
struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* need to define these variables here so goto cleanup will always have</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * them defined */<=
/span><br><span>     result_t ret =3D FAILURE;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char *subject =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct tls_options *opt;</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *pem_export_fn =3D NULL;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opt =3D s=
ession-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct tls_options *opt =3D session-&gt;opt;</span><br><span>     ASS=
ERT(opt);</span><br><span> </span><br><span>     session-&gt;verified =3D f=
alse;</span><br><span> </span><br><span>     /* get the X509 name */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    subject =3D x509_get_sub=
ject(cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char *subject =3D x509_get_subject(cert, &amp;gc);</span><br><span>   =
  if (!subject)</span><br><span>     {</span><br><span>         msg(D_TLS_E=
RRORS, &quot;VERIFY ERROR: depth=3D%d, could not extract X509 &quot;</span>=
<br><span>@@ -706,6 +731,19 @@</span><br><span> </span><br><span>     sessi=
on-&gt;verify_maxlevel =3D max_int(session-&gt;verify_maxlevel, cert_depth)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (opt-&gt;export_peer_cert_dir)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        pem_export_fn =3D platform_create_temp_file(opt-&gt;export_peer=
_cert_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                         &quot;pef&quot;, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!pem_export_fn</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            || !verify_cert_cert_export=
_env(opt-&gt;es, cert, cert_depth, pem_export_fn))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: Failed =
to export certificate for &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                &quot;--tls-export-cert in %s&quot;, opt-&gt;e=
xport_peer_cert_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto cleanup;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span>     /* export certificate values to the environment */=
</span><br><span>     verify_cert_set_env(opt-&gt;es, cert, cert_depth, sub=
ject, common_name,</span><br><span>                         opt-&gt;x509_tr=
ack);</span><br><span>@@ -763,6 +801,11 @@</span><br><span>         tls_cle=
ar_error(); /* always? */</span><br><span>         session-&gt;verified =3D=
 false; /* double sure? */</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (pem_export_fn)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        platform_unlink(pem_export_fn);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     gc_free(&amp;gc);</span><br=
><span> </span><br><span>     return ret;</span><br><span>diff --git a/src/=
openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><=
span>index d402b1f..5301a51 100644</span><br><span>--- a/src/openvpn/ssl_ve=
rify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span=
><br><span>@@ -161,6 +161,17 @@</span><br><span>                           =
        struct gc_arena *gc);</span><br><span> </span><br><span> /*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write the certificate to=
 the file in PEM format.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cert          Certi=
ficate to serialise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return      =
        \c FAILURE, \c or SUCCESS</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+re=
sult_t backend_x509_write_pem(openvpn_x509_cert_t *cert,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                const =
char *filename);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  *=
 Save X509 fields to environment, using the naming convention:</span><br><s=
pan>  *</span><br><span>  * X509_{cert_depth}_{name}=3D{value}</span><br><s=
pan>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_=
mbedtls.c</span><br><span>index 5612139..24a89c3 100644</span><br><span>---=
 a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_v=
erify_mbedtls.c</span><br><span>@@ -218,6 +218,41 @@</span><br><span>     r=
eturn buf;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+result_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+backend_x509_write_pem(openvpn_x509_cert_t *cert, const ch=
ar *filename)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* mbed TLS does not=
 make it easy to write a certificate in PEM format.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * The only way is to directly access=
 the DER encoded raw certificate</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * and PEM encode it ourselves */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* just do a very loose upper bound for th=
e base64 based PEM encoding</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * using 3 times the space for the base64 and 100 bytes for the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * headers and =
footer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer pem =3D alloc_buf_gc(cert-&gt;raw.len * 3 + 100, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer der =3D {};</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;der, cert-&gt;r=
aw.p, cert-&gt;raw.len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!crypt=
o_pem_encode(&quot;CERTIFICATE&quot;, &amp;pem,  &amp;der, &amp;gc))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!buffer_write_file(filename, &amp;pem))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return SUCCESS=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;Er=
ror writing X509 certificate to file %s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        filename);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return FAILURE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static struct buffer</span><br><span> x509_get_=
fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert,</span=
><br><span>                      struct gc_arena *gc)</span><br><span>diff =
--git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c=
</span><br><span>index 5afffc1..00fdec3 100644</span><br><span>--- a/src/op=
envpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_ope=
nssl.c</span><br><span>@@ -320,6 +320,29 @@</span><br><span>     return for=
mat_hex_ex(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1, &quot;:&quot;, gc);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+result_t</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    BIO *out =3D BIO_new_file(filenam=
e, &quot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!PEM_write_bio_X509(out, cert))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    BIO_free(out);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
SUCCESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO_free(out);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_msg(D_TLS_DEBUG_=
LOW, &quot;Error writing X509 certificate to file %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+               filename);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> struct buffer</span><br><span=
> x509_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)</span><br><spa=
n> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/466?usp=3Demail">change 466</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/466?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--NTr5rnxQ9oI=--

