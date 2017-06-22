From: David Sommerseth <openvpn@...2080...>
Message-ID: <b35c6dfc-d877-fe10-0619-34521738d872@...2080...>
Date: Thu, 22 Jun 2017 15:29:35 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="JKxtkUNfMbVtuU0qUCmXe3k4eG4LsnMiK"
Subject: [Openvpn-devel] * UPDATE * OpenVPN v2.4.3 and v2.3.17 releases
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JKxtkUNfMbVtuU0qUCmXe3k4eG4LsnMiK
Content-Type: multipart/mixed; boundary="g9UaLK9JfXualUOaACCxndGcU63EKLrPU";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <b35c6dfc-d877-fe10-0619-34521738d872@...2080...>
Subject: * UPDATE * OpenVPN v2.4.3 and v2.3.17 releases

--g9UaLK9JfXualUOaACCxndGcU63EKLrPU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

We are in an unfortunate situation that our Cloudflare front is
providing various results, depending on a lot of factors (region,
browser, computer, etc, etc).  And it causes a massive noise on people
trying to download and verify that these downloads are correct.

As most of this noise have been related to the source code downloads, I
have setup an emergency wiki page where an alternative download URL is
provided ... In addition the proper SHA256 checksums and proper
signature files are available too.

This will hopefully help people to get the right download.

<http://community.openvpn.net/openvpn/wiki/release-packages-2.4.3-2.3.17>


We will go more carefully through our release process and figure out how
to avoid this mess with the next release.  The discussion have already
been initiated [1], and we will dig into this for the next release.

[1]
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14937.=
html>


On behalf of the OpenVPN core community team, I am truly sorry for this
mess.  This is not how we want our releases to appear.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--g9UaLK9JfXualUOaACCxndGcU63EKLrPU--

--JKxtkUNfMbVtuU0qUCmXe3k4eG4LsnMiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZS8ZKAAoJEIbPlEyWcf3yIqYP/jq0C/Re0/WA/KdcB5X3tJ/W
ln7F+W5JrC50Use+gbIvk8vTm5YOJOqbsi/4jdT6BZ/KXz9Jx03VICa9js5PP/24
AvdvfpIX+oUWB+xQSAkPC88kp1UyMebILN3TnOyN5WBcHeSG1u0QLtHi5aCATFwD
a1xE5GFUMDtg2iCgdoFiN8hx++uEhaZNQqsEXDgRpI72FEZ+JSmavGItIfRwJqiE
lA013dtSEnFfs24I09oiWxxjaQtmTci25qvbkW/7llum1+q4YMiCTNAc8VQHIfYM
UKop/LUaswrtN362R8RDyndKeu5/7oDMR9WQOpMov7eOCZa3s9lcGmzHwqTqvHXt
4XXOSNA+n3TtT82GhYr2U5XW67EnTWQME1ZvQC10WEccWQ7FReoFUvzzrBEdfLFK
y5DsDeSPeGR88+sO26Kz9P3ncHT0a4JSlbgYoZMYq+yG6dHen8R/MoACmfow73cF
7rQBgEdJN/DAhd36LkU5gTb5TWfyjNcdi4biboN5MTbUXd/jn4PH/jzKnhAc66TY
NjkUH4OSGqnVa2mXs8coLyaKv3bBiY8YGHgqdfH6V5HpfNR7FCFJX42xWsDiNDwP
oQhLqOyrl9lGzrCPjyEiL/4cMWdOD303+mT/i3FUMQLoMZRvDWZk4TgPmloweIoR
15hRPCcKyCvO+i30CnoL
=q4ax
-----END PGP SIGNATURE-----

--JKxtkUNfMbVtuU0qUCmXe3k4eG4LsnMiK--

