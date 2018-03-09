MIME-Version: 1.0
In-Reply-To: <20180308200848.5908-1-steffan@...1856...>
References: <CAKuzo_gvG3_Xz0qdHEyVOaEAB2CfSA3GNj7jYwHBkEb-kTMPLA@...278...>
 <20180308200848.5908-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 8 Mar 2018 22:38:05 -0500
Message-ID: <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve management-external-key/cert
 error handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I wanted to give this a quick test, but it doesn't apply.

It seems you have patch 116 (Antonio's "inline-tag changed to bool"
patch) in your local repo.

By the way, the M_FATAL after management_query_cert() looks like a
regression. One problem with these FATAL exits is that it makes it
hard for the GUI to gracefully handle when user presses cancel on some
dialogs. Anyway that's beyond this patch... So just saying..

On Thu, Mar 8, 2018 at 3:08 PM, Steffan Karger <steffan@...1856...> wrote:
> Check the return values of management_query_cert() and
> tls_ctx_use_external_private_key(), and error out with a more descriptive
> error message.  To do so, we make the openssl-backed implementation of
> tls_ctx_use_external_private_key() not throw fatal error anymore.
>
> (And fix line wrapping while touching this code.)
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: error out with M_FATAL as suggested by Selva.
>
>  src/openvpn/ssl.c         | 28 ++++++++++++++++++++--------
>  src/openvpn/ssl_openssl.c |  2 +-
>  2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 1756f8a2..1882db52 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -660,18 +660,30 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
>      else if ((options->management_flags & MF_EXTERNAL_KEY)
>               && (options->cert_file || options->management_flags & MF_EXTERNAL_CERT))
>      {
> -        if (options->cert_file)
> +        if (options->cert_file
> +            && 0 != tls_ctx_use_external_private_key(new_ctx,
> +                                                     options->cert_file,
> +                                                     options->cert_file_inline))
>          {
> -            tls_ctx_use_external_private_key(new_ctx, options->cert_file,
> -                                             options->cert_file_inline);
> +            msg(M_FATAL, "Failed to initialize management-external-key");
>          }
>          else
>          {
> -            char *external_certificate = management_query_cert(management,
> -                                                               options->management_certificate);
> -            tls_ctx_use_external_private_key(new_ctx, external_certificate,
> -                                             true);
> -            free(external_certificate);
> +            char *external_cert = management_query_cert(
> +                            management, options->management_certificate);
> +
> +            if (!external_cert)
> +            {
> +                msg(M_FATAL, "Failed to initialize management-external-cert");
> +            }
> +
> +            if (0 != tls_ctx_use_external_private_key(new_ctx, external_cert,
> +                                                      true))
> +            {
> +                msg(M_FATAL, "Failed to initialize management-external-key");
> +            }
> +
> +            free(external_cert);
>          }
>      }
>  #endif
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 66d98c54..87f67680 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -1327,7 +1327,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>      return 0;
>
>  err:
> -    crypto_msg(M_FATAL, "Cannot enable SSL external private key capability");
> +    crypto_msg(M_WARN, "Cannot enable SSL external private key capability");
>      return 1;
>  }
>

Selva

