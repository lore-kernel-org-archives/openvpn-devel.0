Date: Sun, 4 Oct 2015 22:39:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151004203959.GC22054@...1296...>
References: <1443786401-30416-1-git-send-email-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <1443786401-30416-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] This fixes MSVS 2013 compilation.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 02, 2015 at 02:46:41PM +0300, Lev Stipakov wrote:
>  * Tools version changed to 12

What exactly does this do?  ("I should understand the side effects" :) )

>  * Added comp.c/h and compat.c/h to project files

The description is wrong, as it is compstub.c/.h - I'll fix this on
merging, so no need to re-send.

Did you also test building with the GetIpRoute2() patch in
http://thread.gmane.org/gmane.network.openvpn.devel/10085 ?  I'd like
to merge that, but it might break MSVC compilation due to the stray
typedef (which is needed because MinGW headers are incomplete in that
respect)

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhGOn6kuBuNlUUl1AQIZTwP8DLj5yH7Re74LzFtO3sGcME5YIqaeowHZ
Ap1uggOCdWNCw79Np/6LWz84ANClH6ioYUZ6A91iO9MXk5iuQVDv8x1tuwq1w30m
1+chwLc1080L8D18UCAFOZ/59B8wLOGg2huQRoS+D2Kuz8Sry4/j4IIcE1vYb2La
6ps5glHAmWo=
=wd79
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--

