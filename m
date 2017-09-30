Date: Sat, 30 Sep 2017 20:15:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170930181555.GA70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
 <20170930161910.GX70062@...1296...>
 <1506794899.87173.1123548520.4DA7A99E@...2307...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BspSmK1Kkx4+06Ky"
Content-Disposition: inline
In-Reply-To: <1506794899.87173.1123548520.4DA7A99E@...2307...>
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--BspSmK1Kkx4+06Ky
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 30, 2017 at 02:08:19PM -0400, logcabin@...2306... wrote:
> Here's the output from the locate command:
>=20
> /usr/lib/arm-linux-gnueabihf/liblz4.a
> /usr/lib/arm-linux-gnueabihf/liblz4.so
> /usr/lib/arm-linux-gnueabihf/liblz4.so.1
> /usr/lib/arm-linux-gnueabihf/liblz4.so.1.3.0
> /usr/lib/arm-linux-gnueabihf/pkgconfig/liblz4.pc
> /usr/local/lib/liblz4.a
> /usr/local/lib/liblz4.so
> /usr/local/lib/liblz4.so.1
> /usr/local/lib/liblz4.so.1.8.0
> /usr/local/lib/pkgconfig/liblz4.pc

This is likely the issue here.  You have a very old version in the=20
system linking path (1.3.0), and a recent version in /usr/local/lib/ - but
to use that, the compiler would need a "-L/usr/local/lib" directive.

Unfortunately, even if our configure script had checked for the
LZ4_compress_default() function, it might have still bombed later, as
"which -I and -L directives end up in the final compile/link call"
is not always those that are used for a certain test.


> Since I could not locate LZ4_compress_default() in the openvpn source, I
e pulled lz4.c from the lz4 source tree, snipped out that function from
> the file, and then inserted it into comp_lz4.c. This does not work
> because there are many dependencies in this function.
>=20
> So I made a horrible hack and simply included lz4.c in comp_lz4.c. This
> solved the dependencies, but is most likely the wrong way to solve this
> problem :-)

Well, it is :-) - the "best" way might have been to explicitely tell
configure where to find the new library

 ./configure LZ4_CFLAGS=3D-I/usr/local/include LZ4_LIBS=3D"-L/usr/local/lib=
 -llz4"

(the quote "" characters are needed due to the "-l").

Alternatively, rename the system "lz4.h" before running configure, in
which case OpenVPN will fall back to using its own copy, bundled in=20
src/compat/compat-lz4*.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BspSmK1Kkx4+06Ky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZz99bAAoJEB2Cnv7KVigSmaoMALGXoUqA6P9uYe3Kyj7+wQKF
VXZX51GZ9MIiEHDlCJm9J1t8ZzoKWhu/l6Wx/0Ad3gO6U5qv6mpq3nmm9zTk2RYP
UJ9Y/wPFJioVt4irf92BREnU+gEnETUqhv+BPdiPPM6+BKC1ZGGe/oKQhIPlIDJp
8SfFM5rh/zhOjZMPQs+TZw1oQ0u7sUXjTjMS/is1SpqtM9GurL+YwcntOmwWbCgy
WefuzWFdg8BQ7BfO0B6ckNStgS2RsJNiqaj+DwUdBEQ2xV0Vt0tbsXkldUN3sJgw
aQ/xnFuLpqltqU1XBi8zP5qltBP1rDGF542kyPAQDGs/Ynbvny43DvYMSZBl4WIp
fZ8LWr6Ylzqt3OKUVhkFKETQ9C+6tvwt0wKZTvZu6A66mB8bE9Yivrf2batUy8et
wxrPDAcIYKFfFYKgLaWk9mh/uoK42aFUBtAUPs7O6MLlCA9yAr+utSMWOGRciwSz
6M68qyERyGVit14IHDKtquHL3nhDhbJKOMcNKjRIBQ==
=kOAo
-----END PGP SIGNATURE-----

--BspSmK1Kkx4+06Ky--

