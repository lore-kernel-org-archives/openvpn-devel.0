Message-ID: <52D5A4BC.60105@...1227...>
Date: Tue, 14 Jan 2014 21:57:32 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20140113185822.GV226@...1296...>	<1389650074-18455-1-git-send-email-gert@...1296...>
	<1389650074-18455-2-git-send-email-gert@...1296...>
In-Reply-To: <1389650074-18455-2-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="5B5T5BvM8Co95vxOBlW65eta9iCi4mU6f"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Replace copied structure elements
 with including <net/route.h>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5B5T5BvM8Co95vxOBlW65eta9iCi4mU6f
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 13.01.14 22:54, schrieb Gert Doering:
> The code for FreeBSD, Dragonfly, OpenBSD and NetBSD contained copies
> of structures from <net/route.h> (struct rt_msghdr in particular).
>
> OpenBSD changed some structure elements, making OpenVPN incompatible,
> depending on the specific OpenBSD version.  Clean up: remove copied
> definitions, replace by including <net/route.h> directly - this could
> not be done originally due to a conflict with "struct route" in OpenVPN
> and <net/route.h>, cleaned up by the previous commit.
>
> Tested on FreeBSD 9.1-RELEASE, NetBSD 5.1, OpenBSD 4.9 (route.c compiles
> with no warnings, and "openvpn --show-gateway" works, which is the only
> part of the code that uses the structures in question).
>
> Fix trac #340
>
ACK.

Arne


--5B5T5BvM8Co95vxOBlW65eta9iCi4mU6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVpLwACgkQe8+cMNS4zRe+uwCg78gqyxBRFrQiZYpv/kMkZaiK
fRcAn0rHFTwIVXu/6GwV/b2817nLPaY4
=LAr2
-----END PGP SIGNATURE-----

--5B5T5BvM8Co95vxOBlW65eta9iCi4mU6f--

