MIME-Version: 1.0
In-Reply-To: <499929A843E2C541A8AD31A881A2B6A202DAB58F@...1006...>
References: <499929A843E2C541A8AD31A881A2B6A202DAB58F@...1006...>
Date: Thu, 29 Jan 2009 13:45:49 +0200
Message-ID: <9e0cf0bf0901290345s15a32d2dm63a6ad7a3312d559@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix for "Cannot read current default
	gateway" problem on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: David Balazic <David.Balazic@...1005...>
Cc: openvpn-devel@lists.sourceforge.net

Some minor comments.
1. Please rebase against trunk.

On 1/29/09, David Balazic <David.Balazic@...1005...> wrote:
>  diff -u -r openvpn-2.1_rc15/route.c openvpn-2.1_rc15_gwfix/route.c
>  --- openvpn-2.1_rc15/route.c    2008-11-17 00:48:04.000000000 +0000
>  +++ openvpn-2.1_rc15_gwfix/route.c      2008-12-18 19:59:36.455394121 +0000
>  @@ -805,20 +814,26 @@
>
>   #if defined(TARGET_LINUX)
>   #ifdef CONFIG_FEATURE_IPROUTE
>  -  argv_printf (&argv, "%s route add %s/%d via %s",
>  +  argv_printf (&argv, "%s route add %s/%d",
>               iproute_path,
>               network,
>  -             count_netmask_bits(netmask),
>  -             gateway);
>  +             count_netmask_bits(netmask));
>  +  if (r->gateway)
>  +    argv_printf_cat (&argv, "via %s", gateway);
>  +  else
>  +    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
>    if (r->metric_defined)
>      argv_printf_cat (&argv, "metric %d", r->metric);
>
>   #else
>  -  argv_printf (&argv, "%s add -net %s netmask %s gw %s",
>  +  argv_printf (&argv, "%s add -net %s netmask %s",
>                 ROUTE_PATH,
>               network,
>  -             netmask,
>  -             gateway);
>  +             netmask);
>  +  if (r->gateway)
>  +    argv_printf_cat (&argv, "gw %s", gateway);
>  +  else
>  +    argv_printf_cat (&argv, "dev %s", r->gateway_ifname);
>    if (r->metric_defined)
>      argv_printf_cat (&argv, "metric %d", r->metric);
>   #endif  /*CONFIG_FEATURE_IPROUTE*/

2. Please declare a variable at the epilogue of the function as gateway.

>  @@ -1516,6 +1531,10 @@
>                   if (!net && !mask && metric < lowest_metric)
>                     {
>                       best_gw = gw;
>  +                     if (gw_if_name)
>  +                       {
>  +                         sscanf (line, "%s\t", gw_if_name);
>  +                       }
>                       lowest_metric = metric;
>                       best_count = count;
>                     }

3. Please don't use scanf this way as it may overflow the buffer.
Use %##s and check that overflow is avoided.

Alon.

