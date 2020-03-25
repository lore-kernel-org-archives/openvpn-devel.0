References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
 <20200324143702.21f24651@...1265...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <efc9cf7f-7b20-bb92-08a1-8364490c579f@...1227...>
Date: Wed, 25 Mar 2020 12:50:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200324143702.21f24651@...1265...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IvncbpZFZTo30kl1GYIdhlp764rpNxQlL"
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <lists@...1660...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IvncbpZFZTo30kl1GYIdhlp764rpNxQlL
Content-Type: multipart/mixed; boundary="TkZOSdWdHBxxC73zZ3KqpVpDIViUdAsYY"

--TkZOSdWdHBxxC73zZ3KqpVpDIViUdAsYY
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>> LZO is known to miscompile with gcc 10 and requires
>> -fno-strict-aliasing to compile. and also in my OpenVPN for Android
>> app I have to compile lzo with -O1 instead -O2 since it otherwise
>> segfaults on armv7a. Android uses LLVM/clang to compile so the broken
>> behaviour is present also on other compilers. I never investigated
>> which optimisation flag does break in clang/llvm/armv7a.
>=20=20
> The alignment errors happen in OpenVPN code, not in LZO code.=20
> We have to use the (ancient) gcc 4.0.0. After upgrading OpenVPN from
> 2.3 to 2.4 we did not even upgrade LZO from 2.0.6, but linked
> statically to the old compiled lib. I doubt that the compiler itself
> changes anything here.
>=20
>> But bottom line is that you probably are running in a similar and I
>> would advise to compile lzo with less optimisation.
>=20
> Thanks for the suggestion!=20
>=20
> Anyways I recompiled LZO without any optimazations and then OpenVPN
> 2.4.8. Unfortunatelly this changed nothing.
>=20
> A few questions:
> ----------------
> 1) Do you run automated tests of the OpenVPN code on any build server?=20
>=20
> 2) If that is the case, is there any test with a version, where=20
>    -DVERIFY_ALIGNMENT is enabled?
>=20

I never heard of this option and Google does not want to spit something
out for me for that.

> 3) If that is also the case, can you see any ERRORS regarding the
>    alignment in the logs?
>=20
> The problem is, that we do not have any power over the clients. It
> might well be, that there are even OpenVPN 2.2 clients out there.
>=20

Compression adds a one byte header in the packet making it all
unaligned. The newer lz4 with swap, or v2 compression methods try to
avoid this misaligned, mainly for speed on platforms where unaligned
access comes with a penality.

I think there might still be unaligned access that are in the code but I
am not sure how to debug them. Is there an easy way to reproduce them?
Can a RPI configured to throw those warnings?

ARne


--TkZOSdWdHBxxC73zZ3KqpVpDIViUdAsYY--

--IvncbpZFZTo30kl1GYIdhlp764rpNxQlL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl57RYsACgkQFRhsZwKx
RFSn4A//dbVsN+/4WFpNZjxxs0acC+pPaa4U6xykfk9IP9dihpR4a5LZiSC1EC1x
lkZLJQ0VndGKxXztSVSUZdVeJbpU4Pf/cKpgnqBk6BKmP4QnpyvCUtX1LbBJ603n
P8Y92H9qr34DbYHIWGUbm3S9yIrnpPjkQRYAjOvBSTGJAy3SnKWyuPITYCpJT451
wJHWho9wUd/2SxCHv7YQEfFVG93Rgsu/8NDFIQa3b5DkBvBCS/3Zg3QEF8hIIMFz
arrshiQpHAbChP4zgP5NK2ysmnKd3neGCnQQpICx1MRImaBsJYvPrN4WILAcCkQY
xiwr9p8RpQeRv70NRYIpPwhYN6/zfAZVWyIKx+nJHZkCmwWo3/m1giqEOm+6wyxM
ChNfkC7bS4/51Y2wOxIiN7r4ZVOUEmwCs4jypqx/wvePVmRRC6gz1uC4YmKQAIYJ
n6BmcZxfXQXchT/P1RuD4rmRU4eeCNxvsLRUjgb402kZZLHPzR+L8BV8dUH9KIIM
Hx/XSdYGdY2YIVszk/CbnxnX6nLzmOFp/NaP9En25Ac/2ETbEUEbVUu6I+CISJ++
cja5LJ4uluqSEkFk/U6AwJ7+DQTky0rhInKGJRC9mIS/wMdtmO5KZd8/YYRcr1iy
3cdldKxfT1fA65Hv936HOYnRXJSnaJ5uYTU1r2FLsraWqW4N7xU=
=aNk0
-----END PGP SIGNATURE-----

--IvncbpZFZTo30kl1GYIdhlp764rpNxQlL--

