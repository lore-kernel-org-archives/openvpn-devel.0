Message-ID: <5471DD0F.5040403@...1856...>
Date: Sun, 23 Nov 2014 14:11:43 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1416745303-23641-1-git-send-email-yegorslists@...1030...>
In-Reply-To: <1416745303-23641-1-git-send-email-yegorslists@...1030...>
Subject: Re: [Openvpn-devel] [PATCH] polarssl: fix unreachable code
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

ACK. Harmless, but definitely an oversight.

-Steffan

On 23-11-14 13:21, Yegor Yefremov wrote:
> Found via cppcheck and compile-tested.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
> ---
>  src/openvpn/ssl_polarssl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
> index b026a17..2036885 100644
> --- a/src/openvpn/ssl_polarssl.c
> +++ b/src/openvpn/ssl_polarssl.c
> @@ -846,8 +846,8 @@ key_state_write_plaintext (struct key_state_ssl *ks, struct buffer *buf)
>  
>    if (0 == buf->len)
>      {
> -      return 0;
>        perf_pop ();
> +      return 0;
>      }
>  
>    retval = ssl_write(ks->ctx, BPTR(buf), buf->len);
> 

