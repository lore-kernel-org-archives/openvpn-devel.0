Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180925124819.4005-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f5264ad9-f28c-cd7a-2b79-6a5536d0130e@...2080...>
Date: Tue, 25 Sep 2018 16:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180925124819.4005-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Add message explaining early TLS client
 hello failure
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

On 25/09/18 14:48, Arne Schwabe wrote:
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
> to fix the old Debian 8 clients.
> ---
>  src/openvpn/crypto_openssl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 9ec2048d..3360bb19 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -199,7 +199,15 @@ crypto_print_openssl_errors(const unsigned int flags)
>                  "in common with the client. Your --tls-cipher setting might be "
>                  "too restrictive.");
>          }
> -
> +        else if (ERR_GET_REASON(err) == SSL_R_UNSUPPORTED_PROTOCOL)
> +        {
> +            msg(D_CRYPT_ERRORS, "TLS error: Unsupported protocol. This typically "
> +                 "indicates that client and server have no common TLS version enabled. "
> +                 "This can be caused mismatched tls-version-min and tls-version-max options "
> +                 "on client and server. "
> +                 "If your client is 2.3.6 or older  consider adding tls-version 1.1"
> +                 "to the the configuration to use TLS 1.1+ instead of TLS 1.0 only");


Good advice in the log.  But should this be added in the local or remote
configuration?  It is the 2.3.6 reference which makes it confusing for me,
otherwise I would have interpreted this as the local side where this warning
occurs.  So this could be clearer.

I also think this should be mentioned in the man page as well.

And a little nitpick ... the version reference should be either "OpenVPN
2.3.6" or "v2.3.6", as discussed here:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15260.html>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


