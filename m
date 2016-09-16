Date: Fri, 16 Sep 2016 18:13:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160916161354.GM78279@...1296...>
References: <1474036558-29579-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BVBPRygDtbGal1Jh"
Content-Disposition: inline
In-Reply-To: <1474036558-29579-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove tun-ipv6 Option. Instead assume
 that IPv6 is always supported.
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

--BVBPRygDtbGal1Jh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 16, 2016 at 04:35:58PM +0200, Arne Schwabe wrote:
> @@ -1420,8 +1417,8 @@ do_open_tun (struct context *c)
>    struct gc_arena gc =3D gc_new ();
>    bool ret =3D false;
>=20=20
> -  c->c2.ipv4_tun =3D (!c->options.tun_ipv6
> -		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));
> +  //c->c2.ipv4_tun =3D (!c->options.tun_ipv6
> + //		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));

"something sneaked in here" :)

> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1729,13 +1729,6 @@ add_route_ipv6 (struct route_ipv6 *r6, const struc=
t tuntap *tt, unsigned int fla
>      }
>  #endif
>=20=20
> -  if ( !tt->ipv6 )
> -    {
> -      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s=
",
> -		    network, r6->netbits, device );
> -      return;
> -    }
> -

I think general check should stay, and be turned into "have done ifconfig=20
for IPv6" - because "if no ifconfig, route makes no sense".


[..]
> @@ -1141,7 +1141,6 @@ do_ifconfig (struct tuntap *tt,
>  	  add_route_connected_v6_net(tt, es);
>  #else
>  	  msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD before 4.0=
 (if your system is newer, recompile openvpn)" );
> -	  tt->ipv6 =3D false;
>  #endif

I think that whole #ifdef block can go (NETBSD_MULTI_AF).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BVBPRygDtbGal1Jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV9waQqkuBuNlUUl1AQJC8QP+PLG9BZqShdDzt7XRjp+fg0OQgTXkUHQa
+XBLEZIOPgqmupueYrrP+At/PiAVZmjhMIQoquX8LumobD/7Zu1QLyVqBKSdMGDK
IJHtRV3vuETAh9X80rbnHw0RcXf9Olgv2aNPStfZZxrB+m7DKxPsYu1veuR/WZGx
/jNFRPx/k5o=
=6RfI
-----END PGP SIGNATURE-----

--BVBPRygDtbGal1Jh--

