From: Antonio Quartulli <a@...2181...>
References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
Message-ID: <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
Date: Sun, 7 Oct 2018 21:36:37 +0800
MIME-Version: 1.0
In-Reply-To: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lrrfAHsMdNc1PVKjeeGOEKP5uhhAHYNMR"
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in
 the data channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrrfAHsMdNc1PVKjeeGOEKP5uhhAHYNMR
Content-Type: multipart/mixed; boundary="IbZLeeHDUCcaAdiKePmMXB3bMCXHCQVWF";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <7b2c0430-4d5a-1e7e-334c-9292193b2a2d@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in the
 data channel
References: <20181007073413.9778-1-steffan@...1856...>
 <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
In-Reply-To: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>

--IbZLeeHDUCcaAdiKePmMXB3bMCXHCQVWF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/10/18 21:28, Antonio Quartulli wrote:
>> +#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >=3D 0x020=
C0000)
>=20
> Why do we need the dual condition? Isn't MBEDTLS_CHACHAPOLY_C enough to
> know mbedTLS has what we need? Or you feel like we have to demand a
> specific mbedTLS version when using ChaCha20?

Just to reinforce my argument: ChaCha20-Poly1305 was introduced with
ce66d5e8e (in mbedTLS upstream) and a quick search shows:

mbedtls $ git tag --contains ce66d5e8e
mbedtls-2.12.0
mbedtls-2.13.0
mbedtls-2.13.1

Given that 2.12 is 0x020C0000, I am fairly sure there is no reason to
have both conditions in the if guard.
But I might still be missing something.

(p.s. I am arguing simply because I want to avoid more version-based
ifdef that may become new nightmares)

Cheers,


--=20
Antonio Quartulli


--IbZLeeHDUCcaAdiKePmMXB3bMCXHCQVWF--

--lrrfAHsMdNc1PVKjeeGOEKP5uhhAHYNMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu6C+UACgkQ9FVsWUWD
Dm2IWRAAhKSRaHFlDLH7yqVdyd1oV4qWmKKIRd4foQRUi/1HqgScWs6Eo4ioErwd
L0Aluh26oWjSwqL77QMOGapGr8tYnN20nHQXyvGKYgNBatTC8658GEpz60IU/Y12
d+4eBE5xZorDjyC9+HQ3i4RqODPcmihjl3mBIjFIlEzNDhg7lBYAzJVac5O4KvnW
eUXp9L1JKGtWmuWG+JkZoTGWGbTc9rsoeh5Q3x9goxhhKojCjQvCi51foWdJlD+m
cgtFmoMyBmDguRal5PGH9W3M3saDWNxi5qo1MXX0vCYuC4W6fUOXOiPxmdmUhZ04
EDOtBXBmYL20brT4JhbPaGeAv+LE4VcQIaQRoRE/PXxr6ja6R1Lch8zxonbuDCFE
dExdF7xXg7A3V+nyQEgLCdA1e1MgQAiGAK/QMm13SpoRlUsVH701bGgdCYNh3Be0
rdSuyge17ODklgL1yz9/M3P2UBs7paz57p41qybvbTUTEXQ2/7+jCdxEe3j2AvJx
hb4N51MvLLU1I/quyQouHOgJkK0cl2ph3SU3A27ndVCSsJl4Ia6KByqTTHSF95oc
Ol8/8A0g76PhUf0RQiXSyfFtvgA2NHFVD4qcXYekJ8PNolW258N+Sdqh8n8DS0uy
fAnodVfmvKR5Al4TWwtP92DAp39C5ENk3efvDGKCOxK4RsVJ8wg=
=wc4f
-----END PGP SIGNATURE-----

--lrrfAHsMdNc1PVKjeeGOEKP5uhhAHYNMR--

