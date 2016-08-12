Date: Fri, 12 Aug 2016 23:02:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160812210223.GJ78279@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471031614.4080.135.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fL5uibfitsvsbG47"
Content-Disposition: inline
In-Reply-To: <1471031614.4080.135.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Change timestamps to POSIX format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

--fL5uibfitsvsbG47
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 09:53:34PM +0200, David Woodhouse wrote:
> On Thu, 2016-08-11 at 21:23 +0200, Gert Doering wrote:
> > All our timestams used to be "what ctime()" produces, which is
> >=20
> > =A0 "Thu Aug 11 21:15:27 2016"
> >=20
> > Changed to use POSIX standard format, which is
> >=20
> > =A0 "2016-08-11 21:15:27"
>=20
> While you're at it, perhaps also add the timezone in numeric (=B10000)
> format. It is often the case that servers logging in their own random
> localtime make it difficult to correlate logs from hosts in different
> parts of the world. The general rule of thumb is that a time without a
> zone is meaningless.

This is a good argument.  Unfortunately, it's a surprisingly *hairy* one,
as there are time zones that do not have a full-hour offset - so ISO 8601
(according to wikipedia) says you should do "=B1hh:mm" then - and for
most folks, ":mm" would always be ":00", sort of waste of screen real
estate...

Regarding portability, this is even more interesting.  I assumed that
localtime()'s "struct tm" would be truly portable, but it seems that
older unixes have "long    tm_tzadj; /* seconds from UTC */" while
modern ones have "long tm_gmtoff; /* offset from UTC in seconds */"
(WHY OH WHY???)....

 * TZMINS_USE_xxxxxx specifies how to get timezone offset.
 *
 *	TZMINS_USE_TM_TZADJ    use (struct tm*)->tm_tzadj
 *	TZMINS_USE_TM_GMTOFF   use (struct tm*)->tm_gmtoff
 *	TZMINS_USE_TZAZ_GLOBAL use "timezone, altzone" externals
 *	TZMINS_USE_TZ_GLOBAL   use "timezone" external
 *	TZMINS_USE_FTIME       use ftime() function
 *	TZMINS_USE_TIMEOFDAY   use gettimeofday() function

... from ports/elm/lib/get_tz.c...

(I don't think anything but tzadj/gmtoff is relevant anymore today, but
need to check more systems.  And no, strftime() isn't helping - it
has "%z", which, according to FreeBSD's man page is an extention to
the C90 standard...)


I think I can see why James just used ctime() here :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fL5uibfitsvsbG47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV645XqkuBuNlUUl1AQIhiQQAg9ad+odB+lyYTKYZYS6hENvRFhr+Jb91
mQV95QiVGVBRfA2BiyOLr8YQG730Nt4MlUHtjp65KlPpyj1tzRDpSH1NFHm1dcCm
Kb8IR79rN9kR+SSl2cmMPRn0dTXueXwiUnq4aAU+O0Y6WvcesRXuptMsI/S486dq
FoXtOYBYAbA=
=hli1
-----END PGP SIGNATURE-----

--fL5uibfitsvsbG47--

