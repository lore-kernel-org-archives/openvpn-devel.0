Date: Sun, 22 May 2016 10:24:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160522082443.GW53051@...1296...>
References: <AE97EF71-3179-4CA9-859C-EE9F2A5DEFBA@...2127...>
	<20160521185940.GT53051@...1296...>
	<A72247F4-3D1B-42B1-AD1E-EC1E28EF5346@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xZKnUbRADYQzAXzS"
Content-Disposition: inline
In-Reply-To: <A72247F4-3D1B-42B1-AD1E-EC1E28EF5346@...2127...>
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--xZKnUbRADYQzAXzS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 21, 2016 at 11:32:40PM +0200, Jens Neuhalfen wrote:
> This is=20
> * Solaris 11.3 on Intel 64 bit (isainfo -k ???> amd64), fresh from Sun^H^=
H^HOracle
>=20
> * OpenSSL 1.0.1p.  openssl is compiled as 32 bit library (file /lib/libcr=
ypto.so.1.0.0 ???> /lib/libcrypto.so.1.0.0:        ELF 32-bit LSB dynamic l=
ib 80386 Version 1 [SSE2 SSE MMX CMOV FPU], dynamically linked, not strippe=
d).

Tried building with 1.0.1p (using gcc), and the first thing to notice is=20
that *openssl* fails its own "make test" run (something in the RSA key test
aborts with "keys do not match").  So something is fishy with that version.

Interesting enough, our "make check" *still* works nicely for me...

-n Testing cipher AES-128-GCM...=20
OK
-n Testing cipher AES-192-GCM...=20
OK
-n Testing cipher AES-256-GCM...=20
OK
...
All 2 tests passed

So it does look like that 1.0.1p and Solaris do not get along well, but
it might depend on compiler used (I use gcc, Oracle surely does not).


The most recent version is 1.0.1t, which interestingly enough, has the
same self test error...

CMS consistency test
/opt/csw/bin/perl cms-test.pl
CMS =3D> PKCS#7 compatibility tests
signed content DER format, RSA key: verify error
make[1]: *** [test_cms] Error 1

(this works in 1.0.2, so I think it's not my local system that is funny)


Ceterum censeo: I acknowledge that something is funny here, but I do not
think it's OpenVPN's fault (otherwise it should show up for me), so not
much we can do about it.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xZKnUbRADYQzAXzS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0FsyqkuBuNlUUl1AQKh/AQAwNbE3xbM9YpSm9yBlifesAlSwRQXCuS0
N/xCGxgWA0Z67ipK5rQ/zjyr75a0gFBs4wULJc3iHeyut/E4P96LdrVyPexxPiDA
THd8pyXyMTQuaFmooNOq88vmOdT6C7Zbx1R5sSPNckQZP7rNSUG7BhYJKt/HfEcz
1/3U3TqOYK0=
=HWsx
-----END PGP SIGNATURE-----

--xZKnUbRADYQzAXzS--

