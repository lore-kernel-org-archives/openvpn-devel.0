References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
 <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
 <20200417153605.GD1431@...1296...>
 <fbf3eaef-26d1-c81b-a456-c1be7d71b4f9@...1856...>
 <20200426093431.GX1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <094fe6d0-c6f5-e8e8-56ed-b7a18567634d@...1227...>
Date: Mon, 27 Apr 2020 00:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <20200426093431.GX1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NHfFU2gJYTaY5KY1EmWgtdUJfvvAc4rvM"
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NHfFU2gJYTaY5KY1EmWgtdUJfvvAc4rvM
Content-Type: multipart/mixed; boundary="SPtqwVdhpYpm5yTJo0oeIlQjIyJzRWrWd"

--SPtqwVdhpYpm5yTJo0oeIlQjIyJzRWrWd
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 26.04.20 um 11:34 schrieb Gert Doering:
> Hi,
>=20
> On Sun, Apr 26, 2020 at 11:25:49AM +0200, Steffan Karger wrote:
>>>> well, sometimes to adhere to the codestyle, you have to re-arrange cod=
e :)
>>>
>>> "rearrange" and "rewrite in a not easy to understand way" (which looks
>>> a bit overthought to me, TBH - unlike "secure memzero" I cannot see an
>>> obvious reason why all that volatile would be relevant).
>>
>> This secure memcmp is relevant to avoid timing side channels in e.g.
>> authentication tag compare. Think about the HMAC in our tls-auth/crypt
>> and the HMAC of (non-AEAD) data channel packets.
>=20
> I do understand why it has to be constant *time*, in regards to "do the
> compared buffers differ or not".
>=20
> I do not see how all this "volatile" and "copy from pointer to variables
> to other stuff" handwaving is going to make any difference wrt constant
> time comparison.
>=20
> And it hurts my eyes.

Yeah the goal is basically do what the crypto library is doing. And if
you play with godbolt. So we don't need to go down this path of having
to come up with our own version.

And if you care about speed then we should definitively go for OpenSSL's
memcmp function. Since it is implemented in assembler it does not try to
breaks the compiler compilation optimisation with volatile that might
trigger more memory loads than necessary but can be a small fast
constant time function.

If you play a bit with godbolt.org (https://godbolt.org/z/gXgcC9) you
will see that the code that is generated from our current version is not
yet optimised to non constant versions but especially the clang compiler
is getting close. It completely optimises away the function for compile
strings (main2 just becomes return 95), builds a version optimised for
one fixed string and vectorises the generic version. So I am not sure if
these variants still have their constant with modern processes and
speculative execution.

Arne



--SPtqwVdhpYpm5yTJo0oeIlQjIyJzRWrWd--

--NHfFU2gJYTaY5KY1EmWgtdUJfvvAc4rvM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6mDWgACgkQFRhsZwKx
RFTM8xAAn6VsuccTQLNIPE63lh0DJjkdMamCTjjivRaaNYKYomHs6HhCBocl7i8G
EbmS3cP7cN634Dxd12xAeUp6rhmDMuWcNFnn/PS3tOgKBvlw9CPt+joMUAuV1f/y
8RQ5GkzaMny6Ona4NLTJtbpDScSpm+ktwVlZJD4wtZq+Gw23qxn31JisMYuVU3dJ
TPtcZiX+l+8KjUqpUnUmR5rmVRiDOBfHx06vRHpsB/VdhC4CzM89nc7RSx1SGqia
VZU7BwtwjI9wZxd/PmyQJZWKgav9++VRPOWSkINRqJoRor54i77U5gUCOCypy0+q
+HWG8GFNjCQLARaW2egvd/ZMD4xGBV0PVgguIHhGuSCp0mFtjLVb7SbELJYUQBTJ
Xup0Z+iDwvV2B24KJAXq46lPcPnsBj0G80WNbdgwY4dzqm2uR47cj0EJ0916phkr
Ss5BdfRmA6OvyAVSt3sgWko8NqrDGHm2J//uB4vPIbVallzHQrt5OJeGZK0J2M3U
pKJBxjiF7ngs0514ULP2xDBJ6kK5rcaWT+YeLMAAv3aT1xqdgvTRDJPts93YQtxS
wy3xWGGS6P6+ZqFE4JEI2DKiJR9Pv36cqSZV9bEPweETKAyX1a5saX3DrDWU40Pi
fEdlWf5glCL5c+8cm770WuEj83iG3qJ5Q0/5t6UPpB69tsJ++eU=
=lvct
-----END PGP SIGNATURE-----

--NHfFU2gJYTaY5KY1EmWgtdUJfvvAc4rvM--

