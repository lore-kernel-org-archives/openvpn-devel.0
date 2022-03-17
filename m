Date: Thu, 17 Mar 2022 14:25:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjM23+3br9LKrWyc@...1296...>
References: <20210322074359.527-1-simon@...2293...>
 <202103220910.12M9Ag1E095423@...2054...>
 <20210322091717.GJ976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mD/g8LvEyGmwxCws"
Content-Disposition: inline
In-Reply-To: <20210322091717.GJ976@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: tapctl: Resolve MSVC C4996
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mD/g8LvEyGmwxCws
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 22, 2021 at 10:17:17AM +0100, Gert Doering wrote:
> My local tree was in a slightly funny state (the tip commit had a new
> ID due to an accidential "git commit --amend" on the wrong head), so
> I had to rebase and this commit got a new ID
>=20
> commit e5e9a07e8baee4065b7dfd65736bfa77b8329cfc (HEAD -> master, stable/m=
aster, mattock/master, gitlab/master, github/master)
> Author: Simon Rozman via Openvpn-devel <openvpn-devel@...1223...=
et>
> Date:   Mon Mar 22 08:43:59 2021 +0100
>=20
>     tapctl: Resolve MSVC C4996 warnings
>=20
> (and I forgot to change the From: line again, sorry, again)

By popular demand (Lev) this was now cherry-picked to 2.5 as well.

commit 64547d552dbcadd826a30a4ba122d590d87504f6 (HEAD -> release/2.5)
Author: Simon Rozman <simon@...2293...>
Date:   Mon Mar 22 08:43:59 2021 +0100

    tapctl: Resolve MSVC C4996 warnings

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mD/g8LvEyGmwxCws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMzbfAAoJEB2Cnv7KVigSoIwL/RV73rjbP6yF1yrsk8+m810L
jpE1RBLIlzbrIQMJb4YSQGjk6KRsVQfkYahOI3wRTSxUkEbi1pLYRs95/tPkkdCh
O8J2Z9E9ExfD9ZV8Hi350cQokIYAtBDcye6Lf5HUilnhiAYJX/eL0L6zzyWvMcPF
56/D4E1nY7cjtGjvjCH19RPrcPCu6FIBIq36SM6GVop666SNG9PWwiHqcvlS/REM
CUjsvSd7gypNvDixQrebSryM81x6whEkoTcKqBZzDce0L1SGIkFdrI0Y3CUL+zFS
oSFP9I3wBU/29SpMN4r6JqFw10iz11DhZKVEL5DZ/3ZfywlcgORIkiK63zlGJk8h
r/08gSPkszSKgzD8Sy69p2QjU6JpGntP6CFan3jIgvC6tMrgfnqtPwbRQG1V0cID
PqjqDNTQenTAFEM9vOfkHSt7C+Ww8tLlcPwHMf61U0qO6ell3jEshr1za1h4br3l
TivjnveUys05V0cw3AteWc2PxpWU4ykgI55QZr7FsQ==
=bdM0
-----END PGP SIGNATURE-----

--mD/g8LvEyGmwxCws--

