Date: Sun, 4 Apr 2021 11:27:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210404092701.GJ976@...1296...>
References: <20210403184626.23067-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Zqbf0itD5gQrXCLw"
Content-Disposition: inline
In-Reply-To: <20210403184626.23067-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Remove P2MP mode and check for
 gettimeofday
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Zqbf0itD5gQrXCLw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 03, 2021 at 08:46:26PM +0200, Arne Schwabe wrote:
> Using OpenVPN without P2MP support (pull, TLS) is unrealistic and
> building a binary without it is not something we realistically want
> to support anyway. Building P2MP support now only depends on
> HAVE_GETTIMEOFDAY or win32, which has a compat function for it.
>=20
> This also removes the ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
> defines, which also depend only on the HAVE_GETTIMEOFDAY or WIN32.
>=20
> I kept the configure.ac check and ifdef in compat since mingw actually
> provides a gettimeofday and we will use that instead of our own compat
> function.
>=20
> Patch V2: Remove dco parts that slipped into the patch, mention the
>           other removed defines that are always enabled.

I need to NAK this, I'm afraid.

There's a few random stray blank lines, which I could have removed
on the fly :) - and the commit message as well, but I think you need
to look at TIME_BACKTRACK_PROTECTION more closely.

The #define is gone, but the code in otime.h still #if's on it, and
I think "we want the one *with* TIME_BACKTRACK_PROTECTION"... so either
totally remove the other branch, or leave the #define at "1" (for this
patch).


My suggestion for a changed commit mesage was as follows:

-------------- snip --------------
    Remove conditionals compilation for P2MP, ENABLE_SHAPER and check for g=
ettimeofday
=20=20=20=20
    Using OpenVPN without P2MP support (pull, TLS) is unrealistic and
    building a binary without it is not something we realistically want
    to support anyway.  Building P2MP support currently only depended
    on HAVE_GETTIMEOFDAY or _WIN32, which has a compat function for it.
=20=20=20=20
    Remove all the #ifdef P2MP logic, simplify code and reduce maintenance
    effort.
=20=20=20=20
    This also removes the ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
    defines, which also depended only on the HAVE_GETTIMEOFDAY or WIN32.
-------------- snip --------------

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Zqbf0itD5gQrXCLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaYZkAAoJEB2Cnv7KVigSMi0L/jq10d+qzfuIS+buo+DEB7gR
qHTT0iNQ3hHj7DT7Kq/PNd8paYLJie3PcU5LgxZ6HclnlabvZwaVy3Q2se7EqwEH
P2sJKas1L9uW74pv3XUNZ+mJ4mzYeQ7C4vytXOMLj4w2IejSv9ZV+CB/lbryqGd0
oH+cBxBABXuOjyd+RS1nR9tyJUQE4/DQapru6dJmcSEox8H0+cUmBUG95yf0gtCK
eEOy6jMdRitZLU0pqU77YqxWLMHqNV2JKtL8RlKJyesdjRpBebmkk3Fu3nACyuq5
kIYc+v+yylKjATTDu6CFNnMhpKa9BIGaY7PXBkKN26/Ova5AvHlCCcCYr9lbyi0u
y5XxI057sPi5SvF1YxMjeaeMcebh3O4XNhwN/MwQAhuEkbKBC5iI0Spofjwn6Prt
AN71+UWVVbHbyIWDrJCqMVJjbawNQI2y0Ue70wRtSPFFjWEYDP8A1ky0D2q9JK+c
8PtKVeDjhPYc/9FQosLWmLk/8frC38euGVgQfh14DQ==
=wZI7
-----END PGP SIGNATURE-----

--Zqbf0itD5gQrXCLw--

