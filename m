Date: Mon, 17 Jan 2011 23:00:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110117220032.GJ12114@...1296...>
References: <20110117213043.GH12114@...1296...> <4D34B911.6000700@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <4D34B911.6000700@...68...>
Subject: Re: [Openvpn-devel] configure not finding lzo (Solaris, NetBSD)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 17, 2011 at 10:48:01PM +0100, Matthias Andree wrote:
> Am 17.01.2011 22:30, schrieb Gert Doering:
>=20
> > since there's folks on this list that understand configure way better
> > than I do...
> >=20
> > Building OpenVPN on Solaris and on NetBSD fails "as is" because configu=
re
> > does not find the lzo headers and library.
> >=20
> > On NetBSD, these are (usually) installed by pkgsrc, and live in
> > /usr/pkg/include and /usr/pkg/lib.
>=20
> There would surely be a pkgsrc package that passes the proper CPPFLAGS/LD=
FLAGS.
> ftp://ftp.netbsd.org/pub/pkgsrc/current/pkgsrc/net/openvpn/README.html

Yes, if building from pkgsrc, the caller takes care to make sure=20
"everything works".

It's just if I grab the tarball and run "configure" that it doesn't find
lzo - even if it's in "the standard place for that OS".

> > On Solaris, if installed "from the source", the LZO stuff lives in
> > /usr/local/include and /usr/local/lib (same place the libraries would
> > end up on NetBSD if installed manually, not from pkgsrc).
>=20
> Unless you install from Blastware, or Sunfreeware, or Pkgsrc, or OpenPKG,=
 or...
> (you name it) -- each with its own default directories.

Yeah, sure.  But especially /usr/local/<stuff> seems to be something
that normally "just works" (being $prefix/<stuff> by default), but=20
doesn't seem to in OpenVPN

> Until that time, passing CPPFLAGS and LDFLAGS on the ./configure command =
line
> like ./configure CPPFLAGS=3D-I/usr/local/include LDFLAGS=3D-L/usr/local/l=
ib would do
> the trick.

Well, I know how to do that, of course :-) - there's even
"--with-lzo-header=3D..." and "--with-lzo-lib=3D..." - but I still wonder if
life shouldn't be easier for the 95%-case on a given distribution.

"If other packages can get this automatically, why do we need switches
for OpenVPN"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTTS8AKkuBuNlUUl1AQJ1PwQAlFb4JJYjys1gW28JVLHoEk+1au4VSqTM
vRB2omhWt37B/96606me55opNhrz4VmRpjg3A9Tb9TptPvgNcPDqbWGPaUKRDza6
nsoURsTxfHqryvjc7Bu9zuPaLMCG581XVNGPXhNuTI03WSxY3J5QSyvtnkzLHVtP
JcWSdX8ZhGI=
=2Av7
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--

