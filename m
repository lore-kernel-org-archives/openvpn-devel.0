Message-ID: <4FCA40E3.8000205@...1114...>
Date: Sat, 02 Jun 2012 18:35:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-7-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-7-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 6/8] Allow routes to be set before
 opening tun, similar to ifconfig before opening tun
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


See comments below.

On 02/06/12 15:03, Arne Schwabe wrote:
> 
> Signed-off-by: Arne Schwabe <arne@...1227...> --- 
> src/openvpn/init.c |   11 +++++++++-- src/openvpn/tun.h  |   11
> +++++++++++ 2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c index
> 61ced5d..a25de5d 100644 --- a/src/openvpn/init.c +++
> b/src/openvpn/init.c @@ -1478,6 +1478,13 @@ do_open_tun (struct
> context *c) do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE
> (&c->c2.frame), c->c2.es); }
> 
> +      /* possibly add routes */ +      if(ifconfig_order() ==
> ROUTE_BEFORE_TUN) { +		  /* Ignore route_delay, would cause
> ROUTE_BEFORE_TUN to be ignored */ +		  do_route (&c->options,
> c->c1.route_list, c->c1.route_ipv6_list, +					c->c1.tuntap,
> c->plugins, c->c2.es); +    } + /* open the tun device */ open_tun
> (c->options.dev, c->options.dev_type, c->options.dev_node, 
> c->c1.tuntap); @@ -1509,7 +1516,7 @@ do_open_tun (struct context
> *c) c->c2.es);
> 
> /* possibly add routes */ -      if
> (!c->options.route_delay_defined) +      if ((ifconfig_order() ==
> ROUTE_AFTER_TUN) && (!c->options.route_delay_defined)) do_route
> (&c->options, c->c1.route_list, c->c1.route_ipv6_list, 
> c->c1.tuntap, c->plugins, c->c2.es);
> 
> @@ -1717,7 +1724,7 @@ do_up (struct context *c, bool
> pulled_options, unsigned int option_types_found) #endif
> 
> /* if --route-delay was specified, start timer */ -	  if
> (c->options.route_delay_defined) +	  if ((ifconfig_order() ==
> ROUTE_AFTER_TUN) && c->options.route_delay_defined) { 
> event_timeout_init (&c->c2.route_wakeup, c->options.route_delay,
> now); event_timeout_init (&c->c2.route_wakeup_expire,
> c->options.route_delay + c->options.route_delay_window, now); diff
> --git a/src/openvpn/tun.h b/src/openvpn/tun.h index
> 9bd990f..60d75c8 100644 --- a/src/openvpn/tun.h +++
> b/src/openvpn/tun.h @@ -297,6 +297,17 @@ ifconfig_order(void) 
> #endif }
> 
> +#define ROUTE_BEFORE_TUN 0 +#define ROUTE_AFTER_TUN 1 +#define
> ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN + +static inline int 
> +route_order(void) +{ +    return ROUTE_ORDER_DEFAULT; +}

Is there any reason why it is an advantage of calling a function
returning a macro value, instead of just redefine the
ROUTE_ORDER_DEFAULT macro for those platforms who need ROUTE_AFTER_TUN
and use the ROUTE_ORDER_DEFAULT macro directly where needed?

And for type-safety, would it be better to use an typedef enum instead?


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/KQOMACgkQDC186MBRfrr7vgCdGqn+OtLv5A0pI6bghIX+IQSQ
8RcAn0zxo+W13KLq0Y8wkHuTsQUZ8eh6
=nlce
-----END PGP SIGNATURE-----

