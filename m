Date: Sat, 11 Jan 2014 14:07:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140111130723.GM226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <52D08AC6.7080808@...1227...>
	<52D08C75.8020903@...1790...> <52D1408B.6070902@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FnF+XOoO+XCcZ18I"
Content-Disposition: inline
In-Reply-To: <52D1408B.6070902@...1227...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Tore Anderson <tore@...1790...>, openvpn-devel@lists.sourceforge.net

--FnF+XOoO+XCcZ18I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 02:00:59PM +0100, Arne Schwabe wrote:
> > Jan 11 01:07:47 greed ovpn-server[10222]: ::ffff:84.209.244.191 TLS: In=
itial packet from [AF_INET6]::ffff:84.209.244.191:38878 (via 2a02:c0:1001:1=
00::253%eth0), sid=3D98e4314f 9ea08578
> >
> > I find the "via 2a02:c0:1001:100::253%eth0" part interesting, as that's
> > not even the primary IPv6 address of the interface.
>
> Yeah. We are probably out of luck at this point without implemting a
> socket for v4 and a socket for v6. If the operating system does not give
> us a valid incoming interface/ip combination, we cannot fix that later.

Where's that "via" coming from?  Is that the local socket address that
IPV6_PKTINFO (etc) told us the UDP packet was addressed to?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--FnF+XOoO+XCcZ18I
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtFCC6kuBuNlUUl1AQKL4gQAhemA4kx+XsZS3xt5MgBgAgbNIo82VWKF
o4kSsE8fUwJcLgwmjtzKSrv2dMClbsYoEMyA/yLn4fHID3HSkAaheTAeVl/CvVxJ
H7e1/nlazWSHzhnjhSCSUOPK0zWk41/aMBrvs7GCpkpgt8OD84XYTBggcpUMQHLu
acq9yytK6MU=
=aEYo
-----END PGP SIGNATURE-----

--FnF+XOoO+XCcZ18I--

