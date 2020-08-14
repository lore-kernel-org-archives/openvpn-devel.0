From: tincanteksup <tincanteksup@...277...>
References: <20200814080619.2108-1-arne@...1227...>
Message-ID: <aefeeda7-68ea-2269-c68a-cd1b8282dbbe@...277...>
Date: Fri, 14 Aug 2020 19:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200814080619.2108-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix client's poor man NCP fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I tested this patch and it does make --data-ciphers and 
--data-ciphers-fallback behave in their intended "fashion".

Unfortunately, the commit message is grammatically incorrect and also 
logically misleading.

The intended fashion is for --data-ciphers to recognise that the correct 
cipher *has* been chosen and use it accordingly.

And for --data-ciphers-fallback to *not*
> be used in situations other than no OCC cipher.


Reported-by: Richard Bonhomme <tincanteksup@...277...>
Tested-by: Richard Bonhomme <tincanteksup@...277...>


On 14/08/2020 09:06, Arne Schwabe wrote:
> OpenVPN 2.5 clients do not correctly do a fallback to the server server.
> This commit fixes that logic and also fixes --data-ciphers-fallback to
> be used in situations other than no OCC cipher.
> 
> To reproduce the error use a client with only --data-ciphers set against
> a server without NCP.
> 
>          OPTIONS ERROR: failed to negotiate cipher with server.
>          Add the server's cipher  ('AES-256-CBC') to --data-ciphers
>          (currently 'AES-256-CBC') if you want to connect to this server.
> 
> Reported by: Richard Bonhomme <tincanteksup@...277...>
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/ssl_ncp.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index f522b8f0..c9ab85ce 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -296,13 +296,14 @@ check_pull_client_ncp(struct context *c, const int found)
>       }
>       /* If the server did not push a --cipher, we will switch to the
>        * remote cipher if it is in our ncp-ciphers list */
> -    bool useremotecipher = tls_poor_mans_ncp(&c->options,
> -                                             c->c2.tls_multi->remote_ciphername);
> -
> +    if(tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
> +    {
> +        return true;
> +    }
>   
>       /* We could not figure out the peer's cipher but we have fallback
>        * enabled */
> -    if (!useremotecipher && c->options.enable_ncp_fallback)
> +    if (!c->c2.tls_multi->remote_ciphername && c->options.enable_ncp_fallback)
>       {
>           return true;
>       }
> 

