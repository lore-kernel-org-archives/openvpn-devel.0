Date: Tue, 15 Apr 2014 13:00:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140415110052.GB25405@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
Subject: [Openvpn-devel] RFD: "--ignore-ipv6-failure" switch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

a few of my users are driving me nuts, by unchecking "[ ] IPv6" in their
windows TAP adapter settings, and then complaining that their OpenVPN
is not connecting to this customers' server properly (because netsh.exe
fails to add an IPv6 address, and this is considered fatal).

Now, I don't actually *need* IPv6 there yet, but I want to have the
infrastructure fully ready when the first customer comes asking for
"will your product do IPv6?" - so I do not want to turn off IPv6 on
the server, but for this sort of users, it would be good enough for
now to disable IPv6 on the openvpn client, or just make it "ignore that
error".

So I propose to add an option (yay)

  --ignore-ipv6-failure

or such, which would make the failure to ifconfig/netsh.exe/... IPv6
addresses a non-fatal error - log warning, unset tun_ipv6 (so routes are
not installed, which wouldn't work anyway), go ahead.

This would be pushable, so I can send it to problematic clients by means
of CCD/ - and thus I also know who needs personal attention later on,
when I can lay my hand on their laptops.

Comments?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU00RZKkuBuNlUUl1AQJf6wQAs1imgHj5QOsZeQzx2gTKX8c547vLIdXG
RfUuKRAAEmSRRMvfbHCe5dEYdFSqEArhU40uhfDzy0o2eOutd2f+2naetaLcB/p/
h2TO7rBFMSV6FZfXmOXVi1y8wjx3tTTjoE/pFXdFD9/BfoFcQgzz4Dunuk8lM9Jx
icq0s9MvEII=
=g4oW
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

