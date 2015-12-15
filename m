Message-ID: <566FD25F.7080804@...1147...>
Date: Tue, 15 Dec 2015 09:42:07 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1450131285-30182-1-git-send-email-steffan@...1856...>
In-Reply-To: <1450131285-30182-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Disable certificate notBefore/notAfter
 sanity check on OpenSSL < 1.0.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/12/15 23:14, Steffan Karger wrote:
> The SSL_CTX_get0_certificate() function I used in 091edd8e is available in
> OpenSSL 1.0.2+ only.  Older versions seem to not have a useful alternative.
> The remaining option would then be to create a cache for our parsed
> certificate, but that would mean adding more struct members and code for
> the select group of people that do use an up-to-date openvpn, but do not
> update their openssl.  I don't think that's worth it.  So just disable the
> code for older openssl versions.
I have code lying around for checking certificate dates for openssl 
v0.9.7+  ; you can find it here:
   https://www.nikhef.nl/~janjust/proxy-verify/

the function of interest is grid_asn1TimeToTimeT ; it was/is on my TODO 
list to convert this code into a similar patch - perhaps we can 
integrate the two?

cheers,

JJK


> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>   src/openvpn/ssl_openssl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 2b74818..4792b08 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -353,6 +353,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
>   void
>   tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
>   {
> +#if OPENSSL_VERSION_NUMBER >= 0x10002000L
>     int ret;
>     const X509 *cert = SSL_CTX_get0_certificate(ctx->ctx);
>   
> @@ -375,6 +376,7 @@ tls_ctx_check_cert_time (const struct tls_root_ctx *ctx)
>       {
>         msg (M_WARN, "WARNING: Your certificate has expired!");
>       }
> +#endif
>   }
>   
>   void


