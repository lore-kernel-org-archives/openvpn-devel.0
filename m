Date: Wed, 7 Sep 2016 11:31:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160907093100.GF78279@...1296...>
References: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cu2X4S6QpqS+1MBM"
Content-Disposition: inline
In-Reply-To: <3dbe8ad1-b62e-3802-06a9-920c46616451@...515...>
Subject: Re: [Openvpn-devel] Dropping Windows Vista / XP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Cu2X4S6QpqS+1MBM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 07, 2016 at 12:18:17PM +0300, Samuli Sepp=E4nen wrote:
> We have already dropped XP support from OpenVPN Git "master". I think=20
> now is the time to drop official XP support altogether, but to maintain=20
> Vista support util the next tap-windows6 release.

As long as XP is in widespread use, I think we should provide up-to-date
and secure 2.3.x builds.  Worst thing we can do is "not provide updates"
in case a new openssl (or openvpn) bug shows up, and leave users out
in the cold.  So this means about 2-3 more years, I think...  (do you
have numbers how many people still download the XP installers?)

Note that the microsoft guidelines do not say "no more SHA1" but=20
"no SHA1 *unless* targeting Vista", which we do - so there must be a=20
way to get updated SHA1 certificates...


What we should do, though, is declare and document a strict "end of XP=20
support" policy, like "January 1st, 2018", make this very obvious in the=20
installer (maybe even "add a separate acknowledgment popup"), AND refuse=20
to actually start the GUI after that date (or so)...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Cu2X4S6QpqS+1MBM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV8/eU6kuBuNlUUl1AQJNWgP/QSK5AabMCmVzTCdwSylgXrrO0DlHS6hC
zsEY97WJJ6IzzvioUVfDV3aAXb8ClbCuO2fk+WQjCTcgIhAdFaoDWNyJcVfa/iwD
/QD5WKXztaq9C/FAlOY7vh1jo5EgEm8G2NUpYiEnE5Rh6vwH01+3M1cw/tA4vROa
CRe5VGDu/0U=
=/AcC
-----END PGP SIGNATURE-----

--Cu2X4S6QpqS+1MBM--

