From: Steffan Karger <steffan@...1856...>
References: <20170115144330.1835-1-a@...2181...>
Message-ID: <82ec55bd-f475-b0a8-3e7e-bf6c54176d56@...1856...>
Date: Sun, 22 Jan 2017 17:31:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170115144330.1835-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

One more real comment and two nitpicks:

On 15-01-17 15:43, Antonio Quartulli wrote:
> @@ -3233,39 +3258,63 @@ options_postprocess_filechecks(struct options *options)
>
> [...]
>
> +    errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE,
> +                                         options->cert_file, R_OK, "--cert");

This line has 1 indent too many.

> +    errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
> +                                     options->extra_certs_file, R_OK,
> +                                     "--extra-certs");

I think the second one should be options->extra_certs_file_inline?

> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -542,7 +542,7 @@ tls_version_parse(const char *vstr, const char *extra)
>   */
>  static void
>  tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
> -                   const char *crl_file_inline)
> +                   bool crl_file_inline)

The doxygen string of the crl_file_inline parameter needs to be updated
too (like you did in the header file for the non-static functions).

Apart from these I am ready to give this an ACK.

-Steffan

