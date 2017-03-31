References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
Date: Fri, 31 Mar 2017 22:34:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DOixlWuGAnb75SwEdE5FQQIrOl0m3Pahq"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DOixlWuGAnb75SwEdE5FQQIrOl0m3Pahq
Content-Type: multipart/mixed; boundary="1DaTHaisCbuSUPr0uAW4HeI3r5DlMroDS";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	=?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
In-Reply-To: <CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>

--1DaTHaisCbuSUPr0uAW4HeI3r5DlMroDS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>=20
>     Hi,
>=20
>     We still bundle EasyRSA 2 with our Windows installers and it is
>     prominently advertised on our widely linked to HOWTO:
>=20
>     <https://openvpn.net/index.php/open-source/documentation/howto.html
>     <https://openvpn.net/index.php/open-source/documentation/howto.html>>
>=20
>     As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>=20
>     However, the default values for EasyRSA 2 such as MD5 hashing algorit=
hm
>     and 1024-bit keysize seem totally inadequate for today's standards:
>=20
>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/var=
s#L53
>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/var=
s#L53>>
>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/ope=
nssl-1.0.0.cnf#L57
>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/ope=
nssl-1.0.0.cnf#L57>>
>=20
>     I think we should upgrade these to something more recent. What would
>     more modern reasonable defaults be?
>=20
>=20
>=20
> someday we decided to use DSA (instead of default RSA)
> it worked ... until we started to use OpenVPN Connect for iOS.
> next, we had to change back to RSA
>=20
>=20
> the conclusion would be "test all available platforms and take a
> decision", probably even set up special test server and ask people on
> openvpn-users mailing list

Always a good idea to test as many platforms as possible.  But we can
also leverage all the testing which have been done indirectly by others
as well.

The suggestion from Samuli is to update the default key size and hashing
algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
the recent SHAttering panic, which have its own set of challenges - and
should not be used for certificates any longer (if I have understood the
crypto-gurus correctly).

Also considering that the "world in general" have been moving towards
stronger keys *and* have moved towards SHA256 hashing in certificates,
updating EasyRSA is more than reasonable.

So, I would highly recommend using SHA256.  I have used that for my
OpenVPN setups for several years already.  That works fine for me, and I
know others have done the same.  This is actually the most challenging
move, from a technical point of view - using a new algorithm.  But this
algorithm is well supported by all OpenSSL and mbed TLS implementations
OpenVPN can be built against.

Secondly, updating the key length from 1024 bits to at least 2048 should
not cause any issues at all.  Many users (myself included) often use
4096 bits keys without any issues.

Swapping RSA for DSA is an issue of a completely different league. And
DSA is by OpenSSH considered too weak; IIRC it was even removed in
OpenSSH v7.0.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--1DaTHaisCbuSUPr0uAW4HeI3r5DlMroDS--

--DOixlWuGAnb75SwEdE5FQQIrOl0m3Pahq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY3r1MAAoJEIbPlEyWcf3ylw0QALOizmsSc8y7yHpdgRWrK85M
qrlP9eHXl6JAdSfo1yVrsBSXH5w+8Cm2ldp90WFHV8glEA/x2HQSYEDfrL/jHCQF
9AUj9G7pv4UyeWK4pruY571EGEErSArVuWFz8HgGB2NqjARtoNqU4jASMWURDhce
lssqRMFA8X64PiouLS1yH36ENBE4Cftq7GTNBLrvxMWfWqUKqls8ZTEQDyrhHyG3
yrUepab5ZgAWH0vQkd8HrJh9UHG9uUv51FAWkVRAudyX2LwFqx3NMZBl2bR7nnlh
KjbDdEBRDgFC/asTZZ+2cYZw7N10Nwzh5s+e0ss/6KOplS3a6x1biSwjTsKaVekh
y2y8hGiadscpyzaLx98HBo/3Rbl0jEzSkGcpL57d35/0efThJJu9PR+Wp6irgPJP
56RoN5iWL+S6ZCKOPeum6NMan24WWTVBzU+BPmz+IKF4bSKdgQDbnskkTp8ifD4r
gGsLYH3y/jNkRtqO+vAOgZvRfrH2Jbud+KQo16k137jTdT6+uxd+RYflpePf9JhB
Yr0FXdfmn2qT5LrfLLbSoUIVnumXWL5J4MxMXI1688kV/sDfGi5r7UCjrOdrcSNj
dR97Zf+IbbtNZNAjMJPwbO2CVxWpcEYSPh5q6Lfep6N9i73XqWfp+EHJAo3/QfL0
YpuAjKg6kbz+2PXcZ4qI
=O28j
-----END PGP SIGNATURE-----

--DOixlWuGAnb75SwEdE5FQQIrOl0m3Pahq--

