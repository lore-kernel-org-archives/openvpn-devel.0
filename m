References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <aca7419e-3150-9608-db23-8b203335a80b@...1856...>
Date: Tue, 13 Dec 2016 23:08:46 +0100
MIME-Version: 1.0
In-Reply-To: <f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OgK6LCc8HXUjV1PfQuQHw7vnSPGJlrOOl"
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OgK6LCc8HXUjV1PfQuQHw7vnSPGJlrOOl
Content-Type: multipart/mixed; boundary="GamkEOVgTHXufXgXU1Klh40FaBrpEQVsM";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <aca7419e-3150-9608-db23-8b203335a80b@...1856...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
In-Reply-To: <f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>

--GamkEOVgTHXufXgXU1Klh40FaBrpEQVsM
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 13-12-16 22:42, David Sommerseth wrote:
> So the first phase of the great reformatting is on its way.  I have
> just pushed out a reformatting branch to the following repositories:
>=20
>    https://github.com:OpenVPN/openvpn.git
>    https://gitlab.com:openvpn/openvpn.git
>      git://git.code.sf.net/p/openvpn/openvpn
>=20
> This is based on the last master branch, with two additional commits.
>  The first commit adds the reformatting script which does the complete
> reformatting in a consistent way across the complete source tree.  The
> second commit is massive, with the complete reformatting.
>=20
> Have fun and report back.

Excellent.

I just verified that 9f4993fbd4e6cd36c9c3f4661c78881b7e6121bc is indeed
the result of running the formatting script commit in
a084eb6cc294c7326395e01b6a5c14abb7ed4ee5 on that commit.

-Steffan


--GamkEOVgTHXufXgXU1Klh40FaBrpEQVsM--

--OgK6LCc8HXUjV1PfQuQHw7vnSPGJlrOOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYUHF2AAoJEJgCyj0AftKIp04IAL1wOrvKu/Pya1bzNa+ACbcl
Ofo+Q1o1QOBYjknGaaZqckCY/ay0ql3KkhpJ/2+BL5+1eSt7nzU8+Kjo80O7Ib2u
vhSHeUMiTq6mo3o2b1Gc7cyv5ED7HmqBBtZhQdhoBW5nyjX0tK16FM1X6srzJQPZ
qeWNSqKYR/9k9HGhuUSkABRkwzGZ1Fk0EN8k9XWjw8E6FXv0fdK0cpIe6nPvaotw
voiNCh5pMjx+v2W2ZFkzbxNcNlQiwJ/rb0De/4sNYbPRi6SQwjTcEPXMdfzb3f1V
vzQa4DWGXypm8ic/4MOfYPAqZqTLy7Lb4eTSn0+Tg8n5KVYWJc0+5r2QHt300r8=
=lHjk
-----END PGP SIGNATURE-----

--OgK6LCc8HXUjV1PfQuQHw7vnSPGJlrOOl--

