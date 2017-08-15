References: <1502811586-19578-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2286872c-539c-434c-4e1b-16fd082424b6@...2181...>
Date: Wed, 16 Aug 2017 06:54:01 +0800
MIME-Version: 1.0
In-Reply-To: <1502811586-19578-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GWeoifN1edF8jdggTsN2190f1VdKwoTEl"
Subject: Re: [Openvpn-devel] [PATCH] Move run_up_down() to init.c
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
--GWeoifN1edF8jdggTsN2190f1VdKwoTEl
Content-Type: multipart/mixed; boundary="kjasPSb62KXxI4Ve9tuKkqFaCKlssowsA";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2286872c-539c-434c-4e1b-16fd082424b6@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Move run_up_down() to init.c
References: <1502811586-19578-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1502811586-19578-1-git-send-email-steffan.karger@...1435...>

--kjasPSb62KXxI4Ve9tuKkqFaCKlssowsA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Aloha,

On 15/08/17 23:39, Steffan Karger wrote:
> This function is only used in init.c, and is not easy to fit into a
> specific category because it both runs scripts and plugin hooks.  Making
> it static in init.c is probably the best place for this function.
>=20
> (I think we should find a better place for everything currently in misc.c,
> and get rid of it all together.  This patch is part of that effort.)
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

This patch just does what it says without introducing any functional change.
I also agree that we should try to shrink misc.c as much as
possible..therefore any cleanup going towards that direction is welcome.

ACK

Cheers,


--=20
Antonio Quartulli


--kjasPSb62KXxI4Ve9tuKkqFaCKlssowsA--

--GWeoifN1edF8jdggTsN2190f1VdKwoTEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmTe4kACgkQ0+HICM1s
oFBbGxAAgAKAg6rBSec0Ut5rlCpGjDQRw7IGeRYeu6Dgp0rVJiR/uQkkB3NtLYwt
Eh540Shw7/Bp+YzP1cHIl8pTulCrqSghFRJOTrv0Najna/egC8bpgClj8pFLYD4l
dq9+NbzcdOEdqT3XVpwLWf3EOtmN4P9t3mhCywggLAmo7M36rGVUhY0wSSJaFrr2
Vgl3P3krvS7gk93vKNPETS9sRaG0B4IoiegfY+5nOg+yom3uN9FFltKurJjhWDH2
E1IVqSOA5f7neQre3/KNQEZgVI1Jo+u3p4M3LVagDOxGHhIB3Z7hLLhD1/nG3CMZ
+bpsDGfpEqQpxXxSZcjpDBJ/3vTd7Rb5EBckMFJx6Jm/BAKGsIKY6y0MMu7rTHzK
1K/z5D2lMFrAzJhuVNb1CKmz2j4o4LjK/fFG+7hrairfVyGPFVzP1Ndk7rEynMMb
L7DLpY7UJrKDiVjBk1DvsM43qUde+7WXiQjB00KgVbS/ZkptHDZAxO7ZTT4JqnXJ
Gmo8MFDWiI/LnARnC7ZPyhFBR8DpKU/miJ/5PPDfEbEien71e1OjiMt7zkR6lTUd
7pk6VRHTIIBeYysDgW3kt0wJIipgYyNZ40L4Upq5OODWlqSBccr401adKYAveFFl
dPn/YPQyFEYNaOI33StIRleNqHFMKGuWK/RdzD3PN8fdA/NsRbY=
=X/On
-----END PGP SIGNATURE-----

--GWeoifN1edF8jdggTsN2190f1VdKwoTEl--

