Date: Wed, 25 Jan 2012 15:31:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120125143146.GZ5060@...1296...>
References: <1327405130-22393-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HRprdJFjV/kUnvOW"
Content-Disposition: inline
In-Reply-To: <1327405130-22393-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Add
	--route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--HRprdJFjV/kUnvOW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 24, 2012 at 12:38:50PM +0100, David Sommerseth wrote:
> This patchs adds a script/plug-in hook which is called right before the
> network routes are taken down.  This is give external processes a
> possibility to tear down communication over the VPN before the VPN
> disappears.
>=20
> One use case can be to mount a networked file system over the VPN via
> --route-up.  And then to unmount this file system via --route-pre-down

I can see the use case :-) - and the code looks straightforward to me,
so ACK ("I assume that you have an automated test module for that"... :) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HRprdJFjV/kUnvOW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTyASUqkuBuNlUUl1AQIkUAQAipo+zI7Xe5gzJyEBqODu9OLn1dYQRZNq
g0e7ExFCf1D2YoMOxkVREdNcT2KnZfCNHVM9jKI0j4suB9ffh6SZ+HkujqrgXRO2
IOg+V6iymiKYFUOD20bqiC4X3+X5BHje8s+KjHBymMor3jBd8N7wkw8ODJuZ7I2K
mMIT6WgSKa4=
=Xlqq
-----END PGP SIGNATURE-----

--HRprdJFjV/kUnvOW--

