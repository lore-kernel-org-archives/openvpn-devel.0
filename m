From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 6 Dec 2023 14:04:16 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <053b51812b9dca83afb0fb1e4ad6628763512693-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bdTfW3oHRG8="; charset=UTF-8
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

--bdTfW3oHRG8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail

to look at the new patch set (#2).


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
9 files changed, 152 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/466/2

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 38dcfa2..26b5434 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -423,6 +423,15 @@
   See the `Environmental Variables`_ section below for additional
   parameters passed as environmental variables.

+--tls-export-cert-path dir
+  Adds a an environment variables ``peer_cert_{x}`` (and an alias
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
@@ -763,6 +772,14 @@
     modifier is specified, and deleted from the environment after the scri=
pt
     returns.

+:code:`peer_cert_{n}`
+    If the option ``--tls-export-cert`` is enabled, this option contains
+    the path to the current peer certificate to be verified in PEM format
+    where ``n`` is the verification level.
+
+:code:`peer_cert` identical to `peer_cert_0` for compatibility with older
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
index bd7e512..263b6d4 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -457,6 +457,32 @@
     gc_free(&gc);
 }

+static bool
+verify_cert_cert_export_env(struct env_set *es, openvpn_x509_cert_t *peer_=
cert,
+                            int cert_depth, const char *pem_export_fn)
+{
+    char envname[64];
+    struct gc_arena gc =3D gc_new();
+    /* export the certificate itself as pem when the enabled */
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
+    bool ret =3D true;
+
+    ret =3D (backend_x509_write_pem(peer_cert, pem_export_fn) =3D=3D SUCCE=
SS);
+
+    gc_free(&gc);
+    return ret;
+}
+
+
 /*
  * call --tls-verify plug-in(s)
  */
@@ -572,18 +598,19 @@
 result_t
 verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int ce=
rt_depth)
 {
+    /* need to define these variables here so goto cleanup will always have
+     * these variables defined */
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
@@ -706,6 +733,19 @@

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
@@ -763,6 +803,11 @@
         tls_clear_error(); /* always? */
         session->verified =3D false; /* double sure? */
     }
+    if (pem_export_fn)
+    {
+        platform_unlink(pem_export_fn);
+    }
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
index 5612139..a48526e 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -218,6 +218,41 @@
     return buf;
 }

