From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 17 Oct 2016 11:46:56 +0200
Message-ID: <3759203.s4ImD1Di7C@...1526...>
In-Reply-To: <20161009152550.GQ78279@...1296...>
References: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
	<20161009150659.GP78279@...1296...>
	<20161009152550.GQ78279@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Sonntag, 9. Oktober 2016 17:25:50 CEST Gert Doering wrote:
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 4a11d10..1250547 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -1373,11 +1373,13 @@ do_ifconfig (struct tuntap *tt,
>  	else
>  	  {
>  	    /* example: netsh interface ipv6 set address interface=42
> 2001:608:8003::d store=active */ +	    char iface[64];
> +	    openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
> tt->adapter_index ); argv_printf (&argv,
> -			 "%s%sc interface ipv6 set address interface=%lu %s store=active",
> +			 "%s%sc interface ipv6 set address %s %s store=active",
>  			 get_win_sys_path(),
>  			 NETSH_PATH_SUFFIX,
> -			 tt->adapter_index,
> +			 iface,
>  			 ifconfig_ipv6_local );
>  	    netsh_command (&argv, 4, M_FATAL);
>  	  }
> 
> I've done a "v2" of Heiko's patch with that change included, which I'll
> append below.  Samuli, could you build us a windows installer with master
> plus that patch, for "windows early alpha testing"?  If that change
> works for people, we are very close to 2.4_alpha1...

ACK for the partial rollback.

Shakes fist at argv_printf(). =)

Thanks Gert

