Date: Wed, 9 Jul 2014 22:39:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140709203935.GZ1118@...1296...>
References: <1404735142-31420-1-git-send-email-arne@...1227...>
	<1404811301-12860-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wkv87tf6M42+4Jbu"
Content-Disposition: inline
In-Reply-To: <1404811301-12860-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v3] Remove #ifdefs for client nat
	support.
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

--Wkv87tf6M42+4Jbu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 08, 2014 at 11:21:41AM +0200, Arne Schwabe wrote:
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1018,6 +1018,8 @@ process_ip_header (struct context *c, unsigned int =
flags, struct buffer *buf)
>    if (!c->options.passtos)
>      flags &=3D ~PIPV4_PASSTOS;
>  #endif
> +  if (!c->options.client_nat)
> +    flags &=3D ~PIPV4_CLIENT_NAT;
>    if (!c->options.route_gateway_via_dhcp)
>      flags &=3D ~PIPV4_EXTRACT_DHCP_ROUTER;
>=20=20

This...

> @@ -1046,14 +1050,12 @@ process_ip_header (struct context *c, unsigned in=
t flags, struct buffer *buf)
>  	      if (flags & PIP_MSSFIX)
>  		mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame=
)));
>=20=20
> -#ifdef ENABLE_CLIENT_NAT
>  	      /* possibly do NAT on packet */
>  	      if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)

... sort of obsoletes this c->options.client_nat check, right?

(I'm not sure I understand why it was done the way it is, but if you
do the first change, maybe just get rid of the second bit of the=20
condition here...)

The rest is quite straightforward de-#ifdef-ing, which I like :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Wkv87tf6M42+4Jbu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU72oh6kuBuNlUUl1AQJGigP+KNfEMXomjl5G3Dr1mt8tPAPmdBk8rEZT
5SVgf+iCSwm5kKAgQ5H3SydJazRYZO5hXmTN6GWObT+C9K0iP+J3SzWOVADpIUUd
thret6gTl8AmrrPQhqMV/9t/QFQKQ+dfx38k2Fw+gamJf5VkDTfPeMsM56AxOliT
htB5kbFL3as=
=Ch34
-----END PGP SIGNATURE-----

--Wkv87tf6M42+4Jbu--

