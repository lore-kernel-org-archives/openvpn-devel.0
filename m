Message-ID: <51800C0B.3010001@...1114...>
Date: Tue, 30 Apr 2013 20:23:07 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20130428113214.GO20843@...1296...>
	<1367159559-22947-1-git-send-email-arne@...1227...>
In-Reply-To: <1367159559-22947-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2NNACCATJWOKGSEEQFFXI"
Subject: Re: [Openvpn-devel] [Patch v4 1/4] Allow routes to be set before
 opening tun, similar to ifconfig before opening tun
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NNACCATJWOKGSEEQFFXI
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 28/04/13 16:32, Arne Schwabe wrote:
> ---
>  src/openvpn/init.c |   13 ++++++++++---
>  src/openvpn/tun.h  |   11 +++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 979ba23..33725e2 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1428,7 +1428,14 @@ do_open_tun (struct context *c)
>  						&gc);
>  	  do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.=
es);
>  	}
> -
> +=20=20=20=20=20=20
> +      /* possibly add routes */
> +      if (route_order() =3D=3D ROUTE_BEFORE_TUN) {
> +        /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignore=
d */
> +        do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
> +                  c->c1.tuntap, c->plugins, c->c2.es);
> +      }
> +=20=20=20=20=20=20
>        /* open the tun device */
>        open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
>  		c->c1.tuntap);
> @@ -1460,7 +1467,7 @@ do_open_tun (struct context *c)
>  		   c->c2.es);
>=20=20
>        /* possibly add routes */
> -      if (!c->options.route_delay_defined)
> +      if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
>  	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
>  		  c->c1.tuntap, c->plugins, c->c2.es);
>=20=20
> @@ -1668,7 +1675,7 @@ do_up (struct context *c, bool pulled_options, unsi=
gned int option_types_found)
>  #endif
>=20=20
>  	  /* if --route-delay was specified, start timer */
> -	  if (c->options.route_delay_defined)
> +	  if ((route_order() =3D=3D ROUTE_AFTER_TUN) && c->options.route_delay_=
defined)
>  	    {
>  	      event_timeout_init (&c->c2.route_wakeup, c->options.route_delay, =
now);
>  	      event_timeout_init (&c->c2.route_wakeup_expire, c->options.route_=
delay + c->options.route_delay_window, now);
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index c3fc62e..63e4b5c 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -297,6 +297,17 @@ ifconfig_order(void)
>  #endif
>  }
>=20=20
> +#define ROUTE_BEFORE_TUN 0
> +#define ROUTE_AFTER_TUN 1
> +#define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
> +
> +static inline int
> +route_order(void)
> +{
> +    return ROUTE_ORDER_DEFAULT;
> +}

I remember we discussed this oddity a long time ago, but I acknowledge
this is the "coding style" used with ifconfig_order().  We could
probably solve this in a cleaner way avoiding calling a function to get
a constant returned (even though, I hope the compiler optimises this).

Other than that, I presume this is well tested code which has been a
part of the OpenVPN for Android for a while, and I otherwise think the
code looks sane.


--=20
kind regards,

David Sommerseth


------enig2NNACCATJWOKGSEEQFFXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGADAsACgkQDC186MBRfroa5gCfem6W0A0wVAYsHQxoxgxMo1IO
iHQAnjALT9pWZFRevUZ0KQsxlNsm1vxh
=N68F
-----END PGP SIGNATURE-----

------enig2NNACCATJWOKGSEEQFFXI--

