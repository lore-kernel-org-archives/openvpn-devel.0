Date: Mon, 26 Mar 2012 20:47:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326184719.GA1359@...1296...>
References: <20120326160546.GV1359@...1296...>
	<CAOazyz1W7ZcVEhDwq0DWCOjQ_DetcjP6yDg1MhOPiMYqu2Sr6w@...278...>
	<20120326175543.GX1359@...1296...>
	<CAOazyz2OxeRdL1+SfzrCw6YDnLnY5Yg-PCq9K6041Dgvs_W2hg@...278...>
	<CAOazyz3gFfBT-xniAiziy36kiDcqL=0mVQvKc0KHYEjt_vPh8A@...278...>
	<20120326182231.GZ1359@...1296...>
	<CAOazyz0qSzNnGAZj4t43EcKn+nLCGpet0oTXkTQOfQuZ4pfb4A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6iH21V1A1PEFpM6"
Content-Disposition: inline
In-Reply-To: <CAOazyz0qSzNnGAZj4t43EcKn+nLCGpet0oTXkTQOfQuZ4pfb4A@...278...>
Subject: Re: [Openvpn-devel] [DISCUSS] much more complicated gcc invocations
	now
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--O6iH21V1A1PEFpM6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 08:32:40PM +0200, Alon Bar-Lev wrote:
> Well, please hold... I don't see this if... at my machine:
>=20
> ---
> gcc -DHAVE_CONFIG_H -I. -I../../../src/openvpn -I../..
> -I../../../include -I../../../src/compat    -I/usr/kerberos/include
> -I/usr/kerberos/include     -g -O2 -MT reliable.o -MD -MP -MF
> .deps/reliable.Tpo -c -o reliable.o ../../../src/openvpn/reliable.c
> mv -f .deps/reliable.Tpo .deps/reliable.Po

Hmm, interesting....

if gcc -DHAVE_CONFIG_H -I. -I../../../openvpn/src/openvpn -I../.. -I../../.=
./openvpn/include  -I../../../openvpn/src/compat      -I/usr/include -I/usr=
/include     -g -O2 -MT reliable.o -MD -MP -MF ".deps/reliable.Tpo" -c -o r=
eliable.o ../../../openvpn/src/openvpn/reliable.c;  then mv -f ".deps/relia=
ble.Tpo" ".deps/reliable.Po"; else rm -f ".deps/reliable.Tpo"; exit 1; fi

... but not dependend on "BSD make" vs. "GNU make" (gmake does this as
well).  Maybe libtool/autoconf related?  OpenBSD has libtool 1.5.26
and autoconf-2.64, automake-1.9.6p5.


Testing on FreeBSD 9.0 with libtool-2.4, autoconf-2.68, automake-1.11
has what your version has:

mv -f .deps/reliable.Tpo .deps/reliable.Po
gcc -DHAVE_CONFIG_H -I. -I../../../openvpn-testing/src/openvpn -I../.. -I..=
/../../openvpn-testing/include  -I../../../openvpn-testing/src/compat      =
     -g -O2 -MT route.o -MD -MP -MF .deps/route.Tpo -c -o route.o ../../../=
openvpn-testing/src/openvpn/route.c
mv -f .deps/route.Tpo .deps/route.Po

... ok, I step down from my soapbox.  At least from this one :-)

(Just as a side note - why is it including "-I/usr/kerberos/include" *twice*
for you?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--O6iH21V1A1PEFpM6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3C5t6kuBuNlUUl1AQLrzgP/f60wGdLsAnmhXo2W19Uec7fHci6T+1Kp
wYbfDIwMqCMPINiFuad9WYbmMFspOwmoi5k0vzP4OxLA4iS1G2e+BTaLjIH0PHuG
cisgg5drzJEDrYv5TEMgQ9w9+jm8w80/wa+UEmD6RgVfsRgsmOe+rL9YLqiCLtDW
G1l+xQ4Z28k=
=+UB2
-----END PGP SIGNATURE-----

--O6iH21V1A1PEFpM6--

