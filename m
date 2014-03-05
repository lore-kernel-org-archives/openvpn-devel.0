Date: Wed, 5 Mar 2014 06:53:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140305055316.GM16637@...1296...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
	<53163C6D.7050801@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a6+ItBDHwozfXKFj"
Content-Disposition: inline
In-Reply-To: <53163C6D.7050801@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--a6+ItBDHwozfXKFj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 04, 2014 at 09:49:49PM +0100, Arne Schwabe wrote:
> a) it won't work with a learning switch either or
> b) OpenVPN learning switch implementation has a bug
>=20
> I would like to have either a) confirmed or b) fixed than to included a
> band aid.

It looks like some sort of proxy-ARP where the ARP is *forwarded* instead
of being *bridged* (=3D new ethernet frame, unchanged payload).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--a6+ItBDHwozfXKFj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUxa7zKkuBuNlUUl1AQKtGgP+OsLXMA3CKAZYBw+emmsSlEA/fNzHukY9
rrZl1Uc8VuEb+He7thvMbph8mHdm3QLZAbN7WVOTrrx/jd4ZAo5/TCC1tpHsEG5E
lwEFXr+r791oxf8RoCATCSOIbF423rk4W61Rn3dSd73QQw8Lt0wa5dhoalkOHg0r
ROpBf74ddV0=
=RX9s
-----END PGP SIGNATURE-----

--a6+ItBDHwozfXKFj--

