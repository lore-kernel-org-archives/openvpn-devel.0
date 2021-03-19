References: <20200908154157.13809-1-arne@...1227...>
 <20200908154157.13809-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2ae19d61-f85c-05c3-eddb-5f06ea754c58@...2181...>
Date: Fri, 19 Mar 2021 12:02:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200908154157.13809-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/4] Implement peer-fingerprint to check
 fingerprint of peer certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

This patch currently only applies with "git am -3"

We currently have "verify-hash" that accepts fingerprints as argument.
For consistency I would suggest to either:
1) rename this option to peer-hash; or
2) add an alias for "verify-hash" named "verify-fingerprint", so that we
can then get rid of the former at some point.

I am more incline to option 2.

On 08/09/2020 17:41, Arne Schwabe wrote:
> This options allows to pin a certificate or a number of certificate.

How about:

"This option allows to pin one more more peer certificates"

> It also prepares for doing TLS authentication without a CA and just
> self-signed certificates.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                       |  7 ++++++
>  doc/man-sections/inline-files.rst |  4 ++--
>  doc/man-sections/tls-options.rst  | 22 ++++++++++++++++-
>  src/openvpn/init.c                |  1 +
>  src/openvpn/options.c             | 40 ++++++++++++++++++++++---------
>  src/openvpn/options.h             |  1 +
>  src/openvpn/ssl_common.h          |  1 +
>  src/openvpn/ssl_verify.c          | 19 ++++++++-------
>  8 files changed, 73 insertions(+), 22 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index f67e1d76..6007412c 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -1,5 +1,12 @@
>  Overview of changes in 2.5
>  ==========================
> +New features in 2.5.1
> +---------------------
> +Certificate pinning/verify peer fingerprint
> +    The ``--peer-fingerprint`` option has been introduced to give users a
> +    easy to use alternative to the ``tls-verify`` for matching the
> +    fingerprint of the peer. The option has use a number of
> +    SHA256 fingerprints.

"has use" ? maybe "can list" ?

>  
>  New features
>  ------------
> diff --git a/doc/man-sections/inline-files.rst b/doc/man-sections/inline-files.rst
> index 303bb3c8..01e4a840 100644
> --- a/doc/man-sections/inline-files.rst
> +++ b/doc/man-sections/inline-files.rst
> @@ -4,8 +4,8 @@ INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the ``--ca``,
>  ``--cert``, ``--dh``, ``--extra-certs``, ``--key``, ``--pkcs12``,
>  ``--secret``, ``--crl-verify``, ``--http-proxy-user-pass``, ``--tls-auth``,
> -``--auth-gen-token-secret``, ``--tls-crypt``, ``--tls-crypt-v2`` and
> -``--verify-hash`` options.
> +``--auth-gen-token-secret``, ``--peer-fingerprint``, ``--tls-crypt``,
> +``--tls-crypt-v2`` and ``--verify-hash`` options.
>  
>  Each inline file started by the line ``<option>`` and ended by the line
>  ``</option>``
> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index 52d4137e..658300b8 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -268,7 +268,8 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>    man-in-the-middle attack where an authorized client attempts to connect
>    to another client by impersonating the server. The attack is easily
>    prevented by having clients verify the server certificate using any one
> -  of ``--remote-cert-tls``, ``--verify-x509-name``, or ``--tls-verify``.
> +  of ``--remote-cert-tls``, ``--verify-x509-name``, ``--peer-fingerprint``
> +  or ``--tls-verify``.
>  
>  --tls-auth args
>    Add an additional layer of HMAC authentication on top of the TLS control
> @@ -589,6 +590,25 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>  
>  If the option is inlined, ``algo`` is always :code:`SHA256`.
>  
> +--peer-fingerprint args
> +   Specify a SHA256 fingerprint or list of SHA256 fingerprints to verify
> +   the peer certificate against. The peer certificate must match one of the
> +   fingerprint or certificate verification will fail. The option can also
> +   be inlined
> +
> +  Valid syntax:
> +  ::
> +
> +    peer-fingerprint AD:B0:95:D8:09:...
> +
> +  or inline:
> +  ::
> +
> +    <peer-fingerprint>
> +    00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff
> +    11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd:ee:ff:00
> +    </peer-fingerprint>
> +
>  --verify-x509-name args
>    Accept connections only if a host's X.509 name is equal to **name.** The
>    remote host must also pass all other tests of verification.
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a785934a..0c2b823e 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2909,6 +2909,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>      to.remote_cert_eku = options->remote_cert_eku;
>      to.verify_hash = options->verify_hash;
>      to.verify_hash_algo = options->verify_hash_algo;
> +    to.verify_hash_depth = options->verify_hash_depth;
>  #ifdef ENABLE_X509ALTUSERNAME
>      to.x509_username_field = (char *) options->x509_username_field;
>  #else
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 068f3e75..df9eef07 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8192,26 +8192,44 @@ add_option(struct options *options,
>          options->extra_certs_file = p[1];
>          options->extra_certs_file_inline = is_inline;
>      }
> -    else if (streq(p[0], "verify-hash") && p[1] && !p[3])
> +    else if ((streq(p[0], "verify-hash") && p[1] && !p[3])
> +             || (streq(p[0], "peer-fingerprint") && p[1] && !p[2]))
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
> +
> +        options->verify_hash_depth = 0;
>          options->verify_hash_algo = MD_SHA256;
>  
>          int digest_len = SHA256_DIGEST_LENGTH;
>  
> -        if (!p[2] || (p[2] && streq(p[2], "SHA1")))
> +        if (options->verify_hash)
>          {
> -            options->verify_hash_algo = MD_SHA1;
> -            msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
> -                "verify-hash is deprecated. You should switch to the "
> -                "SHA256.");
> -            options->verify_hash_algo = MD_SHA1;
> -            digest_len = SHA_DIGEST_LENGTH;
> +            msg(msglevel, "ERROR: Setting %s not allowed. Option to verify "
> +                "fingerprint of certificate of peer certificate "
> +                "(--verify-hash or --peer-fingerprint) already set.",
> +                p[0]);
> +            goto err;

