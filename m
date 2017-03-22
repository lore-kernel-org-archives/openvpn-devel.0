References: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0440d93b-6ded-9efc-8fba-838b4e954261@...515...>
Date: Wed, 22 Mar 2017 11:07:15 +0200
MIME-Version: 1.0
In-Reply-To: <e79eb6bd-87bb-a8f7-eda6-e65b33addd24@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V9NEkbhrVIoTNXskFeQ9P3DLrX3vwgUke"
Subject: Re: [Openvpn-devel] Consider git tags for I60x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V9NEkbhrVIoTNXskFeQ9P3DLrX3vwgUke
Content-Type: multipart/mixed; boundary="------------BB731D91FCCFAF2A58E90D4C"

This is a multi-part message in MIME format.
--------------BB731D91FCCFAF2A58E90D4C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 20/03/2017 17:13, debbie10t wrote:
> Hi
>=20
> just so this does not get forgotten about:
>=20
>   @dazo | slypknot: https://github.com/OpenVPN/openvpn-build
>   @dazo | I see that there are no tags with the I60x indicator ...
>           that could probably be something mattock should consider to add
> @cron2 | true
>=20
> Regards
>=20

For openvpn-build I have not added release tags, as the commit message
usually contains the necessary information. For example:

---

commit 23d42200f282d2fcdc57bd4262d1fffc0832c7ff
Author: Samuli Sepp=E4nen <samuli@...515...>
Date:   Tue Dec 27 12:31:39 2016 +0000

    Update build parameters to match openvpn-install-2.4.0

    Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>

---

Adding a tag per installer release is not a big deal, though, if we have
a use-case for it.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------BB731D91FCCFAF2A58E90D4C
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------BB731D91FCCFAF2A58E90D4C--

--V9NEkbhrVIoTNXskFeQ9P3DLrX3vwgUke
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY0j7EAAoJEClYTZ9AhkV4OoEH/0Vm7GJi67tIQdx76vTak/dd
XeKpLonzw08XbYcefXOfMGv6iGidpfnmTL00hLsUIM5CDiTfTSP85jBaIMfY0U0o
PVMj4FV/C4PODPuDC0nkGQoibOmrBJ0N9m6C3I2KwQGJsDk8Zs5TwcpAcmLzrqBn
qz48Rug3rbKGRLD3qKcYnTE8C548U5LUdzMP+GdTlhspXAIu3+MOZCdYvOMm5cW3
k3oYj9FzxfQZ6oUdZJHpcmUUozukyrRU1Ma+oTwDgiWexfhZuB7XTd2sXXvxd9OB
0XQv5Wpo8o65fS/60LZ3ih/v3Jvp6E3Qj2NIoZE2YxXdYl3RoCgMw9FUSn2bX3A=
=Lmnk
-----END PGP SIGNATURE-----

--V9NEkbhrVIoTNXskFeQ9P3DLrX3vwgUke--