+result_t
+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)
+{
+    /* mbed TLS does not make it easy to write a certificate in PEM format.
+     * The only way to is directly access the DER encoded raw certificate
+     * and PEM encode it ourselves */
+
+    struct gc_arena gc =3D gc_new();
+    /* just do a very loose upper bound for the base64 based PEM encoding
+     * using needing 3 times the space for the base64 and 100 bytes for the
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--bdTfW3oHRG8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Implement the --tls-export-cert feature<br><br>This is a re-implement=
ation of the --tls-export-cert feature. This<br>was necessary to due to mis=
sing approval to re-license the old<br>(now removed) code. The re-implement=
ation is based on the following<br>description of the feature provided by D=
avid:<br><br>  Add an option to export certificate in PEM format of the rem=
ote<br>  peer to a given directory.<br><br>  For example: --tls-export-cert=
 /var/tmp<br><br>  This option should use a randomised filename, which is p=
rovided via a<br>  &quot;peer_cert&quot; environment variable for the --tls=
-verify script or the<br>  OPENVPN_PLUGIN_TLS_VERIFY plug-in hook.<br><br>O=
nce the script or plugin call has completed, OpenVPN should delete<br>this =
file.<br><br>Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/=
script-options.rst<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M =
src/openvpn/options.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_ve=
rify.c<br>M src/openvpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mb=
edtls.c<br>M src/openvpn/ssl_verify_openssl.c<br>9 files changed, 152 inser=
tions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/66/466/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/script-=
options.rst b/doc/man-sections/script-options.rst</span><br><span>index 38d=
cfa2..26b5434 100644</span><br><span>--- a/doc/man-sections/script-options.=
rst</span><br><span>+++ b/doc/man-sections/script-options.rst</span><br><sp=
an>@@ -423,6 +423,15 @@</span><br><span>   See the `Environmental Variables=
`_ section below for additional</span><br><span>   parameters passed as env=
ironmental variables.</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--tls-export-cert-path dir</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Adds a an environment variables ``peer_cert_{x=
}`` (and an alias</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
``peer_cert`` for ``peer_cert_0`` for compatibility)  when calling the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-verify`` scrip=
t or executing the OPENVPN_PLUGIN_TLS_VERIFY plugin</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  hook to verify the certificate.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  The environment variable contains the path t=
o a PEM encoded certificate</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  of the current peer certificate in the directory ``dir``.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --up cmd<=
/span><br><span>   Run command ``cmd`` after successful TUN/TAP device open=
 (pre ``--user``</span><br><span>   UID change).</span><br><span>@@ -763,6 =
+772,14 @@</span><br><span>     modifier is specified, and deleted from the=
 environment after the script</span><br><span>     returns.</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`peer_cert_=
{n}`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    If the opti=
on ``--tls-export-cert`` is enabled, this option contains</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    the path to the current peer cert=
ificate to be verified in PEM format</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    where ``n`` is the verification level.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+:code:`peer_cert` identical to `peer_cert_0` for compa=
tibility with older</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    versions.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> :code:`proto`</span><br><span>     The ``--proto`` parameter. S=
et on program initiation and reset on</span><br><span>     SIGHUP.</span><b=
r><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><spa=
n>index 9e2b3845..917ae33 100644</span><br><span>--- a/src/openvpn/init.c</=
span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3336,6 +3336,7 =
@@</span><br><span>     to.auth_user_pass_verify_script_via_file =3D option=
s-&gt;auth_user_pass_verify_script_via_file;</span><br><span>     to.client=
_crresponse_script =3D options-&gt;client_crresponse_script;</span><br><spa=
n>     to.tmp_dir =3D options-&gt;tmp_dir;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    to.export_peer_cert_dir =3D options-&gt;tls_expo=
rt_peer_cert_path;</span><br><span>     if (options-&gt;ccd_exclusive)</spa=
n><br><span>     {</span><br><span>         to.client_config_dir_exclusive =
=3D options-&gt;client_config_dir;</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index 1521872..503e832 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -1986,6 +1986,7 @@</span><br><span>  =
   SHOW_STR(cipher_list_tls13);</span><br><span>     SHOW_STR(tls_cert_prof=
ile);</span><br><span>     SHOW_STR(tls_verify);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    SHOW_STR(tls_export_peer_cert_path);</span=
><br><span>     SHOW_INT(verify_x509_type);</span><br><span>     SHOW_STR(v=
erify_x509_name);</span><br><span>     SHOW_STR_INLINE(crl_file);</span><br=
><span>@@ -3048,6 +3049,7 @@</span><br><span>         MUST_BE_UNDEF(cipher_=
list_tls13);</span><br><span>         MUST_BE_UNDEF(tls_cert_profile);</spa=
n><br><span>         MUST_BE_UNDEF(tls_verify);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls_export_peer_cert_path=
);</span><br><span>         MUST_BE_UNDEF(verify_x509_name);</span><br><spa=
n>         MUST_BE_UNDEF(tls_timeout);</span><br><span>         MUST_BE_UND=
EF(renegotiate_bytes);</span><br><span>@@ -4053,6 +4055,13 @@</span><br><sp=
an>                                                 R_OK, &quot;--crl-verif=
y&quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_export_peer_cert_pat=
h)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_ac=
cess_chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                         optio=
ns-&gt;tls_export_peer_cert_path,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                         W_OK, &quot;--tls-ex=
port-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     ASSERT(options-&gt;connection_list);</span><br><span>     for (int i =
=3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span><br><span>   =
  {</span><br><span>@@ -8998,6 +9007,11 @@</span><br><span>                =
         string_substitute(p[1], &#39;,&#39;, &#39; &#39;, &amp;options-&gt=
;gc),</span><br><span>                         &quot;tls-verify&quot;, true=
);</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (streq(p[0], &quot;tls-export-cert&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_=
PERMISSION(OPT_P_SCRIPT);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        options-&gt;tls_export_peer_cert_path =3D p[1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (streq(p[0], &quot;compat-names&quot;))</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git=
 a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index c451=
4e1..3b9a7f6 100644</span><br><span>--- a/src/openvpn/options.h</span><br><=
span>+++ b/src/openvpn/options.h</span><br><span>@@ -592,6 +592,7 @@</span>=
<br><span>     const char *tls_cert_profile;</span><br><span>     const cha=
r *ecdh_curve;</span><br><span>     const char *tls_verify;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *tls_export_peer_cer=
t_path;</span><br><span>     int verify_x509_type;</span><br><span>     con=
st char *verify_x509_name;</span><br><span>     const char *crl_file;</span=
><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h=
</span><br><span>index 925660b..f085e0d 100644</span><br><span>--- a/src/op=
envpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br=
><span>@@ -374,6 +374,7 @@</span><br><span>     const char *client_crrespon=
se_script;</span><br><span>     bool auth_user_pass_verify_script_via_file;=
</span><br><span>     const char *tmp_dir;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *export_peer_cert_dir;</span><br><spa=
n>     const char *auth_user_pass_file;</span><br><span>     bool auth_user=
_pass_file_inline;</span><br><span> </span><br><span>diff --git a/src/openv=
pn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index bd7e512..2=
63b6d4 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><spa=
n>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -457,6 +457,32 @@</span=
><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+verify_cert_cert_export_env(stru=
ct env_set *es, openvpn_x509_cert_t *peer_cert,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            int cert_depth, con=
st char *pem_export_fn)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char envna=
me[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* export the certificate itself as pem when the enabled */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_snprintf(envna=
me, sizeof(envname), &quot;peer_cert_%d&quot;, cert_depth);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    setenv_str(es, envname, pem_exp=
ort_fn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* compatibility with olde=
r scripts/plugins that expect peer_cert without</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * suffix */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (cert_depth =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        setenv_str(es, &quot;peer_cert&quot;, pem_expor=
t_fn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool ret =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D (backend_x509_write_pem(peer_cert, pem_export_fn=
) =3D=3D SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /*</span><br><span>  * call --tls-verify =
plug-in(s)</span><br><span>  */</span><br><span>@@ -572,18 +598,19 @@</span=
><br><span> result_t</span><br><span> verify_cert(struct tls_session *sessi=
on, openvpn_x509_cert_t *cert, int cert_depth)</span><br><span> {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* need to define these v=
ariables here so goto cleanup will always have</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * these variables defined */</span><br><spa=
n>     result_t ret =3D FAILURE;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    char *subject =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const struct tls_options *opt;</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *pem_export_fn =3D NULL;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    opt =3D session-&gt;opt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tl=
s_options *opt =3D session-&gt;opt;</span><br><span>     ASSERT(opt);</span=
><br><span> </span><br><span>     session-&gt;verified =3D false;</span><br=
><span> </span><br><span>     /* get the X509 name */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    subject =3D x509_get_subject(cert, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *subj=
ect =3D x509_get_subject(cert, &amp;gc);</span><br><span>     if (!subject)=
</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;VE=
RIFY ERROR: depth=3D%d, could not extract X509 &quot;</span><br><span>@@ -7=
06,6 +733,19 @@</span><br><span> </span><br><span>     session-&gt;verify_m=
axlevel =3D max_int(session-&gt;verify_maxlevel, cert_depth);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt=
;export_peer_cert_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pem=
_export_fn =3D platform_create_temp_file(opt-&gt;export_peer_cert_dir,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                          &quot;pef&quot;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!pem_export_fn</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            || !verify_cert_cert_export_env(opt-&gt;e=
s, cert, cert_depth, pem_export_fn))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: Failed to export cert=
ificate for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &quot;--tls-export-cert in %s&quot;, opt-&gt;export_peer_cer=
t_dir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
goto cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span>     /* export certificate values to the environment */</span><br><sp=
an>     verify_cert_set_env(opt-&gt;es, cert, cert_depth, subject, common_n=
ame,</span><br><span>                         opt-&gt;x509_track);</span><b=
r><span>@@ -763,6 +803,11 @@</span><br><span>         tls_clear_error(); /*=
 always? */</span><br><span>         session-&gt;verified =3D false; /* dou=
ble sure? */</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (pem_export_fn)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        platform_unlink(pem_export_fn);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     gc_free(&amp;gc);</span><br><span> </span>=
<br><span>     return ret;</span><br><span>diff --git a/src/openvpn/ssl_ver=
ify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><span>index d402=
b1f..5301a51 100644</span><br><span>--- a/src/openvpn/ssl_verify_backend.h<=
/span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><br><span>@@ -=
161,6 +161,17 @@</span><br><span>                                   struct =
gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Write the certificate to the file in P=
EM format.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param cert          Certificate to se=
rialise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return              \c F=
AILURE, \c or SUCCESS</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+result_t backe=
nd_x509_write_pem(openvpn_x509_cert_t *cert,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                const char *filena=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Save X509 f=
ields to environment, using the naming convention:</span><br><span>  *</spa=
n><br><span>  * X509_{cert_depth}_{name}=3D{value}</span><br><span>diff --g=
it a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</s=
pan><br><span>index 5612139..a48526e 100644</span><br><span>--- a/src/openv=
pn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtl=
s.c</span><br><span>@@ -218,6 +218,41 @@</span><br><span>     return buf;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+result_t</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+backend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* mbed TLS does not make it eas=
y to write a certificate in PEM format.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * The only way to is directly access the DER encod=
ed raw certificate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * and PEM encode it ourselves */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* just do a very loose upper bound for the base64 based=
 PEM encoding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 using needing 3 times the space for the base64 and 100 bytes for the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * headers and footer=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r pem =3D alloc_buf_gc(cert-&gt;raw.len * 3 + 100, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer der =3D {};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;der, cert-&gt;raw.p=
, cert-&gt;raw.len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!crypto_pe=
m_encode(&quot;CERTIFICATE&quot;, &amp;pem,  &amp;der, &amp;gc))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!buffer_write_file(filename, &amp;pem))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return SUCCESS;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;Error w=
riting X509 certificate to file %s&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        filename);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return FAILURE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static struct buffer</span><br><span> x509_get_finge=
rprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert,</span><br>=
<span>                      struct gc_arena *gc)</span><br><span>diff --git=
 a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</spa=
n><br><span>index 5afffc1..00fdec3 100644</span><br><span>--- a/src/openvpn=
/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.=
c</span><br><span>@@ -320,6 +320,29 @@</span><br><span>     return format_h=
ex_ex(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1, &quot;:&quot;, gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+result_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ackend_x509_write_pem(openvpn_x509_cert_t *cert, const char *filename)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    BIO *out =3D BIO_new_file(filename, &=
quot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!PEM_write_bio_X509(out, cert))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    BIO_free(out);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return SUCC=
ESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    BIO_free(out);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    crypto_msg(D_TLS_DEBUG_LOW,=
 &quot;Error writing X509 certificate to file %s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+               filename);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return FAILURE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> struct buffer</span><br><span> x5=
09_get_sha1_fingerprint(X509 *cert, struct gc_arena *gc)</span><br><span> {=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/466?usp=3Demail">change 466</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/466?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bdTfW3oHRG8=--

