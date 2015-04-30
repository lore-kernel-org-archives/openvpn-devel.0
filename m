Date: Thu, 30 Apr 2015 15:31:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150430133146.GK382@...1296...>
References: <1430398960-10300-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rEjiS+nMGFQ7Kkj"
Content-Disposition: inline
In-Reply-To: <1430398960-10300-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] plugin-down-root: only include <err.h>
	if system has it.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0rEjiS+nMGFQ7Kkj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 30, 2015 at 03:02:40PM +0200, Gert Doering wrote:
> down-root.c was missing an #ifdef HAVE_ERR_H around <err.h>
> (only relevant on AIX, it seems)

Ignore that patch, please.  While it makes the compile error go away,
of course it will (sometimes... wtf?!) lead to a link error, as err()
and warn() are not there either...

New patch not using err()/warn() coming.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0rEjiS+nMGFQ7Kkj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVUIuwqkuBuNlUUl1AQIMggP/VRFs/zjlKngIX0jaEF3TBlQ6ykHmJJVC
pmkhIXl00AJD2tFmXveiTzgM9gEEv8iKdmWh3q6cnM5HyihZsFcKHq8NBV5N0km0
oaHsLBHDVC34YeXkWrIX7fDrRSlXH//fRBGeYCKWZB7Qeu7Sn+xvDf097GSMoPt3
71LFKdhXO8c=
=njOh
-----END PGP SIGNATURE-----

--0rEjiS+nMGFQ7Kkj--

