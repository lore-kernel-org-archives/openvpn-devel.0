Date: Tue, 9 Mar 2021 13:56:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210309125602.GK976@...1296...>
References: <CAFHpkQFzOBMUC+qX7vV8jeHxg2MdP6_DCwiUZ=seX7r3DE=cBg@...278...>
 <20210309124712.GJ976@...1296...>
 <CAFHpkQFqD4HqThaURqi1dCXhjsthDwWg81LdNP4BVWGfGgk_Lg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VbYrksqalqMykfDY"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFqD4HqThaURqi1dCXhjsthDwWg81LdNP4BVWGfGgk_Lg@...278...>
Subject: Re: [Openvpn-devel] using openssl feature wherever possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VbYrksqalqMykfDY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 09, 2021 at 05:52:12PM +0500, ???????? ?????????????? wrote:
> > On Tue, Mar 09, 2021 at 04:54:13PM +0500, ???????? ?????????????? wrote:
> > > if nobody minds, I can send several patches that eliminates compariso=
n of
> > > OPENSSL_VERSION, for example
> >
> > We do mind.  They are coded this way on purpose - so when we drop suppo=
rt
> > for OpenSSL before 1.1.0, it is clear from the code which sections can
>=20
> it is not much fun to catch things like
> https://boringssl.googlesource.com/boringssl/+/49e9f67d8b7cbeb3953b5548ad=
1009d15947a523%5E%21/include/openssl/base.h
>=20
> (BoringSSL claims itself as 1.1.0, accidentally decided "I'm 1.1.1 now")

We do not support BoringSSL.

(Or any other SSL library that claims "I am compatible with OpenSSL 1.1.1"
but isn't, really - which is why the LibreSSL adjustments are always very
minimal)

We sort-of-support LibreSSL because it is the system SSL library on=20
OpenBSD.  Otherwise, the answer would be the same as for BoringSSL.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VbYrksqalqMykfDY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgR3BhAAoJEB2Cnv7KVigSsuMMAKFQNLy5aNo+QSk++m97ns9y
YyQpyV5J6Bl2DXXEfyqnqH4PnqXKHmizG5MR5/Hl3qvqm4GpuH/qm5ejJfGidf70
VtW2ABqlTRTqtUgN3yaAJShwtjg7prcSYEjigrYQAtU8c6sU1E7pxehR5xF1iwZq
83K3tz/xMf074Y9NaMtEhZXv5AmOVdxIUnyJQwG3o8Sv5bFmpda92q8vGJqhKVl+
DeMIT6OzJyjuNdlA5Dwy8DOmdbJlwYBMGJ63ZqSJFs+y0DF0UHaP8C9ZPTopu6sE
CheRRP04MkYmJ8kHZ5zgu7oZ57DMonA7wuGLAwB3AcYqZDC8/q2IHeWWpSxLvqtf
sa2vVDJzdFvf2FtDmrTQsiYBdK0PP3WV769QsemIfq3Tc6l90UPicFukbMp2yxvV
0zCuaB03hHuM5GbqNQnmmTW8HN7qxGkowv1NgvrXTKZDVE2aSOun71ba0pTd3uFN
dZTjHwU28aQLKcz1AZXgTdTcIGVwCWCSDvrWc6DZlA==
=h9Cr
-----END PGP SIGNATURE-----

--VbYrksqalqMykfDY--

