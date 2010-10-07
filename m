Date: Thu, 7 Oct 2010 18:05:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101007160511.GM10703@...1296...>
References: <20101007142817.GU7437@...1152...> <4CADE70D.8070307@...1147...>
	<20101007154740.GL10703@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmmR3/qxny8hj3mZ"
Content-Disposition: inline
In-Reply-To: <20101007154740.GL10703@...1296...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TAP installation Problem
	(2.1.3) on Windows 2000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Katja.Stange@...1152..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net, Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>

--fmmR3/qxny8hj3mZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 07, 2010 at 05:47:40PM +0200, Gert Doering wrote:
> On Thu, Oct 07, 2010 at 05:28:13PM +0200, Jan Just Keijser wrote:
> > > WHy is that?
> > it's a (minor) mistake in how openvpn 2.1.3 is packaged:
>=20
> This is not a mistake (as in "oops, we didn't know"), but was unavoidable=
=20
> since the latest WDK is needed to properly support signed drivers for=20
> Win7, and that version does not support Win2k anymore.
>=20
> OTOH, there *should* be a Windows 2000 install.exe, but right now=20
> I cannot find it on the download page either - James did build it,
> with the old WDK/DDK, but somewhere in the release process it must=20
> have fallen through the cracks.

David found it:

http://secure.openvpn.net/win/openvpn-2.1.3-install.exe         (XP to 7)
http://secure.openvpn.net/win/openvpn-2.1.3-install-win2k.exe   (w2k)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fmmR3/qxny8hj3mZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTK3vt6kuBuNlUUl1AQK98AP/a9orJ4P7HDySh/URynJLjPN04zsL4zWI
CiB3IJ2u0RJ+VZ+GTY+1dIxxAJbvgP1Lk+0DorDfgWMM0qiTQiiqtWV52T0XzWKU
dO5aXLX2R/jEY6o+CBY0Al7JLITrnJmtQ2xYmFeG3Po2O/EU38Rvu7NNfuxJYNtq
AM6RlToWB2w=
=UrZf
-----END PGP SIGNATURE-----

--fmmR3/qxny8hj3mZ--

