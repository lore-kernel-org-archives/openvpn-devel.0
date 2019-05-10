References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-7-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <96d8f57b-e78f-578c-10f4-6ed2ce87cec2@...1227...>
Date: Fri, 10 May 2019 14:24:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-7-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="irlfpYN9lUlpUXk9nGOdp8HYE8DU3dwTm"
Subject: Re: [Openvpn-devel] [PATCH v3 6/7] unit tests: implement test for
 sitnl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--irlfpYN9lUlpUXk9nGOdp8HYE8DU3dwTm
Content-Type: multipart/mixed; boundary="15HjknwTokstQPCPOBqGa8JE3LVTnWFQR";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <96d8f57b-e78f-578c-10f4-6ed2ce87cec2@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 6/7] unit tests: implement test for
 sitnl
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-7-a@...2181...>
In-Reply-To: <20181219050118.6568-7-a@...2181...>

--15HjknwTokstQPCPOBqGa8JE3LVTnWFQR
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> This patch introduces a new unit test that is not executed
> by the cmocka framework, but rather used by a new t_net.sh
> bash script.
>=20
> The idea behind this test is to ensure that invoking sitnl
> functions or running iproute commands leads to the same
> networking (interface and routing table) state.
>=20
> To achieve this, the t_net.sh script first runs a binary
> implemented invoking sitnl functions and then takes a
> "screenshot" of the state. Subsequently a series of
> iproute commands, expected to mimic exactly the same behaviour
> as the sitnl functions invoked before, are executed.
> The final state is then compared with the screenshot
> previously taken.
>=20
> If no mismatching is found, the test is passed.
>=20
> The current unit_test, however, does not cover all the
> sitnl functionalities and it is expected to be extended
> in the future.
>=20

I first wanted to make a remark about the usage of seq but trying to run
the test on OpenBSD is pointless anyway, so:

Acked-By: Arne Schwabe <arne@...1227...>




--15HjknwTokstQPCPOBqGa8JE3LVTnWFQR--

--irlfpYN9lUlpUXk9nGOdp8HYE8DU3dwTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzVbZEACgkQFRhsZwKx
RFTiYA/+LL27EExACS0A5OcrOjTBgueBpbczyPYZNi+aWOqne3Tg8tSCjbnKw1A7
KkNEs2q72rNWhWJ0w2IxSYLpZkb1ZGHjTp10XVzsgtqksf+mg6NHgFhFK9K0SmzF
5Jw4X5uKLsoq73s1Q2alD6EpCavGMQsv3Vokjb8457XyiXKQ/Hk/ZSmf0YKdLXf7
KOeMb5ZStllsa51RoHQNUpTlzhNZ0D2H7Cs0zp9IxRVush0jWVOqnyZexOs/pifm
+H5UOytT09pmB/i6A5S4umFMux6ILeOGPm75rs4YizYOW2qjP8u1ZhyR1tKtHGAu
I20JzZiU9sLguadud5UHuuh9zjHDQ8iqptsKt3aKsed3BvibmnID4J93uyNRsJMu
+MlQ6GTW6Ioe4ndLu82KilsH6sgia8egX4rajVwJhYQnM9i8slR2LNq7vlmCprSc
jhqjLyR5u3p9v6xnxaiF7ZFvk2dmll4Il+PEur4NYALnHMFqJLCEO0V+3Iw5QEHN
LWmXSkKCNcN/3fxNtwq0rmbKi5wF4neNhAz6ML9LHDThF4uftsPWkfG1tS2jI7Wa
jnFKLWb3uIu6pc2XXDCHEWw9tT62y/2r5BvTwqI8IHz6O8VXOkRvH/202wtLfqh/
64m82dRxCHzjkwlvV7UukKZ8mwyBTYhVNpsOi+K28HPz/oOGTcI=
=TI31
-----END PGP SIGNATURE-----

--irlfpYN9lUlpUXk9nGOdp8HYE8DU3dwTm--

