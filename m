Date: Sun, 27 Dec 2015 17:29:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151227162932.GZ24952@...1296...>
References: <CAGyAFMXoH2aXQwn84AiV0c=OP2Rhv6i1-D_E+RXMXu8ZQFTvVA@...278...>
	<20151220134642.GY24952@...1296...>
	<CAGyAFMW_qSWu=Y1DfYai=ENLP-nk1hebMaYykAa5HJXVfQy3qA@...278...>
	<20151220181920.GZ24952@...1296...>
	<20151226093550.GW24952@...1296...>
	<1451229586.19364.9.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kiXYN7DNIDEmnA+6"
Content-Disposition: inline
In-Reply-To: <1451229586.19364.9.camel@...1866...>
Subject: Re: [Openvpn-devel] XP broken  (wrt IPv6 in 2.3.9)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: ValdikSS ValdikSS <iam@...2070...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--kiXYN7DNIDEmnA+6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 27, 2015 at 03:19:46PM +0000, David Woodhouse wrote:
> On Sat, 2015-12-26 at 10:35 +0100, Gert Doering wrote:
> > but, unfortunately, it is not available in MinGW.=20
>=20
> Point of order: this is the kind of statement which should normally
> never be seen without an explicit reference to a filed bug.=20

Yes, right you are.  Though I don't truly feel qualified to open=20
bugs against mingw, as I do not follow their releases well enough
to know what *should* be where (I don't even know which windows=20
version stuff is in...)

> In this case, however, I think it was fixed without a bug ever having
> been filed: http://sourceforge.net/p/mingw-w64/mingw-w64/ci/a883b47a
>=20
> It was also backported to the 4.x branch since the 4.0.4 release and
> will be in 4.0.5 (and is in the Fedora packages already).

We might want to add it to our compat/ stuff...  (this is a case where
I find autoconf totally useful :-) - "if this header file is not present,
use compat-versionhelper.h instead").

But anyway.  Working on other corners right now, leaving this to the
windows team.

thanks for the pointers!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kiXYN7DNIDEmnA+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVoAR66kuBuNlUUl1AQIl8gQArev6X19EDKv5QdTiPyAqlotiNedPwIUF
+LBbA9tu7ySjM/tCnCLqKam4E14xtgVt2Kcki/k4UOxcSAYDfIi8jwA++RZlNMII
JBgcoRRCep6JUcwImA+IX65Wzo/m+rphY8Ihaw8LKLutAbFxOGdaWI7hkv0n9Det
4V8lxm+D4Sc=
=TWO9
-----END PGP SIGNATURE-----

--kiXYN7DNIDEmnA+6--

