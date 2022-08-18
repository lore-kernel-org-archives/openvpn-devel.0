Date: Thu, 18 Aug 2022 19:20:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv504aAMxqguVLNP@...1296...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-3-arne@...1227...>
 <1970912.abQj5cvHqE@...2664...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iQNvyNm9IU48YBZb"
Content-Disposition: inline
In-Reply-To: <1970912.abQj5cvHqE@...2664...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/4] Cleanup receive_auth_failed and
 simplify method
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

--iQNvyNm9IU48YBZb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 18, 2022 at 04:39:07PM +0200, Heiko Hund wrote:
> On Freitag, 20. Mai 2022 23:32:48 CEST Arne Schwabe wrote:
> > This simplifies the buffer handling in the method and adds a quick
> > return instead of wrapping the whole method in a if (pull) block
> >=20
> > Patch V2: remove uncessary ifdef/endif and unnecassary block
>=20
> Acked-by: Heiko Hund <heiko@...2662...>

Thanks for the extra ACK :-) - this got already merged as

commit 88823adebac31958cee83572241cff9fc775a601
Author: Arne Schwabe <arne@...1227...>
Date:   Fri May 20 23:32:48 2022 +0200

    Cleanup receive_auth_failed and simplify method

with an ACK from Frank.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--iQNvyNm9IU48YBZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/nThAAoJEB2Cnv7KVigSF8IL/jfVFeyQ+FSKsQmwPGeWXVqA
qkfYxleMQ/1WM4+WxaTR5VW6cGTFtslh//WrwOReW1CCynk9wHBuarXc65AJOmvZ
whX1I0rSEWNgeP1sJhef68sTALuoiWaD0uy6rN1sSbBBRgttbFT2RDq0dW8GIId3
NqIMe8u0FrubmYtHBy/GyuCRy+j74q8Hen37ZL20TvKdbgCmchGaTUJxR+I52zV1
jhdSAr4g/ltwYhdjRl5roS5Td3WLkSHLjmMBF4euH40BFCvSi9i/v4xGbVRqVwPz
omqnMkq4MHb/0SAD6jnyqH3VY2mWpkpaxGEKrMKCSuOciNHP8hSvMscqzdzJpRr7
aAOAg2X6IWymBjQHCyrNXMVH1YpuQPVoBSoAWVyqOV0dSiW6kPBT4PoKqz6leKd5
qypOwjbD/Y0QGRmLwXc2SVYkaFwm7rmoUc2MB8Y6MS5p+sVeZgscnMTm8NBz/S3b
JdgKvBlCB5SAht5DP0FqjfS7fU7bpzFHEufeMU763g==
=1fY3
-----END PGP SIGNATURE-----

--iQNvyNm9IU48YBZb--

