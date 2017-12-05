References: <20171202134541.7688-1-a@...2181...>
 <20171202134541.7688-5-a@...2181...>
 <ead35daf-765c-9e74-2cac-d8f98e6d0c85@...1856...>
 <20171204184525.GY69387@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2a334b93-3cdf-e27e-2681-e0859881d192@...2181...>
Date: Tue, 5 Dec 2017 14:45:12 +0800
MIME-Version: 1.0
In-Reply-To: <20171204184525.GY69387@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RdNqBR5QJk2jhHTxrx3xFtMjjdhvgePBX"
Subject: Re: [Openvpn-devel] [PATCH 5/7] Remove CIPHER_ENABLED
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
--RdNqBR5QJk2jhHTxrx3xFtMjjdhvgePBX
Content-Type: multipart/mixed; boundary="M260OO5DEcdRsxT8QXCaRbu6NVkusSNkF";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <2a334b93-3cdf-e27e-2681-e0859881d192@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 5/7] Remove CIPHER_ENABLED
References: <20171202134541.7688-1-a@...2181...>
 <20171202134541.7688-5-a@...2181...>
 <ead35daf-765c-9e74-2cac-d8f98e6d0c85@...1856...>
 <20171204184525.GY69387@...1296...>
In-Reply-To: <20171204184525.GY69387@...1296...>

--M260OO5DEcdRsxT8QXCaRbu6NVkusSNkF
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/12/17 02:45, Gert Doering wrote:
> Hi,
>=20
> On Sun, Dec 03, 2017 at 03:17:51PM +0100, Steffan Karger wrote:
>> On 02-12-17 14:45, Antonio Quartulli wrote:
>>> Now that ENABLE_CRYPTO has been removed, CIPHER_ENABLED is basically
>>> a useless shortcut which does not really help the readability of the
>>> code.
>=20
> Call me silly, but CIPHER_ENABLED has nothing to do with ENABLE_CRYPTO,
> but more with "--cipher none", no?
>=20

"Remove ENABLE_CRYPTO" introduced this change:

-#ifdef ENABLE_CRYPTO
 #define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher !=3D NULL)
-#else
-#define CIPHER_ENABLED(c) (false)
-#endif


thus my feeling was that this macro is now not so useful, because there
is no conditional definition anymore.


> So at least the commit message is misleading...
>=20
>>>       * Set adjustment factor for buffer alignment when no
>>>       * cipher is used.
>>>       */
>>> -    if (!CIPHER_ENABLED(c))
>>> +    if (!c->c1.ks.key_type.cipher)
>=20
> ... and I don't really find the second one more easily understandable
> than the first one...
>=20

I think it's a matter of taste :-)

We could substitute every NULL check with a human readable
macro/inline-functions, but I am not sure it would be really useful.

Honestly, this condition seem quite clear to me (at least compared to
the TLS_MODE()/tls_multi one).
But, again, this is just my taste: feel free to drop this patch if you
think it is better to keep the macro.


Cheers,


--=20
Antonio Quartulli


--M260OO5DEcdRsxT8QXCaRbu6NVkusSNkF--

--RdNqBR5QJk2jhHTxrx3xFtMjjdhvgePBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlomQHwACgkQB6U8WA7y
zXSQaRAAjlFfTR6NJIPBk7jo9J6KWa5cqY33LVmw4pIbhmU/xi2loFxAvu1MgpA7
leDt3gUcMbQrKjvEilqkkv/ktBnm8sNEYExcYE1UEYtM4/1bsgCIYBImhwy9OzYp
6PbprE3TtYWh8KfnLmSquoleY1dkAJO10VZQCkzvEOPFoC9uB8/wAkZlv5ubipru
nlZfy19iWO9Lv/V+QDopLgXD6gZ1TFw72WbIJkImNgDEC9vRaOm+iBVgoipSIeuk
YAlwDGUDDpJcpIr6Nzi4jWQJH0FYN6d4xIexlpPRAjdLwetP/+2KVyloob8oV5C3
52NibH4xF7SjaJ+m3nOA8RcFdAp0+R3xSUfzWmCsSl9caeNnDTScqKM5Tu+85PxU
C/YYfwkX0CK5sC47pLUG+9LsZfUk8HB3fPeTjO2Qn5eFWNkVqm9amYjN8qBHrCwQ
Ou27MIRy61LSFmHKPiCOb2VcFYXKIcTxJEb41G0M5ScSSeflF29Tno+6oHd6qpkb
xeyZifRQdxhtiiIGFZXfBcW2/tCrJy2P9ZG0joUyX4eOtwqKpSJileBrfKy9RZ2o
xVno99OcEMwFRYQmvVxv+iR1L6e2bOFeUxVQfxUl6vhuRNurhjYAwpxdEFXTZJV7
qumsc4+yU+q1NNNFZ96ACqbINeFeaPsVtbnBtPve3+EcCQ/oTCk=
=k6Oj
-----END PGP SIGNATURE-----

--RdNqBR5QJk2jhHTxrx3xFtMjjdhvgePBX--

