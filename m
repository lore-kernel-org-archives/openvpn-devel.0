Date: Tue, 29 Jul 2014 20:57:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140729185713.GX1118@...1296...>
References: <1406654929-6079-1-git-send-email-jm@...1926...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9HofTgutFzLA+St"
Content-Disposition: inline
In-Reply-To: <1406654929-6079-1-git-send-email-jm@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Julien Muchembled <jm@...1926...>
Cc: openvpn-devel@lists.sourceforge.net

--E9HofTgutFzLA+St
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 29, 2014 at 07:28:49PM +0200, Julien Muchembled wrote:
> Socket configuration of MTU discovery was done unconditionally at IP leve=
l,
> which has no effect for other protocols. This fixes the issue of OpenVPN
> sending fragmented tcp6/udp6 packets even when 'mtu-disc yes' option is p=
assed.

Sounds good.  I'm not sure I understand what that socket option *does*,
though...  will it make the kernel report back any ICMP packet too big
messages received?  Or will it not honour those unless IPV6_MTU_DISCOVER
is set?

Is there documentation for that socket option somewhere?

(Last not least, because I'm too lazy to look: is that patch against
git master or against release/2.3?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--E9HofTgutFzLA+St
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9fuiakuBuNlUUl1AQI76gP+NOw1V24NgY7f1vy1130c2eh+aFppZWsr
WotBP8ok4DUp7f5Z7Es/msbPdfnC34x40nJC8hBhSpx5q6+74sJyGuY8HOQTQwyt
LWhY9E/7HaO0+1xmtAs+76aeXoo5BjHG5cNVLNK8zukBSWovQ3H+35zf6K1q3Nba
mhQi58f8QIQ=
=QeAl
-----END PGP SIGNATURE-----

--E9HofTgutFzLA+St--

