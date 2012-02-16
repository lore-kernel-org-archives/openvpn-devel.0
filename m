Date: Thu, 16 Feb 2012 19:26:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120216182618.GL7024@...1296...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-3-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="08ATZu8fEq0x2T3M"
Content-Disposition: inline
In-Reply-To: <1329413441-22538-3-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] do not use mode_t on Windows
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

--08ATZu8fEq0x2T3M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 16, 2012 at 06:30:39PM +0100, Heiko Hund wrote:
> The MSVC headers do not define mode_t. open() uses an int for
> the permissions instead. Fixes building with the MSVC based
> buildsystem.

ACK.

(I was slightly worried that this might break mingw building, but
David assures me that you've tested this :-) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--08ATZu8fEq0x2T3M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz1KSqkuBuNlUUl1AQKjDgP+OrB7Lr6ACoqWY6Qky9j8LwXvYuo9Ey8Q
es3mp3WFCoQh3IykCBzowKPh4AfTReT62f9lhwSsGixaQzi13dojZOc6SUCAVY0U
gIgK5DTkXqKo3x7SOWA5L51Wi19e+uRLsX6Ip4OZafY0DIEia0T9PFOw+M9zZ8Xn
DSSYS4ra76A=
=1Zl5
-----END PGP SIGNATURE-----

--08ATZu8fEq0x2T3M--

