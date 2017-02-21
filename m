Date: Tue, 21 Feb 2017 16:39:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170221153945.GC93896@...1296...>
References: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hbEGQ9F0b6kf96/Q"
Content-Disposition: inline
In-Reply-To: <b3afdbf7-ee12-3c1f-b8cd-c30cf3b0a025@...75...>
Subject: Re: [Openvpn-devel] NOTE: unable to redirect default gateway --
 Cannot read current default gateway from system
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--hbEGQ9F0b6kf96/Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

following up on the thread starter...

On Wed, Jan 18, 2017 at 04:43:22PM +0100, Thomas Sch=E4fer wrote:
> This works perfectly as long the client has still an IPv4-connection.
>=20
> But in case of an IPv6-only-client (not system-wide disabled, just not=20
> getting IPv4-addresses by the ISP, e.g. eduroam-IPv6) the client doesn't=
=20
> set the IPv4-default route, since it can not find the old one.

This has been fixed (thanks, Antonio), and the fix will be in the upcoming
2.4.1 release - no fixed date has been set but "in the next few weeks" or s=
o.

Thanks for reporting this application silliness :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hbEGQ9F0b6kf96/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYrF9AAAoJEB2Cnv7KVigScq8MAJeyJAh9LGmIlOvb9AqaBQHu
9dea5NOurSBVifTKHmt8oyHsV+Vh2Umyr66mmTWEiCB+D0jclhbc/fierHAh5Sw2
TbrNgEFH71+3HWbXVdigA/VIJBXCSLSJZ1m/SwbpBP26sNwg+Ppunzj8Xl1QFV0c
zL/FelgzyS4bf5YdwOjf/QdfZzrtecK59xl9sEBGCddylPYyU8Fdkdtq32Egj6/A
45P4sQfSje7L58DL1GqqddGpzNMborZ17bSCs5J1q2T9x7QKQ5OnYAyvD9TeXvVu
6wQGRCd/dX5rerAXB2GRBNQhPIEcxJ/N4P9Gre3G2FXySq5D+F02Wg3QXqJp+ZIw
R3DXsRIt73ajFO/N/7T1VkztBRy9412bbTSbV4+m/g2O8h4rnZ7OhPRnJ7geLNWR
HkrAJSTzA1PW3Cb94mv2VuqHNBUubjeRbvRw/gBJx8soYkWTjD2oUfcgfCl8x3yb
MfhjqnsFT6RlK9W6wZiTeRF3AJ4pApEeSk1nlnz5jA==
=COjY
-----END PGP SIGNATURE-----

--hbEGQ9F0b6kf96/Q--

