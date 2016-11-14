References: <20161110082152.98252-1-gert@...1296...>
	<20161113195228.74090-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4d3890eb-f8c2-206c-6f66-bfca02ae2d68@...1856...>
Date: Mon, 14 Nov 2016 21:27:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161113195228.74090-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Replace WIN32 by _WIN32
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-11-16 20:52, Gert Doering wrote:
> With c99, "WIN32" is no longer automatically defined when (cross-)building
> for Windows, and proper compilation relies on including <windefs.h>,
> before checking the macro.  "_WIN32" is the official define that is
> guaranteed to be defined by the compiler itself, no includes are needed.
> 
> So, mechanically change all occurrances of "WIN32" to "_WIN32".
> 
> While at it, get rid of unused WIN32_0_1 #define in syshead.h
> 
> See also: http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system#WindowsCygwinnonPOSIXandMinGW
> 
> Trac #746
> 
> v2: rebased to master, merge the console[_builtin].c changes
> 
> [...snip...]
>
> diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
> index a61f03a..726a621 100644
> --- a/src/openvpn/ssl_backend.h
> +++ b/src/openvpn/ssl_backend.h
> @@ -232,7 +232,7 @@ int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
>   */
>  #ifdef ENABLE_CRYPTOAPI
>  void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert);
> -#endif /* WIN32 */
> +#endif /* _WIN32 */
>  
>  /**
>   * Load certificate file into the given TLS context. If the given certificate
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index a6c90b1..d0dee9a 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -283,7 +283,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
>  {
>    msg(M_FATAL, "Windows CryptoAPI not yet supported for mbed TLS.");
>  }
> -#endif /* WIN32 */
> +#endif /* _WIN32 */
>  
>  void
>  tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 8909ca3..6540422 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -633,7 +633,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
>    if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
>      crypto_msg (M_FATAL, "Cannot load certificate \"%s\" from Microsoft Certificate Store", cryptoapi_cert);
>  }
> -#endif /* WIN32 */
> +#endif /* _WIN32 */
>  
>  static void
>  tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)

These should actually be "#endif /* ENABLE_CRYPTOAPI */".

Other than that, ACK.

-Steffan

