References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
 <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
 <20200417153605.GD1431@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <fbf3eaef-26d1-c81b-a456-c1be7d71b4f9@...1856...>
Date: Sun, 26 Apr 2020 11:25:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200417153605.GD1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0CGkQBEetZlFxnwebO2287OA8OBXhozgU"
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
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0CGkQBEetZlFxnwebO2287OA8OBXhozgU
Content-Type: multipart/mixed; boundary="JZwbWF8ii3FkfpGnZ78sj62XnJVjDYsjO"

--JZwbWF8ii3FkfpGnZ78sj62XnJVjDYsjO
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 17-04-2020 17:36, Gert Doering wrote:
> On Fri, Apr 17, 2020 at 03:42:49PM +0200, Antonio Quartulli wrote:
>>>> -static inline int
>>>> -memcmp_constant_time(const void *a, const void *b, size_t size)
>>>> -{
>>>
>>> Not sure I understand the motivation for this change.  "Just so uncrust=
ify
>>> stops trying to change this" is not really strong.
>>
>> well, sometimes to adhere to the codestyle, you have to re-arrange code =
:)
>=20
> "rearrange" and "rewrite in a not easy to understand way" (which looks
> a bit overthought to me, TBH - unlike "secure memzero" I cannot see an
> obvious reason why all that volatile would be relevant).

This secure memcmp is relevant to avoid timing side channels in e.g.
authentication tag compare. Think about the HMAC in our tls-auth/crypt
and the HMAC of (non-AEAD) data channel packets.

>> On top of that, this is basically allowing us to re-use an existing
>> openssl API when possible.
>=20
> True, but if that turns out to be a code complication and reduces
> efficiency, I'm not convinced it's the right way to spend our cycles.
>=20
>>> Also, keeping the "inline" part would be good...  this is in the per-pa=
cket
>>> path.
>>
>> I am not sure it would work in this case, because the function is
>> defined in a .c file now - it's not inlineable anymore outside of the
>> mbedtls code.....
>=20
> This is why I'm not exactly happy with the change.
>=20
> We could do it "openvpn style" all in header files, or we could just
> leave the function alone.

This kind of code is a tricky balance between "prevent the compiler from
optimizing it to a not-constant-time implementation" and "as much
performance as we can get". Moving this responsibility to the crypto
library seems like a good idea to me.

And because our recommended data channel ciphers are AEAD ciphers for
which the auth tag compare is handled internally by the crypto library,
I don't care so much for the performance aspect. Want best security? Use
AEAD! Want best performance? Use AEAD!

You get the point. Use AEAD ;-)

-Steffan


--JZwbWF8ii3FkfpGnZ78sj62XnJVjDYsjO--

--0CGkQBEetZlFxnwebO2287OA8OBXhozgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAl6lU6gACgkQmALKPQB+
0ohdiAf+PGk7/dT5g3uqJDyz4TCs+HVJfgls/x6Jjg7Zbe87DWl+u+HRygz4GK2c
M7GRLc06fgxgVx34EEZJZ81oL6Yec91DEWrDLu9nmCnLHQQ3t8bv1RxGzPtk/C+l
70VZPxHE0CjqeS3QbBdXJpZTlx9SZ4C5o5UZDNCKKGBiATMBbpAbiCcwXyPUZa5S
K/JUWqQ45Je1Yv9N+3yIaQKF54FEiapEJoLW7nftF+Zn4O1Vdrruy/Raon+KpsSI
wpcWD8HNArexgtMdcrlF288rCUnDEnDIEEnCuHOd9HWytTGH5IpCpA3VeHrqNz/8
v/vrXCFjy1tGuQitjdwlCAdhKvFV4Q==
=Ylgf
-----END PGP SIGNATURE-----

--0CGkQBEetZlFxnwebO2287OA8OBXhozgU--

