References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
 <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
Date: Mon, 1 Jan 2018 20:56:50 +0800
MIME-Version: 1.0
In-Reply-To: <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X113h8h6suMSahQchUmpRoxmZPBscovXQ"
Subject: Re: [Openvpn-devel] better handling of revoked certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X113h8h6suMSahQchUmpRoxmZPBscovXQ
Content-Type: multipart/mixed; boundary="bt1FCrAkZawzVkkeq3Z2XEhFEDjsafMvI";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
 <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
In-Reply-To: <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>

--bt1FCrAkZawzVkkeq3Z2XEhFEDjsafMvI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/01/18 20:30, Steffan Karger wrote:

[CUT]

>=20
> Note the '5 seconds' reconnect loop, which is the same as what current
> released openvpn would do in response to an alert.  So if we change our
> servers to send alerts, they will experience quite a bit more load from
> clients attempting to reconnect.  We can make newer clients use some
> exponential back-off, but older clients will be around for quite a while.
>=20

If we really go this way, we could even have the client "understand" the
alert and stop retrying if the error is permanent (i.e. certificate
revoked).


However, are we sure we're not going to introduce surface for a DoS
attacks by opening this hole for unauthorized clients?
Basically anybody with a revoked certificate is now able to trigger some
kind of logic on the server side (this is how I understand it).

Consider that obtaining a revoked certificate is not that difficult
(i.e. VPN providers granting free periods normally do that by issuing
and revoking a new cert).



Cheers,


--=20
Antonio Quartulli


--bt1FCrAkZawzVkkeq3Z2XEhFEDjsafMvI--

--X113h8h6suMSahQchUmpRoxmZPBscovXQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpKMBIACgkQB6U8WA7y
zXREWw//c61x5a21tlkp+oCtinCDvdc42X/yPu39NyG2K0d0WtnbC+Lq35SmewIU
RqVO3csAnP3NYT+uTVX8N3DgPPXgI0Lrjq7wpK/JvuQ603ZdmJSZh7TkU4JiuOFA
1TdpBVJFVw22F/Mz0gzh10LhAClvWAH6x6eihJNjT46HFYdEA4uzFgrOM8/5ukcl
gKrgUPfPO2n7zAay4VLPS5/ZKoI2sXauEGB8HDlkxGKKviWYWnaDEjAIUQpUHzN6
0P+IOSmKiNRjI6AxY1jo93otuXRYyjjKSQdAVunlJnBYnVBbOtHiCCaVhLWuT6aX
aLa4m1vk2gGeu6npkb/bMmE+O2WVW0Lptq9cxswwEA/rDfFjQOsSp85w8FbDhob+
WbZeKpl4i+74ZHqEzo7fDsawwPh+p6h5ZVMyemVzM2D3S46PA+DB7W32O/q1XwVV
cfh0hn73sd5UmlbnxRTwZwFmpK8VkFh8O/aAwV2BsLApVHCP8FvXgQeVcAq2x7sO
htHC1j3nL3Rkdva8ihq6UMkus4MduR3MapFAR3BSw3lvXOIvFI3gtIY/A8ObjBH7
qsdFvu/r1tX07eQMxUtQjFLd7nHjikRUjxY/iEPmJj4ycBlUzbequGdzQAr1pr/b
rEIYYTdSBAAcD+r7DQXCZNCZ3yprlesSVjeU1Klq20RV8TFc2kw=
=nA5r
-----END PGP SIGNATURE-----

--X113h8h6suMSahQchUmpRoxmZPBscovXQ--

