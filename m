Date: Sat, 11 Jan 2014 10:48:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140111094837.GJ226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KLR62ZwG+3BuLtMl"
Content-Disposition: inline
In-Reply-To: <52D08946.6010906@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--KLR62ZwG+3BuLtMl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 12:59:02AM +0100, Tore Anderson wrote:
> FWIW: Now I also got to test git master with what I wanted to in the
> first place, namely to see whether or not all the nice dualstack changes
> had also made "multihome" work for IPv4-mapped clients coming in to the
> server on an udp6 socket (ticket #306). Unfortunately that's still
> broken, and it seems that for a server process "proto udp" is still
> IPv4-only. So it doesn't appear to be possible to get a functioning
> dual-stacked UDP server (that has multiple addresses/interfaces) at the
> moment.

I *thought* that both proto udp and proto udp6 would create an IPv6 socket
bound to :: with IPV6_V6ONLY set to 0 (=3D accepting IPv4 and IPv6 packets
to any address).  Only "proto udp4" should listen to 0.0.0.0.

(There's a catch to it, IIRC - *BSD will show the socket as "udp46" in
this case, while linux will still just display "udp6", even if it *does*
"46" on it)

Now, --multihome is a different issue - I accept that this isn't working
right in various scenarios, and we need to fix this.  But at least dual-
stacked servers with "proto udp" are expected to work.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KLR62ZwG+3BuLtMl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtETdKkuBuNlUUl1AQL1AQQAt5B6eo1H0uFHzZyBWMb4Ee0VzexdZmpp
bfBHw4pGlYtfp++s/Lfm7TG789twfCWagXZ/6P321ilKrcXPDxrk6j/Z5YvunfzD
AlIgNCbFe71HHwJfYodCX8jIoAw/IRT6trnYLXNUT3QJ8DI/hw68C0CErwRy4AP7
KYiqkRkloSE=
=1/+8
-----END PGP SIGNATURE-----

--KLR62ZwG+3BuLtMl--

