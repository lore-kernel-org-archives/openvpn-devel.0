Date: Fri, 22 Sep 2017 23:20:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170922212057.GB70062@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hmAoQ2KfXDe4pzCq"
Content-Disposition: inline
In-Reply-To: <20170907172004.22534-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--hmAoQ2KfXDe4pzCq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 07:20:04PM +0200, David Sommerseth wrote:
> We are using a deprecated function, LZ4_compress_limitedOutput(), which
> will be removed with time.  The correct function to use is LZ4_compress_d=
efault().
> Both function takes the same number of arguments and data types, so the c=
hange
> is minimal.
>=20
> This patch will also enforce the system LZ4 library to be at least v1.7.1=
.  If
> the system library is not found or it is older, it will be build using th=
e bundled
> LZ4 library.  The version number requirement is based on the LZ4 version =
we ship.
>=20
> The changes in configure.ac for the version check is modelled around the =
same
> approach we use for OpenSSL.  Plus it does a few minor reformats and impr=
ovements
> to comply with more recommend autoconf coding style.
>=20
> This patch is a result of the discussions in this mail thread:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14135=
.html
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
>=20
> ---
> v2 - Don't use LZ4 version based #ifdef wrapper function
>      Do the LZ4 version check in ./configure

This looks good to me.

I have tested on

 - FreeBSD with lz4 installed, lz4.pc -> uses system lib
 - FreeBSD with lz4 installed, no lz4.pc, lz4 stuff in LZ4_CFLAGS/LIBS=20
                                      -> uses system lib
 - FreeBSD with lz4 installed, but not in include path
                                      -> uses compat-lz4.*
 - Gentoo Linux with lz4 installed, lz4.pc=20
                                      -> uses system lib
 - Gentoo Linux with lz4 installed, no lz4.pc, but lz4 in /usr/{include,lib=
}/
                                      -> uses system lib
 - Gentoo Linux with no lz4 installed -> uses compat-lz4.*

In all cases, the system builds and produces a working openvpn binary.

The messages in case "2" and "5" are slightly weird, though...

(2)
checking lz4.h usability... yes
checking lz4.h presence... no
configure: WARNING: lz4.h: accepted by the compiler, rejected by the prepro=
cessor!
configure: WARNING: lz4.h: proceeding with the compiler's result
checking for lz4.h... yes
checking additionally if system LZ4 version >=3D 1.7.1... ok

(5)
checking for LZ4... no
checking lz4.h usability... yes
checking lz4.h presence... yes
checking for lz4.h... yes
checking additionally if system LZ4 version >=3D 1.7.1... ok
checking for LZ4_compress in -llz4... yes

(but this is configure...)


There's an extra added blank line in comp-lz4.c and the bracket whitespace=
=20
Antonio complained about - but those can be fixed on commit.

So, ACK.  Thanks for wading through this.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hmAoQ2KfXDe4pzCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZxX6cAAoJEB2Cnv7KVigSCjML/1+II5ODuah+hF4muJG8QMHs
MrmdhLKvtHJxj8VZmfOSjewuxWr7We7qeqcIS95lMdNBRUqnqyK0sbgvVBiBr/8z
nNhU/YPy5lwWhfnOj6XgPghok/FVezt3mNKzgyKTLGwESw00ReRPxs1Qclv6O7lZ
UAOb6bEJjnJVHFQL9jWx0281joEz8cYPOxrRfmkLTOciCqMO4KpHsRbBWN0Q28Ha
LmEETcVdTGnFQlc7hpTbS22+N6lk05B1F+NTVEr7hF+W+IY7GSglxQx0Vcq/4H2g
N9T2RV6HvE/1fCM1B5X5/6j7jrRShDhh5sUWJjcy8XB2pbcuQJ42q4c+0bWURJj5
ZHHvna8UqZXflHIcjs25OfmU+VoSWq6f1GP898rZkVFMoUTiGi3lGC39Y70ZADxE
fl5CYTouKNUeb/Gykkk5aIkTc3kBIRPNoEJ3y8oNOunDwetSc52ygpNLl9r+Nioj
kJ+p4snXh/1dgWmj1ks1up78evDHx4KyZGTgV/bOpA==
=iv9P
-----END PGP SIGNATURE-----

--hmAoQ2KfXDe4pzCq--

