Date: Sun, 9 Feb 2014 16:19:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140209151951.GU16637@...1296...>
References: <52F6E3AF.1080400@...1030...>
	<20140209115057.GT16637@...1296...>
	<CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yzCAVeWw9RvyYzgB"
Content-Disposition: inline
In-Reply-To: <CAAbSJMUyKqqup1-nBuUsXNVuaaj93YWg0JxcqeBicU1QhtTrkw@...278...>
Subject: Re: [Openvpn-devel] --local, --lport and --bind
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mickael Chazaux <mickael.chazaux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--yzCAVeWw9RvyYzgB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 09, 2014 at 02:41:58PM +0100, Mickael Chazaux wrote:
> Although it is not easy to find on the Internet, you can bind a client
> socket to a specific IP adress, while setting the port as 0, meaning
> "choose for me".=20

Ah, good.  So there *is* a "I do not want a specific port" setting.

Seems we need to improve documentation :-) (but maybe the new code=20
from Arne that went into 2.4-to-be already does this properly, as in,
"not require --lport setting for --bind")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yzCAVeWw9RvyYzgB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvecl6kuBuNlUUl1AQIQ/QP/SeDuqYDNiLls1iKVyEUQ2IQDDYAPSX3L
9HQh2YeCMkI5Z6faqkjWXuOiBIV0P0HrMSmpJa+4anOa6tGqG21jfBSRle8mgZQh
nyHZ/6sbrAS9KCKsDHfnY9epyuIFl5lTWQGgBcAP6eGObnexY125vY0e+xbVMs1r
uNXDpffuiH8=
=OgnZ
-----END PGP SIGNATURE-----

--yzCAVeWw9RvyYzgB--

