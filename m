Message-ID: <443EB57C.2080801@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Stick routes to interfaces for Linux
References: <200604072030.52833.uberlord@...594...>
In-Reply-To: <200604072030.52833.uberlord@...594...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 13 13:34:03 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Roy Marples <uberlord@...594...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Roy Marples wrote:
> Hi List!
>
> In some instances, Linux requires routes being stuck to interfaces instead of 
> floating. Mainly in virtual environments like Xen and Qemu.
>
> Attached is a patch that addresses this issue.
>
> Thanks
>
>   
> ------------------------------------------------------------------------
>
> --- openvpn-2.0.6/route.c	2006-04-07 14:59:40.311648814 +0100
> +++ openvpn-2.0.6/route.c	2006-04-07 14:57:28.860077986 +0100
> @@ -685,18 +685,20 @@ add_route (struct route *r, const struct
>  
>  #if defined(TARGET_LINUX)
>  #ifdef CONFIG_FEATURE_IPROUTE
> -  buf_printf (&buf, IPROUTE_PATH " route add %s/%d via %s",
> +  buf_printf (&buf, IPROUTE_PATH " route add %s/%d via %s dev %s",
>  	      network,
>  	      count_netmask_bits(netmask),
> -	      gateway);
> +	      gateway,
> +	      tt->actual_name);
>    if (r->metric_defined)
>      buf_printf (&buf, " metric %d", r->metric);
>  
>  #else
> -  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s gw %s",
> +  buf_printf (&buf, ROUTE_PATH " add -net %s netmask %s gw %s dev %s",
>  	      network,
>  	      netmask,
> -	      gateway);
> +	      gateway,
> +	      tt->actual_name);
>    if (r->metric_defined)
>      buf_printf (&buf, " metric %d", r->metric);
>  #endif  /*CONFIG_FEATURE_IPROUTE*/
> @@ -792,7 +794,7 @@ add_route (struct route *r, const struct
>      buf_printf (&buf, " -rtt %d", r->metric);
>  #endif
>  
> -  buf_printf (&buf, " -net %s %s -netmask %s",
> +  buf_printf (&buf, " -net %s %s -netmask %s dev",
>  	      network,
>  	      gateway,
>  	      netmask);
> @@ -830,14 +832,16 @@ delete_route (const struct route *r, con
>  
>  #if defined(TARGET_LINUX)
>  #ifdef CONFIG_FEATURE_IPROUTE
> -  buf_printf (&buf, IPROUTE_PATH " route del %s/%d",
> +  buf_printf (&buf, IPROUTE_PATH " route del %s/%d dev %s",
>  	      network,
> -	      count_netmask_bits(netmask));
> +	      count_netmask_bits(netmask),
> +	      tt->actual_name);
>  #else
>  
> -  buf_printf (&buf, ROUTE_PATH " del -net %s netmask %s",
> +  buf_printf (&buf, ROUTE_PATH " del -net %s netmask %s dev %s",
>  	      network,
> -	      netmask);
> +	      netmask,
> +	      tt->actual_name);
>  #endif /*CONFIG_FEATURE_IPROUTE*/
>    if (r->metric_defined)
>      buf_printf (&buf, " metric %d", r->metric);
>   

Roy,

What about the case where you don't want to associate a route with the 
tun/tap interface, such as when you're doing the routing dance to make 
--redirect-gateway work?

James


