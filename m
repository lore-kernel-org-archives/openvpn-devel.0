MIME-Version: 1.0
In-Reply-To: <1465016263-23048-1-git-send-email-selva.nair@...277...>
References: <1465016263-23048-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 4 Jun 2016 09:24:45 +0200
Message-ID: <CAA1AbxJaF0XLZExmL1U8OhE=_xh0bhqunO2XHfojsq2miB-RDQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix the comparison of pull options hash
 on restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sat, Jun 4, 2016 at 6:57 AM, Selva Nair <selva.nair@...277...> wrote:
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 42baf97..4b044f4 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1717,7 +1717,7 @@ options_hash_changed_or_zero(const struct md5_digest *a,
>  {
>    const struct md5_digest zero = {{0}};
>    return memcmp (a, b, sizeof(struct md5_digest)) ||
> -      memcmp (a, &zero, sizeof(struct md5_digest));
> +      !memcmp (a, &zero, sizeof(struct md5_digest));
>  }
>  #endif /* P2MP */

ACK, this is clearly how it was intended, and how the code behaved
before 827de237.

Sorry for breaking this. A clear example why we need more (unit) tests...

-Steffan

