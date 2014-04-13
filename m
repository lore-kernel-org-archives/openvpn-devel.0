Date: Sun, 13 Apr 2014 12:47:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413104705.GL16637@...1296...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ujM2chrfE9t/rZPS"
Content-Disposition: inline
In-Reply-To: <1397366216-657-1-git-send-email-cernekee@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
	ocproxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kevin Cernekee <cernekee@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ujM2chrfE9t/rZPS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 12, 2014 at 10:16:53PM -0700, Kevin Cernekee wrote:
> Sometimes it is desirable to establish VPN connections without setting
> up a kernel tun/tap device.  Possible use cases include:
>=20
>  - Routing traffic from different applications through different VPNs.
>=20
>  - Connecting to multiple VPNs (clients, sites, ...) that have
>    overlapping IP ranges.
>=20
>  - Connecting to multiple VPNs that each advertise their own default
>    route and/or DNS settings.
>=20
>  - Situations in which direct access to the VPN from all processes/UIDs
>    is not necessarily wanted, impairs performance, or presents an
>    unacceptable risk of intrusion or data leakage.
>=20
>  - Multiuser systems or container-based VPSes.
>=20
>  - Other situations in which the openvpn user or program is not trusted
>    to reconfigure a tun/tap device.

I can see that you might want that, but I do not think we want this in
OpenVPN.=20=20

It brings in a fair bit of extra code complexity, more arcane options, and=
=20
code that needs to maintained and tested across all supported platforms.

I think the goal can in most cases be achieved using SSH port forwarding -
or OpenConnect, or a myriad of other "tunnel this file descriptor for me"
tools.  OpenVPN will do tun/tap, and do that well.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ujM2chrfE9t/rZPS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0prKKkuBuNlUUl1AQJYmwQAmCCUe8IL6RFo25dHRf73wUGs9dKOm2lg
nXWjG2EKIVx/Gxxy+pCOSZA/M+/6Yfb8VNFWg00FQSx1+IFOOMe6QnhKMXJKbGZg
QsKq9wW0PLoU5mpMVWedDnKYxM5N6k1bHk0V/rU+GFGhxlaqwH2ojeFfY0nUzama
X2+T7nqmnD0=
=EDqO
-----END PGP SIGNATURE-----

--ujM2chrfE9t/rZPS--

