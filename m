References: <20171203041426.25316-1-a@...2181...>
 <CAKuzo_i3pDk4jcppvwv-AcBMzmZthyc87tP2eoz=m8NjSsFRgg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2e577680-53bc-e6da-9afd-3de48117ab80@...2181...>
Date: Tue, 5 Dec 2017 08:38:23 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i3pDk4jcppvwv-AcBMzmZthyc87tP2eoz=m8NjSsFRgg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Or1qI8KWhdQCT2caQ5QJEbT61Pc81gom1"
Subject: Re: [Openvpn-devel] [PATCH v4] ifconfig-ipv6(-push): allow using
 hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Or1qI8KWhdQCT2caQ5QJEbT61Pc81gom1
Content-Type: multipart/mixed; boundary="q8wEOwnMrEjSTB6ppovtXTXsAT0O8I52G";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <2e577680-53bc-e6da-9afd-3de48117ab80@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] ifconfig-ipv6(-push): allow using
 hostnames
References: <20171203041426.25316-1-a@...2181...>
 <CAKuzo_i3pDk4jcppvwv-AcBMzmZthyc87tP2eoz=m8NjSsFRgg@...278...>
In-Reply-To: <CAKuzo_i3pDk4jcppvwv-AcBMzmZthyc87tP2eoz=m8NjSsFRgg@...278...>

--q8wEOwnMrEjSTB6ppovtXTXsAT0O8I52G
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/12/17 00:17, Selva Nair wrote:

[cut]

> I didn't mean to banish ASSERT: it does have some legitimate
> uses. IMO, if the invalid input is due to programmer error, say, null
> hostname, ASSERT is good and useful to catch it during tests.
> But if its a user input error, say, empty hostname, or some runtime
> error, use of ASSERT calls for a very strong justification.
>=20
> Just expressing an opinion, I respect your choice here and below.

In the past weeks I have witnessed how a nice ASSERT today can become
the DoS of tomorrow. For this reason I am very reluctant to use ASSERTs
on code that will run on the server and I rather prefer to print
something BIG (that also the developer can see immediately).

:)

>=20
>>

[cut]

>=20
> Looks good and works as advertised. Thanks.
>=20
> Reviewed-by: Selva Nair <selva.nair@...277...>
> Tested-by:  Selva Nair <selva.nair@...277...>
> Acked-by: Selva Nair <selva.nair@...277...>
>=20

Thanks!



--=20
Antonio Quartulli


--q8wEOwnMrEjSTB6ppovtXTXsAT0O8I52G--

--Or1qI8KWhdQCT2caQ5QJEbT61Pc81gom1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlol6n8ACgkQB6U8WA7y
zXThGA//R3Bx/gi6CNWjqOTnqG4AtU7U3Mo32VQ2LDoUaPtT4P6vmBMTVUMFOHon
CFifQof/fXQd0fuOqpACkOvOyoFBdiUgZKv7LAsL2+wdbvJZwmxsh8sE58O6jtcP
BzhljIFJ9qAcS0CkMaqyViff4fhJeYKJwwNb8wQcFuXzM6XpIhfN3rMj7IaJ91j7
M87/ZoHM3ztLM6BTrw+Wy90Vb8oZKkfNXAzjWwRUFlQbvc6hajjvOjt/RA700JaH
9PquPbtOLTM+eQoYlFNEK/t0I6WIqkeqdLOqaoAX7Whsd7MW2qXS3snyJb5yVvBq
PEj8KC7upWURBkQoT2NkU3J/QNgYC9n6f2VlOwaHLhkn4qnwj51n+OdLTysJhYR2
evUtTVKsJr8pTCZsjBI8NgceMBLl7POGU95tXu0bRLZGvQplJoIMIQcsqQsHdAXi
GOi1lXtIs+BDZ38iKykpv4jgyjJJsIQ10fsBAF7GHugOfYi8nAugCPGn6m42uc32
xUQ+Yb7yFMkG5RbTBoOXJdKPE5BB/3qVGu8UwQ6J+dniC/K0Y9lyaiQAOWQJm4lx
0c0dZJyAshk3MgiWEw3+TPP3dNFFBwcPpWymT/DDrnP5iU/sBDpqOsNNgVhC9mT7
8LyvLoYgdAOLJCXYhHCpFbXBfSOHDh5EEqkJwWWX20s3865+7yk=
=BpX3
-----END PGP SIGNATURE-----

--Or1qI8KWhdQCT2caQ5QJEbT61Pc81gom1--

