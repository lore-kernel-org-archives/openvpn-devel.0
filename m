Message-ID: <4A8C20AA.9030708@...41...>
Date: Wed, 19 Aug 2009 08:56:26 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <20090807094401.GA11504@...33...>
In-Reply-To: <20090807094401.GA11504@...33...>
Subject: Re: [Openvpn-devel] PATCH 2.1-RC*: critical fix for FreeBSD 8 in
 topology subnet mode.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, Stefan Bethke <stb@...1247...>, James Yonan <jim@...41...>

Thanks Stefan and Matthias.  I've committed the patch.

James

Matthias Andree wrote:
> Hi Jim,
> 
> there has been a recent change in FreeBSD 8 BETA that will break OpenVPN
> 2.1's "topology subnet" mode by (rightfully!) rejecting the ifconfig
> command we're currently using (which incorrectly sets the local and
> remote P2P IPv4 addresses to be the same, the FreeBSD 8 kernel will
> reject that.)
> 
> FreeBSD's TUN interface can be switched from P2P to broadcast mode
> however, which we will need to leverage in order to support subnet
> topology.
> 
> Stefan Bethke (in CC) has written, revised and tested an OpenVPN patch
> that works on all currently supported FreeBSD 6.X and 7.X versions and
> also the upcoming FreeBSD 8.0. The patch makes sure that the tun
> interface is switched to broadcast mode and configured appropriately.
> 
> Find it inlined below for easier review and also attached.
> 
> Please apply!
> 
> Thank you.
> 
> Best regards
> Matthias
> OpenVPN packager for FreeBSD ports
> 
> --- /home/stb/tun.c.orig	2009-08-05 14:25:55.204943408 +0200
> +++ tun.c	2009-08-05 17:57:51.886753309 +0200
> @@ -863,11 +863,10 @@
>        else {
>  	if (tt->topology == TOP_SUBNET)
>              argv_printf (&argv,
> -                              "%s %s %s %s netmask %s mtu %d up",
> +                              "%s %s %s netmask %s mtu %d up",
>                                IFCONFIG_PATH,
>                                actual,
>                                ifconfig_local,
> -                              ifconfig_local,
>                                ifconfig_remote_netmask,
>                                tun_mtu
>                                );
> @@ -1745,14 +1744,19 @@
>  {
>    open_tun_generic (dev, dev_type, dev_node, ipv6, true, true, tt);
>  
> -  if (tt->fd >= 0)
> +  if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
>      {
>        int i = 0;
>  
> -      /* Disable extended modes */
> -      ioctl (tt->fd, TUNSLMODE, &i);
> +      i = tt->topology == TOP_SUBNET ? IFF_BROADCAST : IFF_POINTOPOINT;
> +      i |= IFF_MULTICAST;
> +      if (ioctl (tt->fd, TUNSIFMODE, &i) < 0) {
> +	msg (M_WARN | M_ERRNO, "ioctl(TUNSIFMODE): %s", strerror(errno));
> +      }
>        i = 1;
> -      ioctl (tt->fd, TUNSIFHEAD, &i);
> +      if (ioctl (tt->fd, TUNSIFHEAD, &i) < 0) {
> +	msg (M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
> +      }
>      }
>  }
>  
> 

