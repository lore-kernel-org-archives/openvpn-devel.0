Date: Sat, 6 Oct 2018 10:06:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181006080647.GS962@...1296...>
References: <20181005135849.28718-1-steffan@...1856...>
 <CAFHpkQH_D9EOWCKk8oF8ijqw9=rHuVhSVYJssMe841fNQnrmhg@...278...>
 <20181005195929.GO962@...1296...>
 <c8521752-6807-f2ef-7138-b5f066701b90@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xgjcSYp0bZmR6cI7"
Content-Disposition: inline
In-Reply-To: <c8521752-6807-f2ef-7138-b5f066701b90@...1856...>
Subject: Re: [Openvpn-devel] [PATCH (2.4)] Fix --disable-crypto build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--xgjcSYp0bZmR6cI7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 06, 2018 at 09:54:22AM +0200, Steffan Karger wrote:
> On 05-10-18 21:59, Gert Doering wrote:
> > On Fri, Oct 05, 2018 at 08:23:28PM +0500, ???????? ?????????????? wrote:
> >> shall we add "--disable-crypto" to travis-ci matrix in 2.4 branch ?
> >=20
> > I'm afraid this will bite us a few more times, so "yes, please"
>=20
> We already have this - that's how I noticed it was broken :)

OK, I was confused about this.  We *have* a --disable-crypto build=20
for "Linux", and I assumed this was about "do we want for Windows",
which Steffan and Arne tell me "no, we do not, because nobody wants
to disable crypto on Windows builds".

So, "no" :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xgjcSYp0bZmR6cI7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbuG0WAAoJEB2Cnv7KVigSE28L/2FNxhrw27kdcLU1g/UlemKt
S/KYZCJw+TjPlAbzCqhyTNfGxq3QB8PQ/LirJAand8HXohHN1wDcvx1MXETFlK9G
9ONdpQk4AFRVuk1VZuonG9wXLBW4tOm8TVSbKFGfPp+j2jQL1urT+HFNFHKvmo2z
NUCWpzdOD3C/G36EP30hwPE2Zoog0pwzZMIBzeY9HO8KPDPC4/OiUMv6TVex8QKS
WuIC8Lxw1Tv/wumkm19STmoU/4W7vZJUAMwrplg8oR17pmY7Remh0BF+EkCNf3X7
VXbWyxu2jQpJHnagQQAkUlG5vxer2jRCF6Z+T4Sa+EPnBIXpVZRdAoerF/974UpJ
2ufZNjoOkVFtsqPPUG3+EG7CRY33yCtscIuNTkUAVmWmZCzrp1T+08jDZX/TvKw9
1NsSAH5PIYz0jaw6uOEq/uJTjvwHJaBzIvzvG/2rbpkyBBzYCg9tp0hYCvjAEjyH
qm1rSE1dp2e2kSB03oh4ijtthyLvZ0LDM1tpcb6iqg==
=AXD+
-----END PGP SIGNATURE-----

--xgjcSYp0bZmR6cI7--

