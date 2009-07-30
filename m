Message-Id: <9075ED2D-8ABB-4462-B0F3-48CCE5AF129E@...1247...>
From: Stefan Bethke <stb@...1247...>
In-Reply-To: <op.uxvfpabu1e62zd@...33...>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 30 Jul 2009 10:47:40 +0200
References: <B4AA014B-2444-40AA-A3A3-417E4B89DF90@...1247...>
	<4A709126.5050102@...1248...>
	<3A1518B9-2C8C-4F05-9195-82C6017E4902@...1247...>
	<op.uxusbswp1e62zd@...33...>
	<BEE762CA-4282-4BA8-B92B-AFC7AAE3CA9A@...1247...>
	<op.uxvfpabu1e62zd@...33...>
Subject: Re: [Openvpn-devel] recent change to ifconfig breaks OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: OpenVPN Developer Mailing List <Openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

I'm leaving off freebsd-current, since I believe the problem is in  
OpenVPN's tun.c, as pointed out by Matthias below.

Some background on my issue: FreeBSD 8.0-beta2 has apparently  
introduced a change where the previously working ifconfig invocation  
is now failing.  I'm leaving out the discussion on what exactly that  
change is and if this effect is desired or not, but concentrate on  
what OpenVPN is trying to do. We're strictly talking --topology subnet  
here. tap's are not affected.  I haven't tested any other topology.

As can be seen in the commit below, ifconfig is invoked with both the  
local and the remote IP address set to the server-assigned local  
address.  If this code could be changed to call ifconfig with the  
local address and the server's VPN address (I believe generally .1)  
things should be fine. (Also on earlier versions of FreeBSD.)  It  
might be necessary to install an explicit route for the subnet, since  
FreeBSD will only install a host route for the remote end of the point- 
to-point link.  Please note that FreeBSD's tun interface is always in  
point-to-point mode, and cannot be configured as a broadcast interface.

A cursory read of tun.c and tun.h shows that struct tuntap doesn't  
have the server's VPN address, and it appears the server does not push  
it.  Is this available somewhere, or would it be OK to calculate it?   
(First address in the cidr block the local address is in modulo the  
netmask.)


Thanks,
Stefan

Am 30.07.2009 um 10:11 schrieb Matthias Andree:

> And it appears that exactly this patch may be the culprit. This is  
> from the OpenVPN 2.1 source repository:
>
> ------------------------------------------------------------------------
> r986 | james | 2006-04-05 08:28:19 +0200 (Wed, 05 Apr 2006) | 2 lines
> Changed paths:
>   M /branches/BETA21/openvpn/tun.c
>
> "topology subnet" fix for FreeBSD (Benoit Bourdin).
>
> ------------------------------------------------------------------------
>
> Index: tun.c
> ===================================================================
> --- tun.c	(Revision 985)
> +++ tun.c	(Revision 986)
> @@ -795,19 +795,42 @@
> 			  ifconfig_remote_netmask,
> 			  tun_mtu
> 			  );
> -      else
> -	openvpn_snprintf (command_line, sizeof (command_line),
> +      else {
> +	if (tt->topology == TOP_SUBNET)
> +            openvpn_snprintf (command_line, sizeof (command_line),
> +                              IFCONFIG_PATH " %s %s %s netmask %s  
> mtu %d up",
> +                              actual,
> +                              ifconfig_local,
> +                              ifconfig_local,
> +                              ifconfig_remote_netmask,
> +                              tun_mtu
> +                              );
> +	else
> +  	    openvpn_snprintf (command_line, sizeof (command_line),
> 			  IFCONFIG_PATH " %s %s netmask %s mtu %d up",
> 			  actual,
> 			  ifconfig_local,
> 			  ifconfig_remote_netmask,
> 			  tun_mtu
> 			  );
> +      }
> 	
>       msg (M_INFO, "%s", command_line);
>       system_check (command_line, es, S_FATAL, "FreeBSD ifconfig  
> failed");
>       tt->did_ifconfig = true;
>
> +	/* Add a network route for the local tun interface */
> +      if (!tun && tt->topology == TOP_SUBNET)
> +        {
> +          struct route r;
> +          CLEAR (r);
> +          r.defined = true;
> +          r.network = tt->local & tt->remote_netmask;
> +          r.netmask = tt->remote_netmask;
> +          r.gateway = tt->local;
> +          add_route (&r, tt, 0, es);
> +        }
> +
> #elif defined (WIN32)
>       {
> 	/*
>
>
> -- 
> Matthias Andree

-- 
Stefan Bethke <stb@...1247...>   Fon +49 151 14070811


