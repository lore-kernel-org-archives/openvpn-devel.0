Message-ID: <4BC220F3.7090704@...1338...>
Date: Sun, 11 Apr 2010 21:20:19 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <cover.1270060247.git.fabian.knittel@...1338...>
	<1ae7a5fdae1e6d71bb7708a4f75ff060e3237c1c.1270060247.git.fabian.knittel@...1338...>
	<20100331231158.2782.qmail@...1287...>
	<4BB45497.8040707@...1338...> <4BB46059.9080208@...1147...>
	<20100411181805.GZ12312@...1296...>
In-Reply-To: <20100411181805.GZ12312@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig94BD426C12BD519C58407640"
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
--------------enig94BD426C12BD519C58407640
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Gert Doering schrieb:
> On Thu, Apr 01, 2010 at 10:59:05AM +0200, Jan Just Keijser wrote:
>>> Hm, nice idea.  I'll implement it in my next round of patches.
>>>=20=20=20
>> FYI: 802.1Q defines VLAN 1 as the 'native' LAN: all packets on VLAN 1=20
>> are *by definition* not encapsulated (according to my CCNA guide ;-))
>> VID 0 means "priority frames"
>> Perhaps we need to make sure that VID 1 means untagged ...
>=20
> Different vendors handle this differently - on Cisco, for example,
> you can make vlan 1 tagged and have the "native" VLAN on a port
> (=3D untagged transmissions) on a different VID.
>=20
> So you can't rely on "VID 1 =3D untagged".

The current patch-set uses VID 1 =3D untagged as default (in "vlan-accept
all" or "vlan-accept untagged" mode). Setting "vlan-pvid VID" in global
context allows you to change this though.

Cheers
Fabian


--------------enig94BD426C12BD519C58407640
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvCIQ4ACgkQARH1aMTipzP+ZgCfWg0LmQnPeP1tqjhBNll/arST
0aUAn1ultWUuOxBUJUKL9Yv+RlW8Um1V
=1Sdu
-----END PGP SIGNATURE-----

--------------enig94BD426C12BD519C58407640--

