Date: Wed, 15 Aug 2012 12:00:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120815100012.GD18296@...1296...>
References: <20120814194736.GU2535@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20120814194736.GU2535@...1296...>
Subject: Re: [Openvpn-devel] RFC: tun/tap cleanup at program end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 14, 2012 at 09:47:36PM +0200, Gert Doering wrote:
> I can see two options how to solve this:
>=20
> 1 - set a flag if a device has been opened using a dynamic number=20
>     ("--dev tap", which hunts for the first-free tapN device), and=20
>     if yes, destroy the device on tun_close().=20=20
>=20
>     This would leave devices lingering around if you call openvpn with=20
>     "--dev tap3" and there has not been a "tap3" before - but this could=
=20
>     be documented as "intended behaviour", and it would be fairly=20
>     straightforward to implement.
>=20
> 2 - actually check for "--dev tap3" whether it exists before (by calling
>     "ifconfig tap3" and checking the error return code - accessing /dev/t=
ap3
>     will not work, as that *always* springs the device to life), and=20
>     destroy devices that we newly created, while leaving alone devices th=
at
>     have been there before.
>=20
>     This will have the most nice user experience ("always leave the system
>     as it was before"), but the implementation would mess up tun.c somewh=
at
>     more.

  3 - check for the existance of "--dev tap3" and remember, not cleaning
      if it existed previously, doing this with RT_NETLINK which should
      be sufficiently portable across all BSDs.  Same advantage as "2",
      hopefully much nicer implementation.

I'll see whether I can get "3" done in sufficiently nice code...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCtzLKkuBuNlUUl1AQKx6gP+JYmK0cr7JLr3il5IDVI09oZ8p1zzr707
Jih94QY3+flKAUl/RCH3hhND0Zuv2ppTTnT8C1E7E2u5t/3VlFsDS+CwCU/PTDwe
q2mcqJcTdGHKrfvN5tK03SnglqjMUULlr/J8JDVRm/CJom4btjJkOpGJddtsmAfa
oa+j0thVQMk=
=PyDd
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

