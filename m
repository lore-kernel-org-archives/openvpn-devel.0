MIME-Version: 1.0
In-Reply-To: <1322057655-15463-1-git-send-email-heiko.hund@...1489...>
References: <1322057655-15463-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 23 Nov 2011 16:53:06 +0200
Message-ID: <CAOazyz0mAOkx5VBBM2WDiCBQ-S6ikV++9ixQpdg4LCCJ0D1sLg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

As this is inserted into environment, what happens if locale is not
unicode enabled?
I think this may break some configurations.

On Wed, Nov 23, 2011 at 4:14 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> The UTF-8 support that came with commit 2627335 does allow international
> usernames and passwords. This patch introduces UTF-8 support for X.509 DN=
s.
> Additionally, instead of using the legacy openssl format, DNs are now
> displayed in RFC 2253 format; "/C=3Dru/L=3D\xD0\x9C\xD0\xBE\xD1\x81\xD0\x=
BA\xD0
> \xB2\xD0\xB0/O=3D\xD0\x9A\xD1\x80\xD0\xB5\xD0\xBC\xD0\xBB\xD1\x8C/CN=3Dkr=
eml.ru"
> becomes "C=3Dru, L=3D=D0=9C=D0=BE=D1=81=D0=BA=D0=B2=D0=B0, O=3D=D0=9A=D1=
=80=D0=B5=D0=BC=D0=BB=D1=8C, CN=3Dkreml.ru".
>
> Since the specific character classes for X.509 names are removed, the
> "no-name-remapping" configuration option has no use anymore and is removed
> as well.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0openvpn.8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 23 +----------------------
> =C2=A0options.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 12 +-----------
> =C2=A0pkcs11_openssl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0sample-scripts/verify-cn | =C2=A0 =C2=A06 +++---
> =C2=A0ssl_openssl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 36 =
++++++++++++++++++++++++++++++++++++
> =C2=A0ssl_openssl.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A01 +
> =C2=A0ssl_verify.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 45 =
+++++++++------------------------------------
> =C2=A0ssl_verify_openssl.c =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
> =C2=A08 files changed, 54 insertions(+), 75 deletions(-)
>
> diff --git a/openvpn.8 b/openvpn.8
> index b8594e1..e96c1e4 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -3322,27 +3322,6 @@ the authenticated username as the common name,
> =C2=A0rather than the common name from the client cert.
> =C2=A0.\"*********************************************************
> =C2=A0.TP
> -.B \-\-no-name-remapping
> -Allow Common Name, X509 Subject, and username strings to include
> -any printable character including space, but excluding control
> -characters such as tab, newline, and carriage-return.
> -
> -By default, OpenVPN will remap
> -any character other than alphanumeric, underbar ('_'), dash
> -('-'), dot ('.'), and slash ('/') to underbar ('_'). =C2=A0The X509
> -Subject string as returned by the
> -.B tls_id
> -environmental variable, can additionally contain colon (':') or
> -equal ('=3D').
> -
> -While name remapping is performed for security reasons to reduce
> -the possibility of introducing string expansion security vulnerabilities
> -in user-defined authentication
> -scripts, this option is provided for those cases where it is desirable to
> -disable the remapping feature. =C2=A0Don't use this option unless you
> -know what you are doing!
> -.\"*********************************************************
> -.TP
> =C2=A0.B \-\-port-share host port [dir]
> =C2=A0When run in TCP server mode, share the OpenVPN port with
> =C2=A0another application, such as an HTTPS server. =C2=A0If OpenVPN
> @@ -4463,7 +4442,7 @@ When
> =C2=A0.B cmd
> =C2=A0is executed two arguments are appended, as follows:
>
> -.B cmd certificate_depth X509_NAME_oneline
> +.B cmd certificate_depth subject
>
> =C2=A0These arguments are, respectively, the current certificate depth and
> =C2=A0the X509 common name (cn) of the peer.
> diff --git a/options.c b/options.c
> index 0d86cd0..a01ae76 100644
> --- a/options.c
> +++ b/options.c
> @@ -597,7 +597,7 @@ static const char usage_message[] =3D
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pe=
nding TLS connection that has otherwise passed all other\n"
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te=
sts of certification. =C2=A0cmd should return 0 to allow\n"
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TL=
S handshake to proceed, or 1 to fail. =C2=A0(cmd is\n"
> - =C2=A0" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
xecuted as 'cmd certificate_depth X509_NAME_oneline')\n"
> + =C2=A0" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e=
xecuted as 'cmd certificate_depth subject')\n"
> =C2=A0 "--tls-export-cert [directory] : Get peer cert in PEM format and s=
tore it \n"
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
 an openvpn temporary file in [directory]. Peer cert is \n"
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
ored before tls-verify script execution and deleted after.\n"
> @@ -2160,9 +2160,6 @@ options_postprocess_verify_ce (const struct options=
 *options, const struct conne
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((options->ssl_flags & SSLF_AUTH_USE=
R_PASS_OPTIONAL) && !ccnr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, "--auth-user-pass-=
optional %s", postfix);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -
> - =C2=A0 =C2=A0 =C2=A0 if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) =
&& script_method =3D=3D SM_SYSTEM)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, "--script-security method=3D'=
system' cannot be combined with --no-name-remapping");
> =C2=A0 =C2=A0 }
> =C2=A0 else
> =C2=A0 =C2=A0 {
> @@ -2197,8 +2194,6 @@ options_postprocess_verify_ce (const struct options=
 *options, const struct conne
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, "--username-as-common-name requi=
res --mode server");
> =C2=A0 =C2=A0 =C2=A0 if (options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONA=
L)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, "--auth-user-pass-optional requi=
res --mode server");
> - =C2=A0 =C2=A0 =C2=A0if (options->ssl_flags & SSLF_NO_NAME_REMAPPING)
> - =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, "--no-name-remapping requires --mode=
 server");
> =C2=A0 =C2=A0 =C2=A0 if (options->ssl_flags & SSLF_OPT_VERIFY)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, "--opt-verify requires --mode se=
rver");
> =C2=A0 =C2=A0 =C2=A0 if (options->server_flags & SF_TCP_NODELAY_HELPER)
> @@ -5389,11 +5384,6 @@ add_option (struct options *options,
> =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);
> =C2=A0 =C2=A0 =C2=A0 options->ssl_flags |=3D SSLF_AUTH_USER_PASS_OPTIONAL;
> =C2=A0 =C2=A0 }
> - =C2=A0else if (streq (p[0], "no-name-remapping"))
> - =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
> - =C2=A0 =C2=A0 =C2=A0options->ssl_flags |=3D SSLF_NO_NAME_REMAPPING;
> - =C2=A0 =C2=A0}
> =C2=A0 else if (streq (p[0], "opt-verify"))
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_GENERAL);
> diff --git a/pkcs11_openssl.c b/pkcs11_openssl.c
> index e3463dc..943b90f 100644
> --- a/pkcs11_openssl.c
> +++ b/pkcs11_openssl.c
> @@ -129,7 +129,7 @@ pkcs11_certificate_dn (pkcs11h_certificate_t certific=
ate, char *dn,
> =C2=A0 =C2=A0 =C2=A0 goto cleanup;
> =C2=A0 =C2=A0 }
>
> - =C2=A0X509_NAME_oneline (X509_get_subject_name (x509), dn, dn_len);
> + =C2=A0openssl_get_subject (x509, dn, dn_len);
>
> =C2=A0 ret =3D 0;
>
> diff --git a/sample-scripts/verify-cn b/sample-scripts/verify-cn
> index f9fea0f..6e747ef 100755
> --- a/sample-scripts/verify-cn
> +++ b/sample-scripts/verify-cn
> @@ -3,7 +3,7 @@
> =C2=A0# verify-cn -- a sample OpenVPN tls-verify script
> =C2=A0#
> =C2=A0# Return 0 if cn matches the common name component of
> -# X509_NAME_oneline, 1 otherwise.
> +# subject, 1 otherwise.
> =C2=A0#
> =C2=A0# For example in OpenVPN, you could use the directive:
> =C2=A0#
> @@ -13,7 +13,7 @@
> =C2=A0# the client common name is listed on a line in the
> =C2=A0# allowed_clients file.
>
> -die "usage: verify-cn cnfile certificate_depth X509_NAME_oneline" if (@A=
RGV !=3D 3);
> +die "usage: verify-cn cnfile certificate_depth subject" if (@ARGV !=3D 3=
);
>
> =C2=A0# Parse out arguments:
> =C2=A0# =C2=A0 cnfile -- The file containing the list of common names, on=
e per
> @@ -37,7 +37,7 @@ if ($depth =3D=3D 0) {
> =C2=A0 =C2=A0 # If so, parse out the common name substring in
> =C2=A0 =C2=A0 # the X509 subject string.
>
> - =C2=A0 =C2=A0if ($x509 =3D~ /\/CN=3D([^\/]+)/) {
> + =C2=A0 =C2=A0if ($x509 =3D~ / CN=3D([^,]+)/) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cn =3D $1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Accept the connection if the X509 common name
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# string matches the passed cn argument.
> diff --git a/ssl_openssl.c b/ssl_openssl.c
> index 2e9fc4d..536b5f0 100644
> --- a/ssl_openssl.c
> +++ b/ssl_openssl.c
> @@ -1290,4 +1290,40 @@ get_highest_preference_tls_cipher (char *buf, int =
size)
> =C2=A0 SSL_CTX_free (ctx);
> =C2=A0}
>
> +char *
> +openssl_get_subject (X509 *cert, char *buf, int size)
> +{
> + =C2=A0BIO *subject_bio;
> + =C2=A0BUF_MEM *subject_mem;
> + =C2=A0char *subject =3D buf;
> + =C2=A0int maxlen =3D size;
> +
> + =C2=A0subject_bio =3D BIO_new (BIO_s_mem ());
> + =C2=A0if (subject_bio =3D=3D NULL)
> + =C2=A0 =C2=A0goto out;
> +
> + =C2=A0X509_NAME_print_ex (subject_bio, X509_get_subject_name (cert),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
> +
> + =C2=A0if (BIO_eof (subject_bio))
> + =C2=A0 =C2=A0goto out_free;
> +
> + =C2=A0BIO_get_mem_ptr (subject_bio, &subject_mem);
> + =C2=A0if (subject =3D=3D NULL)
> + =C2=A0 =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0maxlen =3D subject_mem->length + 1;
> + =C2=A0 =C2=A0 =C2=A0subject =3D malloc (maxlen);
> + =C2=A0 =C2=A0 =C2=A0check_malloc_return (subject);
> + =C2=A0 =C2=A0}
> +
> + =C2=A0memcpy (subject, subject_mem->data, maxlen);
> + =C2=A0subject[maxlen - 1] =3D '\0';
> +
> +out_free:
> + =C2=A0BIO_free (subject_bio);
> +out:
> + =C2=A0return subject;
> +}
> +
> =C2=A0#endif /* defined(USE_SSL) && defined(USE_OPENSSL) */
> diff --git a/ssl_openssl.h b/ssl_openssl.h
> index fc2052c..e5e303a 100644
> --- a/ssl_openssl.h
> +++ b/ssl_openssl.h
> @@ -54,5 +54,6 @@ struct key_state_ssl {
> =C2=A0extern int mydata_index; /* GLOBAL */
>
> =C2=A0void openssl_set_mydata_index (void);
> +char *openssl_get_subject (X509 *cert, char *buf, int size);
>
> =C2=A0#endif /* SSL_OPENSSL_H_ */
> diff --git a/ssl_verify.c b/ssl_verify.c
> index 326b005..0b2a1fb 100644
> --- a/ssl_verify.c
> +++ b/ssl_verify.c
> @@ -40,24 +40,9 @@
> =C2=A0#include "ssl_verify_openssl.h"
> =C2=A0#endif
>
> -/** Legal characters in an X509 name */
> -#define X509_NAME_CHAR_CLASS =C2=A0 (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT=
|CC_AT|CC_COLON|CC_SLASH|CC_EQUAL)
> -
> -/** Legal characters in a common name */
> -#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_A=
T|CC_SLASH)
> -
> =C2=A0/** Maximum length of common name */
> =C2=A0#define TLS_USERNAME_LEN 64
>
> -static void
> -string_mod_sslname (char *str, const unsigned int restrictive_flags, con=
st unsigned int ssl_flags)
> -{
> - =C2=A0if (ssl_flags & SSLF_NO_NAME_REMAPPING)
> - =C2=A0 =C2=A0string_mod (str, CC_PRINT, CC_CRLF, '_');
> - =C2=A0else
> - =C2=A0 =C2=A0string_mod (str, restrictive_flags, 0, '_');
> -}
> -
> =C2=A0/*
> =C2=A0* Export the untrusted IP address and port to the environment
> =C2=A0*/
> @@ -595,7 +580,7 @@ verify_cert(struct tls_session *session, x509_cert_t =
*cert, int cert_depth)
> =C2=A0 =C2=A0 }
>
> =C2=A0 /* enforce character class restrictions in X509 name */
> - =C2=A0string_mod_sslname (subject, X509_NAME_CHAR_CLASS, opt->ssl_flags=
);
> + =C2=A0string_mod (subject, CC_PRINT, CC_CRLF, '_');
> =C2=A0 string_replace_leading (subject, '-', '_');
>
> =C2=A0 /* extract the username (default is CN) */
> @@ -615,7 +600,7 @@ verify_cert(struct tls_session *session, x509_cert_t =
*cert, int cert_depth)
> =C2=A0 =C2=A0 }
>
> =C2=A0 /* enforce character class restrictions in common name */
> - =C2=A0string_mod_sslname (common_name, COMMON_NAME_CHAR_CLASS, opt->ssl=
_flags);
> + =C2=A0string_mod (common_name, CC_PRINT, CC_CRLF, '_');
>
> =C2=A0 /* warn if cert chain is too deep */
> =C2=A0 if (cert_depth >=3D MAX_CERT_DEPTH)
> @@ -1005,7 +990,7 @@ verify_user_pass_script (struct tls_session *session=
, const struct user_pass *up
> =C2=A0* Verify the username and password using a plugin
> =C2=A0*/
> =C2=A0static int
> -verify_user_pass_plugin (struct tls_session *session, const struct user_=
pass *up, const char *raw_username)
> +verify_user_pass_plugin (struct tls_session *session, const struct user_=
pass *up)
> =C2=A0{
> =C2=A0 int retval =3D OPENVPN_PLUGIN_FUNC_ERROR;
> =C2=A0 struct key_state *ks =3D &session->key[KS_PRIMARY]; =C2=A0 =C2=A0 =
=C2=A0 /* primary key */
> @@ -1014,7 +999,7 @@ verify_user_pass_plugin (struct tls_session *session=
, const struct user_pass *up
> =C2=A0 if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || st=
rlen (up->username))
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 /* set username/password in private env space */
> - =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", raw_usern=
ame);
> + =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", up->usern=
ame);
> =C2=A0 =C2=A0 =C2=A0 setenv_str (session->opt->es, "password", up->passwo=
rd);
>
> =C2=A0 =C2=A0 =C2=A0 /* setenv incoming cert common name for script */
> @@ -1038,7 +1023,6 @@ verify_user_pass_plugin (struct tls_session *sessio=
n, const struct user_pass *up
> =C2=A0#endif
>
> =C2=A0 =C2=A0 =C2=A0 setenv_del (session->opt->es, "password");
> - =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", up->usern=
ame);
> =C2=A0 =C2=A0 }
> =C2=A0 else
> =C2=A0 =C2=A0 {
> @@ -1059,7 +1043,7 @@ verify_user_pass_plugin (struct tls_session *sessio=
n, const struct user_pass *up
> =C2=A0#define KMDA_DEF =C2=A0 =C2=A0 3
>
> =C2=A0static int
> -verify_user_pass_management (struct tls_session *session, const struct u=
ser_pass *up, const char *raw_username)
> +verify_user_pass_management (struct tls_session *session, const struct u=
ser_pass *up)
> =C2=A0{
> =C2=A0 int retval =3D KMDA_ERROR;
> =C2=A0 struct key_state *ks =3D &session->key[KS_PRIMARY]; =C2=A0 =C2=A0 =
=C2=A0 /* primary key */
> @@ -1068,7 +1052,7 @@ verify_user_pass_management (struct tls_session *se=
ssion, const struct user_pass
> =C2=A0 if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || st=
rlen (up->username))
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 /* set username/password in private env space */
> - =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", raw_usern=
ame);
> + =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", up->usern=
ame);
> =C2=A0 =C2=A0 =C2=A0 setenv_str (session->opt->es, "password", up->passwo=
rd);
>
> =C2=A0 =C2=A0 =C2=A0 /* setenv incoming cert common name for script */
> @@ -1081,7 +1065,6 @@ verify_user_pass_management (struct tls_session *se=
ssion, const struct user_pass
> =C2=A0 =C2=A0 =C2=A0 =C2=A0management_notify_client_needing_auth (managem=
ent, ks->mda_key_id, session->opt->mda_context, session->opt->es);
>
> =C2=A0 =C2=A0 =C2=A0 setenv_del (session->opt->es, "password");
> - =C2=A0 =C2=A0 =C2=A0setenv_str (session->opt->es, "username", up->usern=
ame);
>
> =C2=A0 =C2=A0 =C2=A0 retval =3D KMDA_SUCCESS;
> =C2=A0 =C2=A0 }
> @@ -1105,9 +1088,6 @@ verify_user_pass(struct user_pass *up, struct tls_m=
ulti *multi,
> =C2=A0 bool s2 =3D true;
> =C2=A0 struct key_state *ks =3D &session->key[KS_PRIMARY]; =C2=A0 =C2=A0 =
=C2=A0 /* primary key */
>
> - =C2=A0struct gc_arena gc =3D gc_new ();
> - =C2=A0char *raw_username;
> -
> =C2=A0#ifdef MANAGEMENT_DEF_AUTH
> =C2=A0 int man_def_auth =3D KMDA_UNDEF;
>
> @@ -1115,22 +1095,17 @@ verify_user_pass(struct user_pass *up, struct tls=
_multi *multi,
> =C2=A0 =C2=A0 man_def_auth =3D KMDA_DEF;
> =C2=A0#endif
>
> - =C2=A0/* preserve raw username before string_mod remapping, for plugins=
 */
> - =C2=A0ALLOC_ARRAY_CLEAR_GC (raw_username, char, USER_PASS_LEN, &gc);
> - =C2=A0strcpy (raw_username, up->username);
> - =C2=A0string_mod (raw_username, CC_PRINT, CC_CRLF, '_');
> -
> =C2=A0 /* enforce character class restrictions in username/password */
> - =C2=A0string_mod_sslname (up->username, COMMON_NAME_CHAR_CLASS, session=
->opt->ssl_flags);
> + =C2=A0string_mod (up->username, CC_PRINT, CC_CRLF, '_');
> =C2=A0 string_mod (up->password, CC_PRINT, CC_CRLF, '_');
>
> =C2=A0 /* call plugin(s) and/or script */
> =C2=A0#ifdef MANAGEMENT_DEF_AUTH
> =C2=A0 if (man_def_auth =3D=3D KMDA_DEF)
> - =C2=A0 =C2=A0man_def_auth =3D verify_user_pass_management (session, up,=
 raw_username);
> + =C2=A0 =C2=A0man_def_auth =3D verify_user_pass_management (session, up);
> =C2=A0#endif
> =C2=A0 if (plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USE=
R_PASS_VERIFY))
> - =C2=A0 =C2=A0s1 =3D verify_user_pass_plugin (session, up, raw_username);
> + =C2=A0 =C2=A0s1 =3D verify_user_pass_plugin (session, up);
> =C2=A0 if (session->opt->auth_user_pass_verify_script)
> =C2=A0 =C2=A0 s2 =3D verify_user_pass_script (session, up);
>
> @@ -1179,8 +1154,6 @@ verify_user_pass(struct user_pass *up, struct tls_m=
ulti *multi,
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 msg (D_TLS_ERRORS, "TLS Auth Error: Auth Username/Pa=
ssword verification failed for peer");
> =C2=A0 =C2=A0 }
> -
> - =C2=A0gc_free (&gc);
> =C2=A0}
>
> =C2=A0void
> diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
> index 13c2f4e..7a99469 100644
> --- a/ssl_verify_openssl.c
> +++ b/ssl_verify_openssl.c
> @@ -248,14 +248,14 @@ x509_free_sha1_hash (unsigned char *hash)
> =C2=A0char *
> =C2=A0x509_get_subject (X509 *cert)
> =C2=A0{
> - =C2=A0return X509_NAME_oneline (X509_get_subject_name (cert), NULL, 0);
> + =C2=A0return openssl_get_subject (cert, NULL, 0);
> =C2=A0}
>
> =C2=A0void
> =C2=A0x509_free_subject (char *subject)
> =C2=A0{
> =C2=A0 if (subject)
> - =C2=A0 =C2=A0OPENSSL_free(subject);
> + =C2=A0 =C2=A0free(subject);
> =C2=A0}
>
>
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> All the data continuously generated in your IT infrastructure
> contains a definitive record of customers, application performance,
> security threats, fraudulent activity, and more. Splunk takes this
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

