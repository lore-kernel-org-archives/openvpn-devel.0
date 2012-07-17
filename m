Date: Tue, 17 Jul 2012 18:52:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120717165234.GY22125@...1296...>
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0LdhqWfziiBVv4P"
Content-Disposition: inline
In-Reply-To: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] make non-blocking connect work on
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--E0LdhqWfziiBVv4P
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 17, 2012 at 06:19:53PM +0200, Heiko Hund wrote:
> Instead of EINPROGRESS WinSock2 returns WSAEWOULDBLOCK if a non-blocking
> connect(2) cannot be completed immediately.

Feature-ACK (thanks for fixing :) ), and given the preceding discussion,=20
code-ACK as well.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--E0LdhqWfziiBVv4P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAWYUqkuBuNlUUl1AQIwMwP/bgAWyfnQAv8iqZyBG853kLwiKe2YsoNl
hP0bLq23nsr1F6wo61ehhmmv5AY/x1+zdjo00jsHDBk7QEJBW2AcjyP3P9Wsb+n0
xa2trjb7LakmblsTUSy0nHXoh86DpeQrfvN2WMk/2D95ll6BxeZiFg6JyZW/trZQ
k6Sqmwyp66o=
=wWWZ
-----END PGP SIGNATURE-----

--E0LdhqWfziiBVv4P--

