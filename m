References: <20161108124506.32559-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3b549df6-9fd6-adb4-4cb4-2a8a8e8198e6@...1856...>
Date: Wed, 9 Nov 2016 20:30:12 +0100
MIME-Version: 1.0
In-Reply-To: <20161108124506.32559-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Repair topology subnet on FreeBSD 11
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

Hi,

On 08-11-16 13:45, Gert Doering wrote:
> We used to add "route for this subnet" by using our own address as
> the gateway address, which used to mean "connected to the interface,
> no gateway".  FreeBSD commit 293159 changed the kernel side of that
> assumption so "my address" is now always bound to "lo0" - thus, our
> subnet route also ended up pointing to "lo0", breaking connectivity
> for all hosts in the subnet except the one we used as "remote".
> 
> commit 60fd44e501f200 already introduced a "remote address" we use
> for the "ifconfig tunX <us> <remote>" part - extend that to be used
> as gateway address for the "tunX subnet" as well, and things will
> work more robustly.
> 
> Tested on FreeBSD 11.0-RELEASE and 7.4-RELEASE (client and server)
> (this particular issue is not present before 11.0, but "adding the
> subnet route" never worked right, not even in 7.4 - 11.0 just made
> the problem manifest more clearly)
> 
> Trac #425
> URL: https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=207831
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index af685de..a6d38d5 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -721,8 +721,8 @@ void delete_route_connected_v6_net(struct tuntap * tt,
>   * is still point to point and no layer 2 resolution is done...
>   */
>  
> -const char *
> -create_arbitrary_remote( struct tuntap *tt, struct gc_arena * gc )
> +in_addr_t
> +create_arbitrary_remote( struct tuntap *tt )
>  {
>    in_addr_t remote;
>  
> @@ -730,7 +730,7 @@ create_arbitrary_remote( struct tuntap *tt, struct gc_arena * gc )
>  
>    if ( remote == tt->local ) remote ++;
>  
> -  return print_in_addr_t (remote, 0, gc);
> +  return remote;
>  }
>  #endif
>  
> @@ -1230,6 +1230,8 @@ do_ifconfig (struct tuntap *tt,
>  
>  #elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
>  
> +      in_addr_t remote_end;		/* for "virtual" subnet topology */
> +
>        /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
>        if (tun)
>  	argv_printf (&argv,
> @@ -1242,12 +1244,13 @@ do_ifconfig (struct tuntap *tt,
>  			  );
>        else if ( tt->topology == TOP_SUBNET )
>  	{
> +	    remote_end = create_arbitrary_remote( tt );
>  	    argv_printf (&argv,
>  			  "%s %s %s %s mtu %d netmask %s up",
>  			  IFCONFIG_PATH,
>  			  actual,
>  			  ifconfig_local,
> -			  create_arbitrary_remote( tt, &gc ),
> +			  print_in_addr_t (remote_end, 0, &gc),
>  			  tun_mtu,
>  			  ifconfig_remote_netmask
>  			  );
> @@ -1274,7 +1277,7 @@ do_ifconfig (struct tuntap *tt,
>            r.flags = RT_DEFINED;
>            r.network = tt->local & tt->remote_netmask;
>            r.netmask = tt->remote_netmask;
> -          r.gateway = tt->local;
> +          r.gateway = remote_end;
>            add_route (&r, tt, 0, NULL, es);
>          }
>  

Code-ACK.

I didn't test (no freebsd for me), but Gert did, and the pfsense guys
(garga, in particular) reported this patch resolves their issue in #425.

-Steffan

