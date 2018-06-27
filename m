References: <20180605081407.6944-1-a@...2181...>
 <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>
Date: Wed, 27 Jun 2018 09:50:29 +0800
MIME-Version: 1.0
In-Reply-To: <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LOY74udfQThunlNKQD49iti85R46RZPeP"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
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
--LOY74udfQThunlNKQD49iti85R46RZPeP
Content-Type: multipart/mixed; boundary="AAN0vxhqOTOEAHNeHlPhzrmI9cogyFQuR";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <6d8c2abb-37b3-5bed-3077-32eb27e4c61b@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
References: <20180605081407.6944-1-a@...2181...>
 <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
In-Reply-To: <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>

--AAN0vxhqOTOEAHNeHlPhzrmI9cogyFQuR
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 27/06/18 05:33, David Sommerseth wrote:
> On 05/06/18 10:14, Antonio Quartulli wrote:
>> In preparation to having tls-auth/crypt keys per connection
>> block, it is important to ensure that such material is always
>> reloaded upon SIGUSR1, no matter if `persist-key` was specified
>> or not.
>=20
> Has this been tested with --chroot and --user/--group?

No, these tests are missing.


Cheers,

--=20
Antonio Quartulli


--AAN0vxhqOTOEAHNeHlPhzrmI9cogyFQuR--

--LOY74udfQThunlNKQD49iti85R46RZPeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsy7WUACgkQB6U8WA7y
zXSNAg/+OMlEMr0KWd5fvbA408Le0s3TZXsglMzskZwbXUtzLjZmFYs6zB65qy9c
/NGlXlLyqkoMkFS7248mDRXWpDTisy6fvMFS9GbmzoB/RnpueUgetzvKN5dwEruj
aulaswv9TTANJEWQ4PpXlzL4pxVakyFQq+KTsu3VgDde+9t4Y7LwpblHi3ab6/va
1CEN0NRjuZWBtbVI86SR6YKvmtkUNi6IQUaEi/d87IviCFIQJXneAoKFXoajvwYX
5HZJ/1yJCvTCklgxlSVgdWnJJ4iv9DyNXsYxWSBZmhkSIN3qkrkv1FQWIxxGAvOw
VdIgbykgGbWGftz4iI+E9wWgj9AmZPK2usgHf0JdTQCYOO+/oHmcKgwqlpL7yAYD
0o3IGi1Rh4GALIgAYpDZl9buiqLIdY4/rauH0vx9JmZG8eGWSz9wCZUeap3qxlUi
2QDzkEriXdP1zHsYpFMa7JpMNy+sNZdN2MqVlP1lYDw9IpgQNJhWRRdLw2ldlUas
LxqnsYbqdJ3vD6c8WCgW/DKFWf56gVz+BzZaMSdJl4QlaPdcTzEH+M1p6N4nUUmA
WS8AMk5P/ddAdXZEe57IBvN5oB3FK5pP+pda5N82mGwumrrjeWlAy1akiB1HGMnH
7PpSI5/RWy9m5DOx/oQYZ+OWzLv+iSEDA6L4lQ8K0p8M93op/tQ=
=jlT9
-----END PGP SIGNATURE-----

--LOY74udfQThunlNKQD49iti85R46RZPeP--

