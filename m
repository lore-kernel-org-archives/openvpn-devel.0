References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <dc5b570f-98f3-b6c7-0b36-0c373bdd9298@...1227...>
Date: Sun, 10 Nov 2019 15:40:32 +0100
MIME-Version: 1.0
In-Reply-To: <20191110133525.6069-3-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ZE3S4b7udBUf44b6mMRqTTWP0G1XqeUJ"
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ZE3S4b7udBUf44b6mMRqTTWP0G1XqeUJ
Content-Type: multipart/mixed; boundary="9aoqRkMXoJ4B4Q70cAuGZGEWkBInKXWtv"

--9aoqRkMXoJ4B4Q70cAuGZGEWkBInKXWtv
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.11.19 um 14:35 schrieb Antonio Quartulli:
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .travis/build-check.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis/build-check.sh b/.travis/build-check.sh
> index 039a7dcf..250bb454 100755
> --- a/.travis/build-check.sh
> +++ b/.travis/build-check.sh
> @@ -8,6 +8,7 @@ fi
>=20=20
>  if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then
>  	export LD_LIBRARY_PATH=3D"${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
> +	export CFLAGS=3D"${CFLAGS} -Werror"
>  fi
>=20=20
>  if [ "${TRAVIS_OS_NAME}" =3D "osx"   ]; then
>=20

I assume that you compile tested this, so

Acked-By: Arne Schwabe <arne@...1227...>


--9aoqRkMXoJ4B4Q70cAuGZGEWkBInKXWtv--

--2ZE3S4b7udBUf44b6mMRqTTWP0G1XqeUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3IIWAACgkQFRhsZwKx
RFToQg/9ExMh6qDGa54RvbGsO2ktNhzlPM3VQJ1re5oXi556YSr/GZIgcCRQbAf9
AF7YlDlYyY0HkM8FLNjd47C3zU7hwhiE33JWQR1Woz1Zn7j7GnhWQ0Nqwqx7dyIR
H6s4d3U80oKiH4zWwyTHWAYvT6IoKrihxsfwlu5iyLvALg3R6sYwZD8IvwAPjc+B
QuhZFFaSNHXZQuiIQbDNraQFj9vZsU2iofaQDwgIH+W6yGXEz8KAZsMYgOOblq+/
i+vAU+1im5cXhyBFZlDCXh5nm6ffnIiRuX0y3rTgPQMgHPBDWD1uLaF2kcKMGKNi
gGGYWW4mJSuvaRFW3BlkEUkd36I0ln/GvpKqc5LQGONsdLUJgaYc0L5x3xwthGNs
KfgHtNsOJU7CD/cTPjpniSVXHwOFaoJT00YWMczmW7hMtdpsIvqkOxH9bdHrMMV1
bqskPBMjw7dLpkqLsVPJFEPsD5uQ/saTr/0SR/UYhS/EXWx9XksoNJozgTKR9pjZ
ffadSkGNo6y5CDe31fh9GJU+SsktFIutiqcqHGXxPNP533jKkfyUs+Kb7VcVsqfm
c83W+5W8wmg8cmslDFUNndxRG5HYyrdLfnGqFt4+EPvb8X2GoTY3W3H/QDqd4WWO
VUFSOXncrILPDYu6m4qsmkFFaWSRFwWh8LGwiBxhCM89RZK6lWU=
=KiOF
-----END PGP SIGNATURE-----

--2ZE3S4b7udBUf44b6mMRqTTWP0G1XqeUJ--

