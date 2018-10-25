References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4496cc38-d236-421a-4bdc-d167c722c08e@...2181...>
Date: Thu, 25 Oct 2018 19:40:16 +0800
MIME-Version: 1.0
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mgUNUNmqOPiKJo93qi4cbSUBTJ1xIXWrw"
Subject: Re: [Openvpn-devel] [PATCH 00/10] Client-specific tls-crypt keys
 (--tls-crypt-v2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mgUNUNmqOPiKJo93qi4cbSUBTJ1xIXWrw
Content-Type: multipart/mixed; boundary="0J67N2h4bx5N099IVNPkM0SyHDXUWZTmF";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Cc: Steffan Karger <steffan.karger@...1435...>
Message-ID: <4496cc38-d236-421a-4bdc-d167c722c08e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 00/10] Client-specific tls-crypt keys
 (--tls-crypt-v2)
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>

--0J67N2h4bx5N099IVNPkM0SyHDXUWZTmF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am happy to say that finally I couldn't find anything wrong in the
last version of this patches.

Other then reviewing and providing feedback to Steffan, I have also
tested the code in various setups, including the usage of custom
metadata and its verify script.

On top of that, I used the documentation provided by Steffan to port
this feature to the OpenVPN 3 codebase and I can say that my
implementation happily co-operates with OpenVPN 2.

This makes me think that Steffan's code follows the doc properly (or
that both implementations have the same mistakes :-P but it is quite
unlikely).

I have ack'd the various patches one by one and I believe they are ready
to be merged into master.

The ball now goes to the repo maintainers.


Regards,


On 08/12/17 20:07, Steffan Karger wrote:
> Hi,
>=20
> The following patch set adds support for client-specific tls-crypt keys.
>=20
> For a rationale, description and specification see patch 2/10, which
> adds all that to doc/tls-crypt-v2.txt.
>=20
> This set is also available as a branch in my github fork:
> https://github.com/syzzer/openvpn/tree/tls-crypt-v2-preview4
>=20
> -Steffan
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--0J67N2h4bx5N099IVNPkM0SyHDXUWZTmF--

--mgUNUNmqOPiKJo93qi4cbSUBTJ1xIXWrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvRq6AACgkQ9FVsWUWD
Dm2LYRAAjCAKNGAmaBhsikQiGRCWI9Ypa4m8wIvrEHmObiP9vu1O6JCFrLbcBpf2
PWBS9ygi78G8DA+b+n2M9FJQmJC8UZwvI8lhFk7E+8K9oezYiXJotRulLw8Z0z2K
1LHO9xU2PgkUoYh8+RCayvVXWG4ZMjnur06TiPKYysh5rzM1TrEKA9ZIlumLSwPg
MJ+py3OzFsg0txkgK9QMZ4TPtgPmUBErle+eeh82FFDqQstvbTmycxfnNLVp64c8
NxTBeh2rVe+TbBiiDa+UhdszS4TpeP8bs9Rw5uvw6/6YyPm1YKi7x0mrQPPHJOlM
W+jjj5U8Y0EQK4yyiOEFsWZCkkbyoO7O1zlgwGjyuhQkvliLDFdcFif/FGRmtZTn
mg5epBvsAit36uV0mQ9nrBAnhs3MNpzxx5phVmyYt3p/ss6ZHq4GNo0kYB9+UUIR
L/tT6z/KHmFpvYvTGFkiw4NmAfsJr7j+V7/JIpNiHUH6BdxfrYwN3RPuYmyuCFh7
MGx9Eu+1fVXpudwYTLGy10594/Kbz5GCMhiOCvmgYMivr2vxQN1DMAyh+a4Soal8
UI54wFkJd1gdgHvydwXItnWCsnAuUrC24Y4iKU9+4IoGcPHWBpg1IaIFdUcjhyow
Z32UpfLQQ/OQRdY20VYxy6aGEgv3ZuBmOMAjFORxX2h2iwsmKYY=
=33zR
-----END PGP SIGNATURE-----

--mgUNUNmqOPiKJo93qi4cbSUBTJ1xIXWrw--

