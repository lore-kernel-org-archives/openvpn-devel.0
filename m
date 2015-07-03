Message-ID: <55966F4A.7010008@...1114...>
Date: Fri, 03 Jul 2015 13:17:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <55966BE0.5090400@...1147...>
In-Reply-To: <55966BE0.5090400@...1147...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lvCAthxePLqKrCCPpjaKGXPapsgtGqlPi"
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lvCAthxePLqKrCCPpjaKGXPapsgtGqlPi
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/07/15 13:02, Jan Just Keijser wrote:
> hi all,
>=20
> whilst writing the TFTP/WPAD patch I stumbled upon the options to set a=20
> default gateway and/or routes using DHCP options.
> I've patched openvpn to also set DHCP option 3 ("gateway") and indeed,=20
> windows picks up the route supplied to it  :)
>=20
> This might be a way to address this topic from the IRC meeting:
>=20
> Windows 8.1 DNS registration issues
>=20
>     * ipconfig failing to execute during VPN connection
>       <https://community.openvpn.net/openvpn/ticket/516>
>     * Who will fix and how?
>=20
>=20
> It's even possible to run openvpn without admin privileges and set=20
> routes this way!
> Before you get too excited: it does not seem to be possible to replace=20
> an existing default GW this way. the new 0.0.0.0 route has the metric of=
=20
> the tap-win32 adapter , which is better than that of a wifi adapter but=20
> worse (30 =3D=3D higher) than that of a regular LAN Adapter (metric=3D10).
>=20
> Before I go any deeper into this: what does the rest think about setting=
=20
> routes on Windows this way? It could be a nice way to circumvent all=20
> kinds of "route add" problems.

Okay, it's bold of me having opinion on the Windows, who have not used
Windows on his personal or work computers the last 15 years.

But I generally think this sounds like a really good idea.  I understand
doing the routing tricks for --redirect-gateway won't work - and I can
personally live with that.  I do like that openvpn today then can run
without privileges,

A few questions though

* Can you push several routes via DHCP?  Or just a single one?
If you can push multiple routes, then I'd say we should look into adding
a check if --redirect-gateway + non-admin privileged user =3D> provide an
solid warning in the logs that redirecting won't work without proper
privileges.

* What about IPv6?
Can you push IPv6 routes the same way?  Will that also work without
privileges?


--=20
kind regards,

David Sommerseth


--lvCAthxePLqKrCCPpjaKGXPapsgtGqlPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWWb0sACgkQDC186MBRfroqjACfSEayfJM4xPfPMU7Ze/wc9AFf
9ZMAniymlW6eEcIS1yB3T9fkUtIqv7Lj
=Qlz5
-----END PGP SIGNATURE-----

--lvCAthxePLqKrCCPpjaKGXPapsgtGqlPi--

