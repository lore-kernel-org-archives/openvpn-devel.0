References: <20200809141922.7853-1-arne@...1227...>
 <c0f5d0c9-f877-c2f7-6d03-0652f4081844@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <10290936-d39a-4cbf-0e56-b72c2f068d50@...1227...>
Date: Sun, 9 Aug 2020 18:22:43 +0200
MIME-Version: 1.0
In-Reply-To: <c0f5d0c9-f877-c2f7-6d03-0652f4081844@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4gruMFcDWVd9dip8TjkYC6Ix2qSqhXcNn"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4gruMFcDWVd9dip8TjkYC6Ix2qSqhXcNn
Content-Type: multipart/mixed; boundary="ih1ThzyTM4nfSvqP1zpC48qKlfLhQY4Ea"

--ih1ThzyTM4nfSvqP1zpC48qKlfLhQY4Ea
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 09.08.20 um 18:14 schrieb tincanteksup:
>> +=C2=A0 If no common cipher is found during cipher negotiation, the=C2=A0
>> connection
>> +=C2=A0 is terminated. To support old clients/server that do not provide
>> any cipher
>=20
> clients
> (remove /server ..=C2=A0 I think this is what was meant?)

No, old clients/servers. If you connect to an old server you might need
that option too. See the follow up documentation patch.

Arne


--ih1ThzyTM4nfSvqP1zpC48qKlfLhQY4Ea--

--4gruMFcDWVd9dip8TjkYC6Ix2qSqhXcNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8wItMACgkQFRhsZwKx
RFQG4g/9GUvd9ZJ0F4FCpcKNEc7grjCBe0CyXNiGXXD3iQlP0fsLAp4VjtM6eu+Q
y+cgM52wK9HMJGziW4Zw3xr9oX6pmaitlUAq5PNeLaWhqXJINX2UXnEHoggDAW4C
XimO41I37DxyU/45VRXdDUuaTwLzHjs4GPRB/ojldry9XWXLqkJ/Rbjp1+maR2H2
xhoHOH2en9E/DJAK5/tkMFaKUx1whN8WyX4sD3z5P89YJBafMCUYZv0Yz70SGnbV
f/CiTdiTNPkS6Pb52GMv8kRTMZpaxv0/jXt4+7ZKVZ2BwdSsMVT0GvQad+87xMXD
ZK6dxfAFaNXkF1m38r3QKYWINiVT4Oevzz1MabWAQFMCp3VKq330v0NcVfesr1kc
RYBY3tVtugnyxYL2QeoJV5pTYuVF3rG9deesaqhT1KxllNsZoZRYc2P7XN59a10N
OdRdj4NiJroQE6wxPKkqf/b2PixGljcLCqGEKk0Cf6zXSbo6o5t99zmDSNGMn9Lo
6PNNWYCfZJ6S67I8RtJc3V8ZH+gbQbTMJoMVnEmuTHhtyHbLOqae96WtdHIh4bCf
SM7HROWaW/OEz8dg0LyLhdaXg2LZBg2ULd+u+ZkNa7vy1aJjzdaiCMhmCESHcrVl
kwPD2A5VwENNI7dMLSGyPVGDePvfaEvdTmIzMA3o1l4Dk3jkSzE=
=QjuL
-----END PGP SIGNATURE-----

--4gruMFcDWVd9dip8TjkYC6Ix2qSqhXcNn--

