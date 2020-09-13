References: <20200913145621.12125-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <60eac399-4af2-9d52-3bab-2d2376ad6578@...1227...>
Date: Sun, 13 Sep 2020 23:30:55 +0200
MIME-Version: 1.0
In-Reply-To: <20200913145621.12125-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Yz00NmBgOJY6OI114R2poSbHpi3Vq9Yme"
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-gateway for IPv6 on
 NetBSD/i386.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yz00NmBgOJY6OI114R2poSbHpi3Vq9Yme
Content-Type: multipart/mixed; boundary="RQw3IR0DkKURRzQc2wBweZtCrE2N9HAVq"

--RQw3IR0DkKURRzQc2wBweZtCrE2N9HAVq
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.09.20 um 16:56 schrieb Gert Doering:
> Our ROUNDUP() macro to achieve the required system-specific alignment
> for data structures sent to the routing socket was wrong for NetBSD -
> unlike OpenBSD/FreeBSD, NetBSD is not using "long" (32/64 bit depending
> on OS architecture), and not "uint32_t" either (32/32) like MacOS, but
> uint64_t.
>=20
> So our use of "long" always worked on NetBSD/amd64 and stopped working
> on NetBSD/i386 when this was changed on the OS side...
>=20
> NetBSD conveniently exports a RT_ROUNDUP() macro from <net/route.h> - use
> that, and avoid trying to second-guess OS requirements.
>=20
> While at it, add M_ERRNO to ominous "GDG6: problem writing to routing soc=
ket"
> error message to differenciate between "EINVAL" and other errors.

Have not tested it but looks sane and using OS code should be more sane
indeed.

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--RQw3IR0DkKURRzQc2wBweZtCrE2N9HAVq--

--Yz00NmBgOJY6OI114R2poSbHpi3Vq9Yme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9ej5AACgkQFRhsZwKx
RFSf1w/9FR9E3jt0ky2uSiFrJIaWk4IFzB/OZnmbSxKXLNnXy5vnsK3mvnhS55un
bfnlDDrE1C88ceYJ7fryRRkRyeQfQd67n5QfjlYiG6+3xo0x6MtMaTbaenci1DeE
D+sBj7DWli4LJx5PuLdGgDR4MKnx88i171AoznUqCprjqq7ZNwl+neNER4IDb2vm
ui08Sgqgtsxw1DX6WBk7cUDvAev8kpAKCDJf0j+dAAgk5ocfGghVKwEOJVsj+1R1
uglTfVN6u7Bdkbnt4mP8TxkEkkHs7WLqf7LzYT/ccLiwmPDZvU/mnWzKyL8s1Tm9
EOP/fJ788KAMSBQ9klsdKqWdQDGrGySgENKhoQD/gzpVo4sBa1J2bwrOiaLC8vGY
H+5agf2d3xerQ8m4Kqk2sUK4UOTIw9Ho/p0h0bX6LPANYXpzRi3Y48oWXjRJELoE
+OcaJMx+f/WJsvfD+enKFOdhiHMXxM626R7lfgUJIkiBBTPM2fexY9HEICfr5r+5
UvTViO9cBmuniQyh5Dnxwy9O7oaF16juSKpBjZQ52Fw9C44etnbmAdYENEeN/Pm2
dysnTn3BHd14/PLU3VETkGkdoY1TxyZaeN5Ri/Av8ysilZK+prLO2o583SHIoILr
Lyo4eE7DLy+UXjj9Eqc3gQ07w3je+J0KNaeHtBgdwz8Grlq9+/8=
=gwxL
-----END PGP SIGNATURE-----

--Yz00NmBgOJY6OI114R2poSbHpi3Vq9Yme--

