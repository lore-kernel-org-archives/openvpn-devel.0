References: <20171111133649.20192-1-gert@...1296...>
 <20171111142230.3288-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ecf65f3a-7439-2521-5d56-d907b2207600@...1227...>
Date: Sat, 11 Nov 2017 15:24:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171111142230.3288-1-gert@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2] Remove warning on pushed tun-ipv6
 option.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 11.11.17 um 15:22 schrieb Gert Doering:
> tun-ipv6 is a no-op nowadays, and we print a warning to let users know -
> which is not helpful for server-pushed tun-ipv6 (which might be the
> result of --server-ipv6 automatically pushing this).  So, remove the
> warning if parsing pushed options.
> 
> Also, remove the VERIFY_PERMISSION() call here which has side effects
> on the "which class of options got pushed, do we need to act on them
> later on?" flag set.
> 
> v2: use existing pull_mode flag
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 641a26e2..4caa2cd1 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5233,8 +5233,10 @@ add_option(struct options *options,
>      }
>      else if (streq(p[0], "tun-ipv6") && !p[1])
>      {
> -        VERIFY_PERMISSION(OPT_P_UP);
> -        msg(M_WARN, "Note: option tun-ipv6 is ignored because modern operating systems do not need special IPv6 tun handling anymore.");
> +        if ( !pull_mode )
> +        {
> +            msg(M_WARN, "Note: option tun-ipv6 is ignored because modern operating systems do not need special IPv6 tun handling anymore.");
> +        }
>      }
>  #ifdef ENABLE_IPROUTE
>      else if (streq(p[0], "iproute") && p[1] && !p[2])
> 

Acked-by: Arne


The code looks right but I have not compile tested it.

Arne

