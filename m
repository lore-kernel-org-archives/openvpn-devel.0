Date: Mon, 20 Jul 2020 11:57:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200720095738.GO1431@...1296...>
References: <20200719173436.16431-2-arne@...1227...>
 <202007192005.06JK5s9N070266@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="L/65QfJQPh8Q3KMl"
Content-Disposition: inline
In-Reply-To: <202007192005.06JK5s9N070266@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: client-connect: Add
 deferred support to the client-connect script handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

--L/65QfJQPh8Q3KMl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 19, 2020 at 10:05:54PM +0200, Gert Doering wrote:
[..]
> the fact that it's reading the "client specific options" even in case of=
=20
> failure is clear form the source (but I decided that it won't do harm, so=
=20
> "leave it in") but the fact that it's not logging the failure is not good=
 - so=20
> I think we need to differenciate CC_RET_SUCCEEDED vs. CC_RET_FAILED in th=
e=20
> "if (ret !=3D CC_RET_DEFERRED)" clause in in multi_client_connect_script_=
deferred().
>=20
> Since this is logging, and basic functionality works, I think this can go=
 in=20
> a followup patch.

Just for the record: this has been addressed in commit 3658e5779.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--L/65QfJQPh8Q3KMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfFWqNAAoJEB2Cnv7KVigSRdMMAIxfG5G/x35GiKhYubTLx9SV
LmhIxDsQXGRSHh9E/rxdgH0c4RNY0yA3b9FsrzPI+2Q/NsiNjDk+WGvY85NP8CWe
NTTCATl9ktp3IAv9gAxjfpwBeNpUlSoxbIVP+8pLj2nIgWRJZj+NXNuL5OWwBbhJ
nKIwmVakIAQJ7UgHlkFpV+QeD6dhST+r0UkNP4YUS8kM9cLUlA+kkTPj1ATzQ6no
h5dmXS7VAyd6KsQtc8DouBCXGvfS2oDCf86kvGVL0NhG+cCjIfW/X6C1p92yAmip
6nI72m64u9gMwCe2rtlQnrhTpzjcrRqa84gaPSH8Pplo+g0nFR3TKi95Rq+vUnx2
j/CfYMVducXG2a/NAXA6bjqZxfkDIMjQ147PCU4YNIqWo7rLbCbs5p5JpnSst1Lt
UzifV8OAsD2Qd15fbc2X1y+w4ZNiq1Avew8nYWMZIft4BRo+myjfdXMAFwPV9bNx
lKDdvqPHAKqEA98gyxriXzOKEvSA4CjUg9VnjrOvbQ==
=1IbC
-----END PGP SIGNATURE-----

--L/65QfJQPh8Q3KMl--

