References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...>
	<007901d16a6d$3e9f1e90$bbdd5bb0$@gmail.com>
From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C5F836.90409@...277...>
Date: Thu, 18 Feb 2016 17:58:30 +0100
MIME-Version: 1.0
In-Reply-To: <007901d16a6d$3e9f1e90$bbdd5bb0$@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fdHPC1u9eRI6tqAPfMXcaQCFjJdAlV5e0"
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>, 'Steffan Karger' <steffan@...1856...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fdHPC1u9eRI6tqAPfMXcaQCFjJdAlV5e0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

W dniu 18.02.2016 o 17:55, Fish Wang pisze:
> Hi Jacek,
>=20
> I'm definitely no expert in AFL, but it's a great tool that has shown gre=
at potential.
>=20
>> ... it would be good
>> to modify the server to use stdin/stdout (or dev null) for network I/O
>=20
> You might want to try https://github.com/zardus/preeny .
>=20
> Best,
> Fish

Yes, preeny would definitely help, but still some projects make some
network operations or use stdin before they handle network, which is why
I explicitly mention that this has to be done. It might be easy, it
might be not - depends on what OpenVPN actually does (I hadn't looked at
its protocol yet)


--fdHPC1u9eRI6tqAPfMXcaQCFjJdAlV5e0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxfg2AAoJEGlViymZXJRvWk4P+gO9cN13pUjC2XjGwrRoCHnK
iMfAPztLYTV4B5ZucshbmUStkVz13y4gn8hX1knDRuyjNxJtfm1XK9z8Ns+4FSbI
Nj0E2C8SMWJ12/Z0k5l8JrCp4W1JuV5DH4ubUnzcN0L76CK7zfW+o2IM8KhvYfYw
SrHd4SFKgUq5jRtO7Cq9Wu2WaksBKThC+EjrbtIPbSe/l9MCLKkm/rI9jjphxpnJ
mH1FYtFHhUKy2vX+ZGI+jETZKP5Xk7B/h5ZCyxCzG4vmdJHvUad17sbUA0Vy60gZ
ql6mUTfJojZUG3REiRjNizUsc30wm6RfMqq5Rug9A+uftWo4JDAFF+Mb1z5j0O/K
CYXkmy9tk09iiSd0jdOi8knZzLAJ+f87Z7WTqUFu7Io/nGB5tDj88oL6OBmXOYYF
PG8EzxxmYQgFgJGLclp1g/qj/mCrO37Z5maMs+tUA4OPAR/La09zDbYTQ8ldgCte
CHqAubKRD/Zb/bQNQ486WWtHirztiRgHyZKMZEMuRLX9mwoTfDZa8AD8YDT/IeB5
f7zMFhd3OUaDjEz8MoGgcfsusjAXpaVVhL8rMOq1PnP1on46/YKSaaYew864xUl5
QsNFs8VHbst6lgaG3Tv9r5eLpGrltbAx/UBRvOElFFVNMZXZgs+KeCTIdbv+SrJI
ShZNMn5XBWiJg5UconFR
=L7os
-----END PGP SIGNATURE-----

--fdHPC1u9eRI6tqAPfMXcaQCFjJdAlV5e0--

