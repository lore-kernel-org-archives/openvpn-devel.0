Message-ID: <4BC21EB4.80102@...1338...>
Date: Sun, 11 Apr 2010 21:10:44 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...> <4BB46059.9080208@...1147...>
	<20100401091414.24106.qmail@...1287...> <4BB48345.7020408@...1338...>
	<4BB4882E.9020805@...1114...>
	<20100411183017.GA12312@...1296...>
In-Reply-To: <20100411183017.GA12312@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE8F969A871A6BD0011C6BDED"
Subject: Re: [Openvpn-devel] [PATCH 4/9] vlan: Prepend and
 remove	VLAN	identifiers on outgoing and incoming frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8F969A871A6BD0011C6BDED
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Gert Doering wrote:
> Something else I need to check: the "standard" mroute code hashes based
> on ethernet address (in tap mode).  What happens if the same MAC address
> shows up for two different VLAN IDs?  (Not very likely for virtual
> ethernet devices, though, but this can happen in real-world scenarios).

Have a look at "vlan: Add VLAN identifier to mroute_addr for ethernet
addresses". The VID is appended to the MAC address and forms the new
mroute_addr for ethernet frames (in tap mode).

Cheers
Fabian


--------------enigE8F969A871A6BD0011C6BDED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAkvCHrQACgkQARH1aMTipzN3RgCfTXj6uWKsjTmh86HFWv/SHZcV
gbAAl3KOzRpsSahnuty3auvEa5XKxUs=
=haCN
-----END PGP SIGNATURE-----

--------------enigE8F969A871A6BD0011C6BDED--

