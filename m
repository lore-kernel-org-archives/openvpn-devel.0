From: Rottler Tamas <tom@...395...>
Message-ID: <20050510202133.GM31971@...396...>
References: <20050509203727.GJ31971@...396...>
Mime-Version: 1.0
In-Reply-To: <20050509203727.GJ31971@...396...>
Subject: [Openvpn-devel] Re: external script based certificate validation
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue May 10 13:24:00 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi! It is very useful to also export the verification depth
to the ssl-verify script. This patch adds it:

--- openvpn-2.0-new/ssl.c       Mon May  9 19:03:19 2005
+++ openvpn-2.0-new2/ssl.c      Tue May 10 16:17:00 2005
@@ -586,6 +586,7 @@
             { 
               setenv_str(opt->es, "peer_cert", peer_cert);
               free(peer_cert);
+              setenv_int(opt->es, "peer_cert_depth", ctx->error_depth);
             }
         }

regards, Tom


* Rottler Tamas [Mon, 2005 May 09 22:37:27 +0200]:
> Hi! I needed support in OpenVPN to let an external script
> verify peer certificates in multi-client mode. I need this
> to be able to accept individual client certificates signed
> by different CAs or even self signed certificates, so that
> I can control exatly who may connect when I do not operate
> a CA.
> 
> I attached a patch for this against OpenVPN 2.0. It adds a
> new configuration option --tls-verify-cert. When it is
> turned on, the normal OpenSSL certificate preverification
> is ignored and an environment variable named peer_cert is
> exported for the tls-verify script, containing the peer's
> certificate in base64 encoded form.
> 
> This is not PEM format because of the missing header, foo-
> ter and line breaks. Instead if you un-base64 it, you'll
> get the DER-form certificate.
> 
> I hope this patch can be useful to someone, or someday be
> included in OpenVPN.
> 
> regards, Tom

