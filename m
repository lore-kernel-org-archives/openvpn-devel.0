Message-ID: <4DD4F357.6040100@...1114...>
Date: Thu, 19 May 2011 12:39:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1305729501-500-1-git-send-email-xavier@...1461...>
In-Reply-To: <1305729501-500-1-git-send-email-xavier@...1461...>
Subject: Re: [Openvpn-devel] +++ route.c	2011-05-18 09:15:17.000000000 +0200
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Xavier Franquet <xavier@...1461...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


In addition to Gert's comments, I would like to see a complete commit
patch.  It seems you just did "git diff | git send-email", which makes this
patch more difficult to apply.

Please do a git commit -s to your local git tree (you have all rights to do
so, its all on your own computer) then do 'git format-patch HEAD~1' and
send the 0001-whatever-comes-here.patch via git send-email.

When doing git commit -s, you need to put in an explanation/comment to your
commit.  First a short one-line summary, a blank line and a more verbose
description of why this change is needed.

But you might want to get answer Gert's comment before submitting a new patch.


Kind regards,

David Sommerseth


On 18/05/11 16:38, Xavier Franquet wrote:
>    if (!r->defined)
>      return;
> @@ -1113,23 +1114,26 @@ add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const s
>  
>  #if defined(TARGET_LINUX)
>  #ifdef CONFIG_FEATURE_IPROUTE
> -  argv_printf (&argv, "%s route add %s/%d via %s",
> +  argv_printf (&argv, "%s route add %s/%d via %s dev %s",
>    	      iproute_path,
>  	      network,
>  	      count_netmask_bits(netmask),
> -	      gateway);
> +	      gateway,
> +	      device);
>    if (r->metric_defined)
>      argv_printf_cat (&argv, "metric %d", r->metric);
>  
>  #else
> -  argv_printf (&argv, "%s add -net %s netmask %s gw %s",
> +  argv_printf (&argv, "%s add -net %s netmask %s gw %s dev %s",
>  		ROUTE_PATH,
>  	      network,
>  	      netmask,
> -	      gateway);
> +	      gateway,
> +	      device);
>    if (r->metric_defined)
>      argv_printf_cat (&argv, "metric %d", r->metric);
>  #endif  /*CONFIG_FEATURE_IPROUTE*/
> +
>    argv_msg (D_ROUTE, &argv);
>    status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
>  
> @@ -1452,6 +1456,7 @@ delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags
>    const char *network;
>    const char *netmask;
>    const char *gateway;
> +  const char *device = tt->actual_name;
>  
>    if (!r->defined)
>      return;
> @@ -1465,16 +1470,18 @@ delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags
>  
>  #if defined(TARGET_LINUX)
>  #ifdef CONFIG_FEATURE_IPROUTE
> -  argv_printf (&argv, "%s route del %s/%d",
> +  argv_printf (&argv, "%s route del %s/%d dev %s",
>    	      iproute_path,
>  	      network,
> -	      count_netmask_bits(netmask));
> +	      count_netmask_bits(netmask),
> +	      device);
>  #else
>  
> -  argv_printf (&argv, "%s del -net %s netmask %s",
> +  argv_printf (&argv, "%s del -net %s netmask %s dev %s",
>  		ROUTE_PATH,
>  	      network,
> -	      netmask);
> +	      netmask,
> +	      device);
>  #endif /*CONFIG_FEATURE_IPROUTE*/
>    if (r->metric_defined)
>      argv_printf_cat (&argv, "metric %d", r->metric);
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3U81UACgkQDC186MBRfroMHwCgirtiLfD2eYx4kUd36m5URLAb
nUUAn05ktAbALzn21y5miaclKtMSs8tH
=j4/1
-----END PGP SIGNATURE-----

