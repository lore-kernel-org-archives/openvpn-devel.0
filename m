References: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <960e0202-638f-3b3f-1ab3-a3dfe0d1d74e@...2181...>
Date: Wed, 14 Nov 2018 20:51:48 +1000
MIME-Version: 1.0
In-Reply-To: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ohfug602GvAImNh5WvkX06LROYLutKIC9"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: fix client reconnect bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ohfug602GvAImNh5WvkX06LROYLutKIC9
Content-Type: multipart/mixed; boundary="KNgmaRZ2drs5HSFB1TH1HQo4gRXQO37xN";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <960e0202-638f-3b3f-1ab3-a3dfe0d1d74e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: fix client reconnect bug
References: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>

--KNgmaRZ2drs5HSFB1TH1HQo4gRXQO37xN
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 31/10/2018 23:07, Steffan Karger wrote:
> As reported by tincantech on the openvpn-devel IRC channel, a tls-crypt-v2
> client could be caused to trigger an assert in tls_crypt_wrap() because t=
he
> client key might not be correctly initialized after a reconnect attempt.
>=20
> This was caused by code that was written before the connection-block
> tls-auth/tls-crypt logic was integrated (57d6f103), rebased on that chang=
e,
> but not sufficiently changed to be compatible with the new logic.
>=20
> This commit fixes that bug.
>=20
> Note that I also moved the violating hunk of code to the same function
> where the tls-auth and tls-crypt (v1) keys are initialized. Once moved
> there, it is immediately clear that v2 didn't follow the same (new) logic.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Yeah, it probably was a "conflict" that went unnoticed.

We now need to rely on the data stored in the Connection Entry (ce
member of the options structure) as the tls-crypt* logic is "per
connection block" and not global anymore.

I performed some basic testing and all seems good.
Thanks for fixing this!


Acked-by: Antonio Quartulli <antonio@...515...>


--=20
Antonio Quartulli


--KNgmaRZ2drs5HSFB1TH1HQo4gRXQO37xN--

--Ohfug602GvAImNh5WvkX06LROYLutKIC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvr/kQACgkQ9FVsWUWD
Dm0H+A//e3BkyVMvHr5hOclMSSGdP4+lp9mTU5i+1iF4gFNFjxtsx1o+PG5e8r+X
dgvF8oAMljj/V70ASvpc3jMBqaFN6BcKGAc7pgszNMRUfclX2pmDGXTCK1fz4cY9
5a3UT7hgCaVkcqf7Xa/EKdy2x2Q6PDorrKOZc9XO5TdJ+hHE6yCiTqZxxLF9d8C0
22V0hMvfCLewFTVHefk7yEkz2ahJkLP6KYeHlclbkrjuIib4M7AGKvPu56QgODaI
maXt99K9DkJ7zWwGxaofzLB/sqTPcV2yx6MMESWxYnmwdAAA9FYtXy3rK8/yLNFu
xgJU7zX7H+iSv+RyXr6uXCCCCG2sRmwwuyzVW0327rF6PysIJzD+Z53lOwdAoy8J
d5Ug7Lla94PXyw0guGvlQgoUZ2kmVGYnreIj7wPaemiUFNBoiYzdPQlKht9HBYYs
Db4iwukro6VrDwVbz53Nt+u9nAAFxwtQjkLVVDfM4Dp/asmfKDHLllDOIi10uhgK
jsZ1dtzWVUlXGn3HTK6HfB8ih4rs5hBH9w/WBaySxkE8t2j33xN490dVsiVpJPRu
L6Tdf8xrgPZk3LPDQYn3KA2rkg30/WkIiy1OVsguaiAbQiOtCxFfYJ/tYYjJoS6Q
miUJo5iX9hncBeWtedxK584aInh+a3Knu7rDdzh3Tuxrr+DYFYU=
=a5W0
-----END PGP SIGNATURE-----

--Ohfug602GvAImNh5WvkX06LROYLutKIC9--

