From: ValdikSS <iam@...2070...>
Message-ID: <5605B40D.6080106@...2070...>
Date: Fri, 25 Sep 2015 23:52:29 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QRFKS2BJK4eXtLp24mpuU2utFcS8mtaCr"
Subject: [Openvpn-devel] Radiusplugin fully asynchronous fork with
	additional patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@...647...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QRFKS2BJK4eXtLp24mpuU2utFcS8mtaCr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!
I'd like to introduce my radiusplugin fork which contain several patches:
* IPv6 Accounting fix by Comic Chang
* iroute netmask computation fix by Samuel Thibault
* IPv6 support patches by Samuel Thibault
* Accounting and memory leak related patches by Dmytro Vasylenko
* Accounting fixes by Yafeng Shan
* Asynchronous client-connect and instant client-disconnect by me

With the latest patch, radiusplugin won't stall OpenVPN's main thread when =
clients are connecting or disconnecting.

https://github.com/ValdikSS/openvpn-radiusplugin

Asynchronous client-connect requires additional OpenVPN patch by Fabian Kni=
ttel which you can get here
https://github.com/fknittel/openvpn/tree/feat_deferred_client-connect

Or you can grab latest stable OpenVPN with this and other patches in my rep=
ository
https://github.com/ValdikSS/openvpn-with-patches



--QRFKS2BJK4eXtLp24mpuU2utFcS8mtaCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWBbQNAAoJEFzXIC7viPdyiXEP/1gr5W1MqcZxf6FVJdFq/w0o
eFrM4dioN+tV67k3cgZ5wqbGWzjpBEjiTb1KSe1DSKnXsDs5yyVbCUc5IHOcPFYR
+1LVZj850zucFt4qcewU5kk3XkDfimWAnYdRw9mXLCTS8vVuH5y478I5U0BQxA0D
02WbvvGZNHJc5HGpHI03mIoFbY3Jcx1FAJlrF/TvfTYWvVzXE/G8M2evil//CpzX
5Z47jBVxRllUyCk9tit53HS3/keqnkHR8TBr92glCD8urooVXvjGcuOy5qoORUM4
pMxZCEJcNBClWRBJK6z6jKk0ET1XSPNReBadSSMUuA6gKajkyIfmAst3D+ogZUvs
pTDbKOtp1SUDo7f0hhf0fS1TqN5jK2d4nq9NBE6U0CAAAGAK7gBXkoGwXXysi2IZ
LdtJQq5EVTUX4LOPleCaeaAzSSFySx0KfsR24j5GBU3y6i2VAKIXOXScfv+/Dq25
tHFj5GyCkxmscvenerjPaypVXFNBKK1A+xGmK75uTEYuJ+bnlomNa/OTrB5hoBeN
y5bfAH0+X0wrV8p+C8hj14bIMMjfK+fKzvJScEv7Wm4EE74U5eYONoNYcPenJ6h8
IHm+WxZ7sMoqXTbR303ueK2VRxmDKXI5zmSB4C1d25nE2+l3J3+a07+u+WSTsC7A
RR6eoMX/joXCrSON6G5J
=ZXXR
-----END PGP SIGNATURE-----

--QRFKS2BJK4eXtLp24mpuU2utFcS8mtaCr--

