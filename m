Date: Fri, 23 Jun 2017 15:33:26 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170623073326.GF31123@...2287...>
References: <1497873065-2229-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <1497873065-2229-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] init_key_ctx: key and iv arguments can
 (now) be const
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, Jun 19, 2017 at 01:51:05PM +0200, Steffan Karger wrote:
> In older OpenSSL, the key and iv arguments of EVP_CipherInit_ex() were not
> const, which meant that our API could not be const either.  Since we
> dropped support for OpenSSL 0.9.8, we can now fix our internal API.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

This patch is quite simple and just does what it says.

Acked-by: Antonio Quartulli <antonio@...515...>


Maybe we should spend some time checking for other potentially const argume=
nts
around the code ..


Cheers,


--=20
Antonio Quartulli

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllMxEQACgkQ0+HICM1s
oFDxJg//aCSGjjBbwl10jrCgqbckoQSxtsB4OG3QK4Eu+7SVNxGHuX9RbzXxcuee
7pyJi51O69cWTNwP4ejRZoNiuWFs8wJ2pw1BBpCt24pTMiQKzDsx5EqPIadIb5jp
uC+Bdcd+271z+5Do/SydeLPhWe/1FiGAMuQQOG6sN/0RgGltJqxGdCnlK9L7bqO1
qbIrXanaJU+S4NJl6LRdppbwIcApjiB3sMcopLeT3BTQ6wsAmh/+Hi3HvqSF4SuG
x2k8iH+SRxrpGFtuoxVMLTF6zokPa+n6aJWZdFxTcCyFs8GS4+QfkZGHVrM01sp/
LUj5mkrs08pHneBlh/pWx94yx6O18bpMrwoqKGAmGGXfrLdG3SAVDrVdg7ShVeUP
kaBWirKEhs8XXoISkO9qAuots8rWwuzFF+nWayZxBEp661CcIO0JzZRwzeiaFA26
CDOT4HSA13L33qHXdEPVZB+SomQ0d1BMF9Q0MSe2smNSpd6I+gb/qLWT+ltPDDjD
b8Qf7dOhBJ1yBZtIZcwjeUKDb+1AGz4hX9nxoesHOE4soRFWTYw+MkgeDs7ktOOa
KokDgpI2qNRl1fDKSJZl6xZTa33CGJPj1rlFBkoyBUsdClMMz//FAUGCaqaposcl
CLQB5v/BN5BVkwHM9GHQPBbD3VHcqQ7O1KnPJcQWScBDt2BGRKc=
=eNri
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--

