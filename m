References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3d846409-458a-efd0-c554-9c7f24144a49@...2181...>
Date: Fri, 22 Sep 2017 00:59:53 +0800
MIME-Version: 1.0
In-Reply-To: <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RXkLmwDvKQ23LW5697vurthIKFFmDQUKd"
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if
 plugin init fails
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RXkLmwDvKQ23LW5697vurthIKFFmDQUKd
Content-Type: multipart/mixed; boundary="wKdrdkfduCe2JFmdfKBbS3K3RxX6vcbgJ";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <3d846409-458a-efd0-c554-9c7f24144a49@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if plugin
 init fails
References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
 <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505457556-8557-1-git-send-email-steffan.karger@...1435...>

--wKdrdkfduCe2JFmdfKBbS3K3RxX6vcbgJ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 15/09/17 14:39, Steffan Karger wrote:
> close_instance() tries to remove the file in c2.pf.filename, but that only
> works if we actually set that if we fail.  So, set that filename as soon
> as we know we've created the file.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.

ACK.


--=20
Antonio Quartulli


--wKdrdkfduCe2JFmdfKBbS3K3RxX6vcbgJ--

--RXkLmwDvKQ23LW5697vurthIKFFmDQUKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnD8AkACgkQB6U8WA7y
zXQZUQ//enY4afvhoLf0A4vCZsRb5fB9w2/3xXVmMj0r5vm3G3DxKHv/NKCnadT0
8tG+Nbyx4u5LNPq5O8If8wVFizNXC8xIk4n83CVoCpEfWcJ/qo8GIdmrQXpf0h7w
aJuC4VQDTXewb4wQp4al7ftNw9biZFRqJQ5B1Uf1/Lkc1l7HBFpfN86pDvVNKL4e
1LALWwaFGCgcnBz21pAeW/Va2scEfyYRR52h/WNLZJ0D4slBJxJ8E2cLZRgGiJ0X
jl05Eqghw6lYir76hPE3BaoUk1QMhpXPze6J38RnlIuUJQV6UfxBiaNPW0VKsOyi
786/Ar9Wrh8174OHjY85cYwIMhkSb3rLbVsISW/NkZ/6XKVfjma+OtbpaVlvnGng
iwPmJjPCNRSJlY37KnDzRqzwpQOZViK9Xeqix6e0HPwP3218KHMH4ExvLAROX/S+
6Fo0pX39yAR2wKVF37UuqLeFKnI9j1nmMvx7DzxHOruzdbHyP8jZyN2EBKX53OW/
/xmJCgrLUrHt7eAT4iyaFz1Cu3D1+WEEkQGHS3x1SafCeUEn21nr+hlRtvYQ34Zg
HzuAS86URVMF/PujH6DFgwbjzdSHmuszEaPVPutLrlYlk61K7uCvfRk5+9/9fhqx
sqrz8T9PQT3rfWPd8F+DS1AwxJQisCgpzZYZe8p1Xhj8j8RyIr4=
=Lw2R
-----END PGP SIGNATURE-----

--RXkLmwDvKQ23LW5697vurthIKFFmDQUKd--

