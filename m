Date: Thu, 5 Dec 2013 14:34:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131205133420.GS161@...1296...>
References: <OF05315ED1.21B1F5C0-ONC1257C2B.0035DBF4-C1257C2B.00362669@...1846...>
	<20131122101521.GZ161@...1296...>
	<CAN_jwOsZ52oxbv9tRxMbSN3Edbr6adUeWOn0V7D-iaOQsZhU=w@...278...>
	<OF3A5C5E15.B8A20868-ONC1257C38.002E17F6-C1257C38.004782F3@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z8f2J9UTMudV0TfQ"
Content-Disposition: inline
In-Reply-To: <OF3A5C5E15.B8A20868-ONC1257C38.002E17F6-C1257C38.004782F3@...1846...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak? (addendum3
	and 4)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net, Brad Zhang <hebei5000@...277...>

--Z8f2J9UTMudV0TfQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 05, 2013 at 02:01:05PM +0100, arno.odermatt@...1845... wrote:
> thank you. Yes, it is acceptable.
> From our point of view, it still seems, memory not to be released=20
> properly, when a disconnection script has been run.
> In our environment with O-VPN 2.3.2, when we start to disconnect large=20
> amounts of client sessions, using the disconnect script, memory seems not=
=20
> to become freed, and therefore can not be re-used by other sessions. This=
=20
> is a problem, since the app might  run out of memory again.

"Not being free()ed" and "not being returned to the OS" are two different
things.  So unless you see a memory increase on reconnect, I'd guess it
is "memory is free()ed, but due to whatever reasons not returned to the
OS by the malloc library".

(In your case, it might be worthwile to investigate linking with PolarSSL
instead of OpenSSL, as the memory footprint is *much* smaller, from the
numbers Brad posted)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Z8f2J9UTMudV0TfQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUqCA3KkuBuNlUUl1AQJIwwQAxmOPhA+Vwve2VyhRRJzitdol1lfQZAmH
2K2ZFWUWLu2dn4ocKRQYJe3Z/AsDJgWCz6vH9gMzxvcBvmH0+GVUY6S7Amy6XXTs
WWYRLZO/Imx4TgV5qvEMSyti+jam307zAiTAI4aWeBfp1Rw0D5hNrd2BBcJ0z1mz
NbjPlL/D9/k=
=sy+y
-----END PGP SIGNATURE-----

--Z8f2J9UTMudV0TfQ--

