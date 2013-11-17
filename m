Message-ID: <5288B114.8020003@...1114...>
Date: Sun, 17 Nov 2013 13:05:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20131117104002.GA161@...1296...>
In-Reply-To: <20131117104002.GA161@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dhj4gpCjKfnwbSvoFKnHIS3vuxkb07RVO"
Subject: Re: [Openvpn-devel] Windows TAP driver and NDIS 6.0
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dhj4gpCjKfnwbSvoFKnHIS3vuxkb07RVO
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17. nov. 2013 11:40, Gert Doering wrote:
> Hi,
>=20
> just so it does not get lost: here are the microsoft pages about porting
> NDIS (miniport) drivers to NDIS 6.0
>=20
> http://msdn.microsoft.com/en-us/library/windows/hardware/ff570025(v=3Dvs.=
85).aspx
> http://msdn.microsoft.com/en-us/library/windows/hardware/ff570059(v=3Dvs.=
85).aspx
>=20
> so, looking for volunteers now :-)

Just to explain a bit further.  WinTAP is currently using the NDIS 5
API.  If we have understood this correctly, NDIS 5 is on "life support"
in Vista, Windows 7 and Windows 8 - in the way NDIS 5 drivers are
running through and emulation layer.   And there is some expectations
that NDIS 5 support will disappear in Windows 8.2 and later.

It would be good if someone can consider to help out here, so we can get
an NDIS 6 port in place before NDIS 5 disappears from Windows.
Otherwise we might end up with a non-working Windows version of OpenVPN.


--=20
kind regards,

David Sommerseth


--dhj4gpCjKfnwbSvoFKnHIS3vuxkb07RVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKIsRQACgkQDC186MBRfrrm1wCfRiEbCOBzjsozAWX6sLh+7vaY
zagAnR3gcv/FY4xbxfrWYnP5T0ABGQvH
=O36v
-----END PGP SIGNATURE-----

--dhj4gpCjKfnwbSvoFKnHIS3vuxkb07RVO--

