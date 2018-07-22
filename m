References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
 <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
 <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0554838a-5117-bb9c-4bb1-c326c0db0ba8@...2181...>
Date: Sun, 22 Jul 2018 19:59:10 +0800
MIME-Version: 1.0
In-Reply-To: <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4uD1tMSpy7J1Uee4CKHmb4q14bKQCbRUY"
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode, decode}()
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
--4uD1tMSpy7J1Uee4CKHmb4q14bKQCbRUY
Content-Type: multipart/mixed; boundary="RbLzumMKRdogHo3BXpQI0qh38DGNyX4aM";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <0554838a-5117-bb9c-4bb1-c326c0db0ba8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode,decode}()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
 <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
 <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>
In-Reply-To: <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>

--RbLzumMKRdogHo3BXpQI0qh38DGNyX4aM
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/07/18 17:53, Steffan Karger wrote:
>>> +    uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len);
>>> +    if (!dst_data)
>>> +    {
>>> +        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __fu=
nc__,
>>> +             BCAP(dst), data_read_len);
>>> +        goto cleanup;
>>
>> Am I wrong or we are leaking dst_data in case of failure? or are we
>> assuming that this memory is now owned by dst and therefore its owner
>> (the caller) will take care of this?
>=20
> I don't think this leaks data; buf_write_alloc returns NULL if there is
> not enough space available in dst, and won't change dst in that case.
> So nothing to clean up in that case?
>=20

Right. The name *_alloc() fooled me, but actually there is nothing being
allocated here so nothing to clean up.

Cheers,

--=20
Antonio Quartulli


--RbLzumMKRdogHo3BXpQI0qh38DGNyX4aM--

--4uD1tMSpy7J1Uee4CKHmb4q14bKQCbRUY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltUcY4ACgkQB6U8WA7y
zXQKKw/6Az9fOEnbxCvE/djGe2l8lgXbGYSrhHkv3aVGp/EB3fHXO18nQ3BZup0o
9MSqdV0d488B0vL6GqbaQ3VVdPeQdqnVe+rWLBLOdiioDYqIBMYQKOhERxb7Z2aN
qN0RJ/0mLg56LB6dxwklFc5JLspckwUZ8Wry5XiArSBBGDQ0oDBqkiobIevw5UaO
DN+vWJXqYz/gYJvuCc76xjETLug2FFDFDbgDFFHK2zdiElx9ijY2SvW6wC5TNXmO
wWZYvBH+UC+bNe69YFykLogx0VkDTCJJnkirqtYBWgYdWZGI9Te42x5KS91BX/62
VvbAv0nkrGNaJinxpfkB+CgJH5uD/C4r12ylQX1KQ8BYUinSBFLCpELKJw3q2bhH
Di5q5KdkhFb3wWs7RwUJquC6ftWAL4JeKolZo0sq5gRDqoy0UeQTaIUCAJ3L3hjK
1V+VuAnH53ZYKyd++hiPtPctrCd9kT5/EybshzSuUx5348zyqntRtNpDRUydNCif
0h001rgidKxMC/tU3ROuwGETFHjCsdFhzDK1bTgcKHKA5l4usuoERR0LnIWeSbY8
GY1DCcVYEH4IGxkuKNBR1k7oi0OjFhbTQfPAKaSDOeNs9iUPuiKghIQ0BnVTQkwA
wR55oUcDNq7L3VIFUUfaFoSMaxBHfMJ+4G1yWgiblKEoRLypXO4=
=B3sM
-----END PGP SIGNATURE-----

--4uD1tMSpy7J1Uee4CKHmb4q14bKQCbRUY--

