Message-ID: <550BCD02.9070101@...515...>
Date: Fri, 20 Mar 2015 09:32:18 +0200
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <AMSPR07MB232F26EA163FA5FB6ACEA0EC1010@...2021...>	<550AD5A3.9040201@...515...>
	<550B4623.6000609@...1490...>
In-Reply-To: <550B4623.6000609@...1490...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="qRV1G9l9RBow6t0QGxTKGWmW7xnM7DHjr"
Subject: Re: [Openvpn-devel] OpenVPN Service Windows 8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jason Haar <Jason_Haar@...1490...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qRV1G9l9RBow6t0QGxTKGWmW7xnM7DHjr
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


> Unless other changes have been made to the windows service, I'd
> recommend not using it at all. There are error conditions under which it
> just hangs and blocks openvpn.exe from working
>
> We moved to using nssm - we set it to auto-restart on error and now
> openvpn as a Windows service is as reliable as openvpn as a Unix service
>
> Jason
>
Hi Jason,

I have probably mentioned this elsewhere, but I've been playing with the
idea of moving to nssm.exe also in the official installers. NSSM is an
open source project and the code is in the public domain, so I don't see
anything preventing us from doing this.

Any opinions?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




--qRV1G9l9RBow6t0QGxTKGWmW7xnM7DHjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlULzQsACgkQwp2X7RmNIqNTUwCaAn0pfgkWyFZkhpV9qdhsqc1I
Gt4AoKbwUyP8L8QZf73IXvm3/SaQKXMv
=z01S
-----END PGP SIGNATURE-----

--qRV1G9l9RBow6t0QGxTKGWmW7xnM7DHjr--