> diff -ur openvpn-2.0/init.c openvpn-2.0-new/init.c
> --- openvpn-2.0/init.c	Mon Apr 11 05:43:56 2005
> +++ openvpn-2.0-new/init.c	Mon May  9 18:57:45 2005
> @@ -1305,6 +1305,7 @@
>  #endif
>  
>    to.verify_command = options->tls_verify;
> +  to.verify_export_cert = options->tls_verify_cert;
>    to.verify_x509name = options->tls_remote;
>    to.crl_file = options->crl_file;
>    to.ns_cert_type = options->ns_cert_type;
> diff -ur openvpn-2.0/options.c openvpn-2.0-new/options.c
> --- openvpn-2.0/options.c	Sun Apr 17 00:03:15 2005
> +++ openvpn-2.0-new/options.c	Mon May  9 18:19:02 2005
> @@ -426,6 +426,9 @@
>    "                  tests of certification.  cmd should return 0 to allow\n"
>    "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
>    "                  executed as 'cmd certificate_depth X509_NAME_oneline')\n"
> +  "--tls-verify-cert: Let --tls-verify script verify the peer certificate\n"
> +  "                  and disable openssl's built in verification (possibly\n"
> +  "                  dangerous!)\n"
>    "--tls-remote x509name: Accept connections only from a host with X509 name\n"
>    "                  x509name. The remote host must also pass all other tests\n"
>    "                  of verification.\n"
> @@ -1105,6 +1108,7 @@
>  #endif
>    SHOW_STR (cipher_list);
>    SHOW_STR (tls_verify);
> +  SHOW_BOOL (tls_verify_cert);
>    SHOW_STR (tls_remote);
>    SHOW_STR (crl_file);
>    SHOW_INT (ns_cert_type);
> @@ -1625,6 +1629,7 @@
>        MUST_BE_UNDEF (pkcs12_file);
>        MUST_BE_UNDEF (cipher_list);
>        MUST_BE_UNDEF (tls_verify);
> +      MUST_BE_UNDEF (tls_verify_cert);
>        MUST_BE_UNDEF (tls_remote);
>        MUST_BE_UNDEF (tls_timeout);
>        MUST_BE_UNDEF (renegotiate_bytes);
> @@ -4355,6 +4360,11 @@
>        if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
>  	goto err;
>        options->tls_verify = string_substitute (p[1], ',', ' ', &options->gc);
> +    }
> +  else if (streq (p[0], "tls-verify-cert"))
> +    {
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      options->tls_verify_cert = true;
>      }
>    else if (streq (p[0], "tls-remote") && p[1])
>      {
> diff -ur openvpn-2.0/options.h openvpn-2.0-new/options.h
> --- openvpn-2.0/options.h	Mon Apr 11 05:43:57 2005
> +++ openvpn-2.0-new/options.h	Mon May  9 18:17:35 2005
> @@ -362,6 +362,7 @@
>    const char *pkcs12_file;
>    const char *cipher_list;
>    const char *tls_verify;
> +  bool tls_verify_cert; /* Verify peer cert in tls-verify script _only_ */
>    const char *tls_remote;
>    const char *crl_file;
>    int ns_cert_type; /* set to 0, NS_SSL_SERVER, or NS_SSL_CLIENT */
> diff -ur openvpn-2.0/ssl.c openvpn-2.0-new/ssl.c
> --- openvpn-2.0/ssl.c	Mon Apr 11 05:43:55 2005
> +++ openvpn-2.0-new/ssl.c	Mon May  9 19:03:19 2005
> @@ -52,6 +52,7 @@
>  #include "perf.h"
>  #include "status.h"
>  #include "gremlin.h"
> +#include "base64.h"
>  
>  #ifdef WIN32
>  #include "cryptoapi.h"
> @@ -398,6 +399,31 @@
>      }
>  }
>  
> +static int get_peer_cert(X509_STORE_CTX *ctx, char **out)
> +{
> +  X509 *peercert;
> +  int len, b64len;
> +  char *buf, *bufp, *b64buf;
> +
> +  peercert = X509_STORE_CTX_get_current_cert(ctx);
> +  len = i2d_X509(peercert, NULL);
> +  buf = malloc(len);
> +  if (!buf) {
> +    *out = NULL;
> +    return false;
> +  }
> +  bufp = buf;
> +  i2d_X509(peercert, (unsigned char **) &bufp);
> +  b64len = base64_encode(buf, len, &b64buf);
> +  free(buf);
> +  if (b64len <= 0) {
> +    *out = NULL;
> +    return false;
> +  }
> +  *out = b64buf;
> +  return true;
> +}
> +
>  /*
>   * Our verify callback function -- check
>   * that an incoming peer certificate is good.
> @@ -413,6 +439,7 @@
>    struct tls_session *session;
>    const struct tls_options *opt;
>    const int max_depth = 8;
> +  char *peer_cert;
>  
>    /* get the tls_session pointer */
>    ssl = X509_STORE_CTX_get_ex_data (ctx, SSL_get_ex_data_X509_STORE_CTX_idx());
> @@ -445,9 +472,18 @@
>    if (!preverify_ok)
>      {
>        /* Remote site specified a certificate, but it's not correct */
> -      msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
> -	   ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
> -      goto err;			/* Reject connection */
> +      if (opt->verify_export_cert)
> +        {
> +          msg (D_TLS_ERRORS, "IGNORED VERIFY ERROR: depth=%d, error=%s: %s",
> +            ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
> +          /* continue checking */
> +        }
> +      else
> +        {
> +          msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, error=%s: %s",
> +            ctx->error_depth, X509_verify_cert_error_string (ctx->error), subject);
> +          goto err;			/* Reject connection */
> +        }
>      }
>  
>    /* warn if cert chain is too deep */
> @@ -544,6 +580,14 @@
>        int ret;
>  
>        setenv_str (opt->es, "script_type", "tls-verify");
> +      if (opt->verify_export_cert)
> +        {
> +          if (get_peer_cert(ctx, &peer_cert))
> +            {
> +              setenv_str(opt->es, "peer_cert", peer_cert);
> +              free(peer_cert);
> +            }
> +        }
>  
>        buf_set_write (&out, (uint8_t*)command, sizeof (command));
>        buf_printf (&out, "%s %d %s",
> diff -ur openvpn-2.0/ssl.h openvpn-2.0-new/ssl.h
> --- openvpn-2.0/ssl.h	Mon Apr 11 05:43:56 2005
> +++ openvpn-2.0-new/ssl.h	Mon May  9 19:05:41 2005
> @@ -407,6 +407,7 @@
>  
>    /* cert verification parms */
>    const char *verify_command;
> +  bool verify_export_cert;
>    const char *verify_x509name;
>    const char *crl_file;
>    int ns_cert_type;


