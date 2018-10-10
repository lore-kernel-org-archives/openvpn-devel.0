References: <20180925124819.4005-1-arne@...1227...>
 <20180926120159.19874-1-arne@...1227...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <104c4eac-b716-0b91-faa7-cac3a77799e9@...1435...>
Date: Wed, 10 Oct 2018 10:17:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180926120159.19874-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Add message explaining early TLS
 client hello failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-09-18 14:01, Arne Schwabe wrote:
> In my tests an OpenSSL 1.1.1 server does not accept TLS 1.0 only clients
> anymore. Unfortunately, Debian 8 still has OpenVPN 2.3.4, which is
> TLS 1.0 only without setting tls-version-min.
> 
> We currently log only
> OpenSSL: error:14209102:SSL routines:tls_early_post_process_client_hello:unsupported protocol
> which indicates the right technical error but is not very helpful to a
> person without deep knowledge in SSL/TLS and OpenVPN's TLS version
> history.
> 
> This commit adds a hopefully helpful message and also tells users how
> to fix the old Debian 8 clients. The error message will be displayed on
> the server side only.
> 
> Note that connecting with an OpenSSL 1.1.1 client to a TLS 1.0 only
> server works fine.
> 
> This behaviour is also not specific to OpenVPN. Using an openssl s_client
> with the -tls1 option against an openssl s_server exhibits the same
> behaviour.
> 
> Patch V2: fixed message grammar, use tls-version-min 1.0 and clarify
> 2.3.6 and older to be actually between 2.3.2 and 2.3.6
> ---
>  src/openvpn/crypto_openssl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 9ec2048d..43d75b89 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -199,7 +199,16 @@ crypto_print_openssl_errors(const unsigned int flags)
>                  "in common with the client. Your --tls-cipher setting might be "
>                  "too restrictive.");
>          }
> -
> +        else if (ERR_GET_REASON(err) == SSL_R_UNSUPPORTED_PROTOCOL)
> +        {
> +            msg(D_CRYPT_ERRORS, "TLS error: Unsupported protocol. This typically "
> +                 "indicates that client and server have no common TLS version enabled. "
> +                 "This can be caused by mismatched tls-version-min and tls-version-max "
> +                 "options on client and server. "
> +                 "If your OpenVPN client is between v2.3.6 and v2.3.2 try adding "
> +                 "tls-version-min 1.0 to the client configuration to use TLS 1.0+ "
> +                 "instead of TLS 1.0 only");
> +        }
>          msg(flags, "OpenSSL: %s", ERR_error_string(err, NULL));
>      }
>  }
> 

Helpful message, patch looks good and passes the test suite. I didn't
manually test connecting with a tls 1.0-only client, but trust that you
have.

Acked-by: Steffan Karger <steffan.karger@...1435...>

-Steffan