This will error out also when listing peer-fingerprint (or verify-hash)
twice.
It would be the first option in openvpn to behave this way. Do we really
want that?
It may be better to have some flag and complain when the two options are
used together.


In any case, why not allowing to use these two options together?
If the peer cert is not self-signed, we could still be willing to check
the CA *and* also filter which peer-certificate we accept.


>          }
> -        else if (p[2] && !streq(p[2], "SHA256"))
> +
> +        if (streq(p[0], "verify-hash"))
>          {
> -            msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
> -            goto err;
> +            /* verify level 1 cert, i.e. the CA that signed the leaf cert */
> +            options->verify_hash_depth = 1;
> +
> +            if (!p[2] || (p[2] && streq(p[2], "SHA1")))

(this may need rebasing on top of a - possibly - modified patch 1.)

> +            {
> +                options->verify_hash_algo = MD_SHA1;
> +                msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
> +                    "verify-hash is deprecated. You should switch to the "
> +                    "SHA256.");
> +                options->verify_hash_algo = SHA_DIGEST_LENGTH;
> +                digest_len = SHA_DIGEST_LENGTH;
> +            }
> +            else if (p[2] && !streq(p[2], "SHA256"))
> +            {
> +                msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
> +                goto err;
> +            }
>          }
>  
>          if (is_inline)
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index c0dbbd8a..eee6bd21 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -564,6 +564,7 @@ struct options
>      const char *remote_cert_eku;
>      struct verify_hash_list *verify_hash;
>      hash_algo_type verify_hash_algo;
> +    int verify_hash_depth;
>      unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
>  
>  #ifdef ENABLE_PKCS11
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 7ccfc0f8..3a07c3d3 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -283,6 +283,7 @@ struct tls_options
>      unsigned remote_cert_ku[MAX_PARMS];
>      const char *remote_cert_eku;
>      struct verify_hash_list *verify_hash;
> +    int verify_hash_depth;
>      hash_algo_type verify_hash_algo;
>      char *x509_username_field;
>  
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 73d14e01..ac5e6271 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -693,19 +693,18 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
>          goto cleanup;                   /* Reject connection */
>      }
>  
> -    /* verify level 1 cert, i.e. the CA that signed our leaf cert */
> -    if (cert_depth == 1 && opt->verify_hash)
> +    if (cert_depth == opt->verify_hash_depth && opt->verify_hash)
>      {
> -        struct buffer ca_hash = {0};
> +        struct buffer cert_fp = {0};
>  
>          switch (opt->verify_hash_algo)
>          {
>              case MD_SHA1:
> -                ca_hash = x509_get_sha1_fingerprint(cert, &gc);
> +                cert_fp = x509_get_sha1_fingerprint(cert, &gc);
>                  break;
>  
>              case MD_SHA256:
> -                ca_hash = x509_get_sha256_fingerprint(cert, &gc);
> +                cert_fp = x509_get_sha256_fingerprint(cert, &gc);
>                  break;
>  
>              default:
> @@ -725,8 +724,8 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
>  
>          while (current_hash)
>          {
> -            if (memcmp_constant_time(BPTR(&ca_hash), current_hash->hash,
> -                                     BLEN(&ca_hash)) == 0)
> +            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash,
> +                                     BLEN(&cert_fp)) == 0)
>              {
>                  hash_matched = true;
>              }
> @@ -735,7 +734,11 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
>  
>          if (!hash_matched)
>          {
> -            msg(D_TLS_ERRORS, "TLS Error: --tls-verify certificate hash verification failed");
> +            const char *hex_fp = format_hex_ex(BPTR(&cert_fp), BLEN(&cert_fp),
> +                                               0, 1, ":", &gc);
> +            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
> +                "certificate hash verification failed. (got "
> +                "fingerprint: %s", hex_fp);
>              goto cleanup;
>          }
>      }
> 


The rest look good. This change smartly relies on the generalization of
the verify-hash code (patch 1).


Cheers,

-- 
Antonio Quartulli

