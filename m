Date: Sat, 14 May 2016 10:25:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160514082502.GR53051@...1296...>
References: <1463122492-701-1-git-send-email-steffan@...1856...>
	<201605130732.u4D7Wg3R033181@...2054...>
	<57364A87.1000608@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uglrMb9l+pHSuG/B"
Content-Disposition: inline
In-Reply-To: <57364A87.1000608@...68...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix polarssl / mbedtls
	builds
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

--uglrMb9l+pHSuG/B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 13, 2016 at 11:43:35PM +0200, Matthias Andree wrote:
> Thanks to both of you.  The FreeBSD ports' POLARSSL option is now fixed,
> and I have removed the BROKEN mark.

Thanks.  There a few additional minor patches that can go into 2.3, and
I'll wait a few more days if we broke anything else in 2.3.11, and then
we'll do 2.3.12

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uglrMb9l+pHSuG/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzbg3akuBuNlUUl1AQKkxAQAncZ4njImvAEDAu7kf/FFcngj94xAbwrp
IwAtkyjhdc1HTJ0Rt07No1fiRSDsI+HR/qD3BH92Tv2KTZcv0p1+e5+Wjwl+uOO1
Wvni/2rU4gSI2AyFyEJ6OefX7UReh7fSVbPHpkIUrk7eZw2+ReQ9XoG5GBA/7aN1
yrLgn5Y+OQE=
=mHXq
-----END PGP SIGNATURE-----

--uglrMb9l+pHSuG/B--

