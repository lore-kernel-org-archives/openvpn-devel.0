Message-ID: <83bebc8e-6eb7-8359-af8b-840a8b168082@...1227...>
Date: Wed, 28 Dec 2022 12:50:33 +0100
MIME-Version: 1.0
References: <20221228110752.34060-1-frank@...2641...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221228110752.34060-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] options.c: fix format security error
 when compiling without optimization
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 28.12.22 um 12:07 schrieb Frank Lichtenheld:
> error: format not a string literal and no format arguments [-Werror=format-security]
>   2309 |     msg(M_USAGE, str);
> 
> Found by accident, since it only happens without optimization.
> Seems the compiler can figure out that this is harmless when
> thinking a bit harder about it. Fix anyway.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   src/openvpn/options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e454b2ac..7395019e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2306,7 +2306,7 @@ check_ca_required(const struct options *options)
>                               " or CA path (--capath)"
>   #endif
>                               " and/or peer fingerprint verification (--peer-fingerprint)";
> -    msg(M_USAGE, str);
> +    msg(M_USAGE, "%s", str);
>   }
>   
>   static void

Acked-By: Arne Schwabe <arne@...1227...>

