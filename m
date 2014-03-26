Date: Wed, 26 Mar 2014 13:18:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140326121811.GA16637@...1296...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
	<1395407925-25518-10-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3DH39hcxTAlkpZ8S"
Content-Disposition: inline
In-Reply-To: <1395407925-25518-10-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 09/12] Don???t redirect the gateway on
	Android even if requested
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

--3DH39hcxTAlkpZ8S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as agreed on IRC, this is postponed for the time being, to see if a way
can be found to handle this without more #if(n)def ANDROID in route.c
(like, via options.c)

gert


On Fri, Mar 21, 2014 at 02:18:42PM +0100, Arne Schwabe wrote:
> Routing loops are avoided using the VPNService API
> ---
>  src/openvpn/route.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 13eed5f..eb5fb46 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -530,8 +530,10 @@ add_block_local (struct route_list *rl)
>      {
>        size_t i;
>=20=20
> +#ifndef TARGET_ANDROID
>        /* add bypass for gateway addr */
>        add_bypass_address (&rl->spec.bypass, rl->rgi.gateway.addr);
> +#endif
>=20=20
>        /* block access to local subnet */
>        add_block_local_item (rl, &rl->rgi.gateway, rl->spec.remote_endpoi=
nt);
> @@ -822,6 +824,7 @@ redirect_default_route_to_vpn (struct route_list *rl,=
 const struct tuntap *tt, u
>  	}
>        else
>  	{
> +#ifndef TARGET_ANDROID
>  	  bool local =3D BOOL_CAST(rl->flags & RG_LOCAL);
>  	  if (rl->flags & RG_AUTO_LOCAL) {
>  	    const int tla =3D rl->spec.remote_host_local;
> @@ -854,6 +857,7 @@ redirect_default_route_to_vpn (struct route_list *rl,=
 const struct tuntap *tt, u
>  		dmsg (D_ROUTE, "ROUTE remote_host protocol differs from tunneled");
>  	      }
>  	    }
> +#endif
>=20=20
>  	  /* route DHCP/DNS server traffic through original default gateway */
>  	  add_bypass_routes (&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,=
 &rl->rgi, es);
> --=20
> 1.8.5.2 (Apple Git-48)
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and their
> applications. Written by three acclaimed leaders in the field,
> this first edition is now available. Download your free book today!
> http://p.sf.net/sfu/13534_NeoTech
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3DH39hcxTAlkpZ8S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUzLFg6kuBuNlUUl1AQL0YgP9HgFB0uh6VfeL6e4SMZWc1HejV0L6apdP
3sCkbjoN6vDjFHlisH4ks2XqZcfhDldInTxGFm6S6OPTMw1WC30aScXdTz/EIQjx
XDHE6G6gwegi3vklKLyJDPR65BdfnMKsFhR5LydFWO4KZUcK9AH/JYsd9hvA6Wo6
LUmSqwyjbzU=
=FirW
-----END PGP SIGNATURE-----

--3DH39hcxTAlkpZ8S--

