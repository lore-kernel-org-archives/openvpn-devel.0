Date: Sat, 30 Sep 2017 09:46:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170930074629.GT70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8r7XanZh5e+04UYw"
Content-Disposition: inline
In-Reply-To: <1506735276.3927298.1123095944.62A302FF@...2307...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logcabin@...2306...
Cc: openvpn-devel@lists.sourceforge.net

--8r7XanZh5e+04UYw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 29, 2017 at 09:34:36PM -0400, logcabin@...2306... wrote:
> In file comp-lz4.c, g++ flags  LZ4_compress_default as unreferenced and
> the build fails.

Why are you building with g++?  This is not something we regularily do,
test, or recommend.

But besides this, this sounds like your system lz4 library is too old,
and our configure test is not catching this - LZ4_compress_default() is,
basically, the new name for an old function.  If the system library does
not provide it (LZ4_VERSION_NUMBER < 10701L, which is "lz4 1.7.1") we
should fall back to src/compat/compat-lz4.c which has it.

Which linux distribution is this, in which version?  Can you upload
config.log and your system's "lz4.h" somewhere so we can see what it=20
tried to do, and why it is failing?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8r7XanZh5e+04UYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZz0vUAAoJEB2Cnv7KVigSwNoMAKWRs4OKWIGCZRApnfgrH+uW
QOkpOureRR6YSJOtZMgf7+KN/M8XczRJMHE6CgzDi1RoJXZ+UpCVAm3bNqMWcBjH
D6U66KVmc4j4TdLdaOmQCL9V3qd14A0fDH3swu8QOI4+Xyizu8uVZYO8YP1LZr9z
QBC0Jff+qJG9bpckdHAB/XDjlLwhQykdfVCh3v+AIgNGPBKfjm6uUVtKHKml0k3j
3t7c8DzRhZQvlxnVAGDZBL5ZwrOtBmyWLz2d/HWuCpnsXsRWoA/y6STZyH6l4EXh
DaA3LWqMVgje3PDjsWkTLF0a6+0N/dbkUzfnIcMNpqAMrReCaiGQ4QXMBXAYt9+c
1zilxGJExPlGm4FVEAS+BLKg0uST8ORowE2NgfE1r7PYH3cb8kEU4BQ5c5YZIIwV
FlQJneZH9i+xjlhTNoTxeHBrVLtg/hPgOTYqdgump3kvo0f9IfH4oM6wwUbKKnfR
VdHBRzHE0Q4eYdoLwF1iWRVN/sFl6xmWb32qlNwJeA==
=cKti
-----END PGP SIGNATURE-----

--8r7XanZh5e+04UYw--

