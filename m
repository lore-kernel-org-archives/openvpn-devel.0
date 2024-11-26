Date: Tue, 26 Nov 2024 15:37:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Z0XdGe24EBpmMUty@...1296...>
References: <20241126142639.67446-1-alex@...2837...>
 <20241126142639.67446-2-alex@...2837...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6fh+nlbcZC0fR/Q3"
Content-Disposition: inline
In-Reply-To: <20241126142639.67446-2-alex@...2837...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Haiku: Pull in routing table to get
 default route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alexander von Gluck <alex@...2837...>
Cc: openvpn-devel@lists.sourceforge.net

--6fh+nlbcZC0fR/Q3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 26, 2024 at 02:26:59PM +0000, Alexander von Gluck via Openvpn-d=
evel wrote:
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index fa20d08f..8d319123 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -54,6 +54,12 @@
>  #include <net/route.h>                  /* RT_ROUNDUP(), RT_ADVANCE() */
>  #endif
>=20=20
> +#if defined(TARGET_HAIKU)
> +#include <SupportDefs.h>    /* uint32, etc */
> +#include <net/if.h>         /* ifconf etc */
> +#include <sys/sockio.h>     /* SIOCGRTTABLE, etc */
> +#endif /* TARGET_HAIKU */
> +

System includes go to "syshead.h".

>  #ifdef _WIN32
>  #include "openvpn-msg.h"
>=20=20
> @@ -1857,14 +1863,16 @@ add_route(struct route_ipv4 *r,
>=20=20
>      {
>          /* ex: route add /dev/net/ipro1000/0 default gw 192.168.1.1 netm=
ask 255.255.255.0 */
> -        argv_printf(&argv, "route add %s inet default gw %s netmask %s",
> +        argv_printf(&argv, "%s add %s inet %s gw %s netmask %s",
> +                    ROUTE_PATH,
>                      rgi-
> >iface,
> +                    network,

Please squash this part into patch 1/2 - having one patch introduce
something new for #ifdef TARGET_HAIKU, only to have the next patch
modify the very same line is not helpful.

> +#elif defined(TARGET_HAIKU)
> +
> +    {
> +        // route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1=
 netmask 255.255.0.0

No // comments

At least adding/deleting of routes should be "in patch 1".

The get_default_gateway() part could, technically, go into its own patch
("it adds independent new functionality") - but since this all fairly
small, it can just be part of the single patch.

A few lines of README would be nice, if anything special is needed
to make OpenVPN work on HAIKU, with you patch ("you need to install
the tun/tap driver from $url, then reboot twice at midnight, and
off you go").

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6fh+nlbcZC0fR/Q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJnRd0ZAAoJEB2Cnv7KVigSwq8L/RfCO0m4edrYxJUmLBjLmpun
p5+BsQhcLTmRxIpq63I3VxiQdmq/A0+4vfhHZeyHN8ErQho9RQs5nC7u0SXLn0SY
2/zpyqGdTP69qN1v5FuubEfX9YwN2ntzwqcOffc1rMbbQdj/W0zmEnQ7RfR9OCMC
NHKGXXvEMC4m9/lR/UADzHoRbNIKM8MDEgLkCN1lA07SHI3J3y3Fk2HHJMLhjw9t
V8D3qOU0teyhP8JJrY5Mlu1H5ThlKQWOz/lGnYvFqaDM9W4LpEYN64zJymWaE74O
JA8GF5ULTSK3J/wm+r60d7PjPMLTRFoICsEp/YuQTbc1Rr03/a1xWL3jGVw2yffa
VmaVvrV+U+47mkzffYGl16oLG6avOiZT1Po7ifhuQgJuGIlgextD9VfjzQgO/SJT
RZBC3+oupsRNIncLcpT6LvHz97oGcuyN0y9xEiAQ/oq0HxhLYx98iRd+zOXyZd7c
q4yiKp04NZb2+xwTuo+mqvEunWi1gWHkT/fnA8DflQ==
=clnF
-----END PGP SIGNATURE-----

--6fh+nlbcZC0fR/Q3--

