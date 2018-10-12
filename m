Reply-To: openvpn-devel@lists.sourceforge.net
References: <20181011220639.7316-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <40a60bc4-eb11-1d5e-cf45-be328b7a3e5e@...2080...>
Date: Fri, 12 Oct 2018 12:38:45 +0200
MIME-Version: 1.0
In-Reply-To: <20181011220639.7316-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Use right function to set TLS1.3
 restrictions in show-tls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 12/10/18 00:06, Arne Schwabe wrote:
> The last version of the patch used the TLS1.2 version
> tls_ctx_restrict_ciphers to set the restrictions for both
> TLS 1.3 and TLS1.2 instead of using tls_ctx_restrict_ciphers_tls13
> for TLS1.3.
> 
> Also fix minor style problem while I am touching the function
> ---
>  src/openvpn/ssl_openssl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 6717ded0..da573cfa 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2002,15 +2002,16 @@ show_available_tls_ciphers_list(const char *cipher_list,
>      if (tls13)
>      {
>          SSL_CTX_set_min_proto_version(tls_ctx.ctx, TLS1_3_VERSION);
> +        tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);

Isn't this function only available in OpenSSL 1.1.1 and newer?  Or am I
missing a fine detail here?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


