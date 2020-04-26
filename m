References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
 <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
 <20200417153605.GD1431@...1296...>
 <fbf3eaef-26d1-c81b-a456-c1be7d71b4f9@...1856...>
 <20200426093431.GX1431@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6e35e866-114c-8797-e603-4bf80cd66fb7@...1856...>
Date: Sun, 26 Apr 2020 11:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20200426093431.GX1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VAseKl8dea8ypCaTAjNvZGnLX9lBXram9"
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VAseKl8dea8ypCaTAjNvZGnLX9lBXram9
Content-Type: multipart/mixed; boundary="mhb3Hgin6QYlAUCdPvw8bS1YcTEszH3Wy"

--mhb3Hgin6QYlAUCdPvw8bS1YcTEszH3Wy
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 26-04-2020 11:34, Gert Doering wrote:
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

Pretty it is not. But "let's not try to outsmart the crypto library
folks" makes sense to me.

The copying stuff is probably just about making some annoying compiler
happy. We could probably leave that out, but that makes it harder to see
that we follow the mbed internal implementation.

When inlining this without volatile keywords, a compiler might at some
point become smart enough to realize "hey, this caller only cares about
zero/nonzero, not the actual value. And this code will only return zero
if *all* bytes are equal, so I can stop comparing as soon as soon as
I've found a difference".

Up to now, it seems compilers have not gotten this smart. But it's not
like we're keeping a close eye on that. So I would love to get rid of
the responsibility :-)

-Steffan


--mhb3Hgin6QYlAUCdPvw8bS1YcTEszH3Wy--

--VAseKl8dea8ypCaTAjNvZGnLX9lBXram9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAl6lWUQACgkQmALKPQB+
0og5WQf9FKvUrQ+qvVYgdxnqasF/BSDrJtQaCaTnOffnNuBVKqmMaNgdd0xrgwsh
SWjBopFS230T+nDmwi2iab9cWShDxy4IBK+bCtz6qQN7BKV9Ebna/9M57A1+9h8O
332GQBGobXS0ejsKMELpc5ILP4Nf5vdQwMSru0lEfVE5fDeVtqOKjgTNl2IgQom8
hc0GDq3bF+zx4BqKPGiuekz2HXdat5opH0rnxWsztpUlyaakEmgfv3vuvpH4JiHg
VDx8OaxiI8sQyPRp98C4fUpAYiLhL+p2p90X27aemZDkWPFAAjL9HnnBbbjvv8v5
VTNq8ti5L2LQx3GuPEcvdl7EYl9+cQ==
=vETU
-----END PGP SIGNATURE-----

--VAseKl8dea8ypCaTAjNvZGnLX9lBXram9--

