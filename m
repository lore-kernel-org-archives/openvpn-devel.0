References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-2-git-send-email-steffan.karger@...1435...>
 <d29d8651-7ed9-9b65-97b2-dcad579d70e2@...2181...>
 <c8bf0549-5775-7eea-e10b-a3572120be99@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <41de18e5-6326-2053-bc99-6c0035cfd7c0@...2181...>
Date: Fri, 22 Jun 2018 15:49:28 +0800
MIME-Version: 1.0
In-Reply-To: <c8bf0549-5775-7eea-e10b-a3572120be99@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eRc4G9uwt9MTFLBbuEx53ZbwuWtYG8Fx9"
Subject: Re: [Openvpn-devel] [PATCH 01/10] Add crypto_pem_{encode,decode}()
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
--eRc4G9uwt9MTFLBbuEx53ZbwuWtYG8Fx9
Content-Type: multipart/mixed; boundary="mhxkGyZNpMnnrIPrQ9BKLDsyBax9YZIAP";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <41de18e5-6326-2053-bc99-6c0035cfd7c0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 01/10] Add crypto_pem_{encode,decode}()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <1512734870-17133-2-git-send-email-steffan.karger@...1435...>
 <d29d8651-7ed9-9b65-97b2-dcad579d70e2@...2181...>
 <c8bf0549-5775-7eea-e10b-a3572120be99@...1856...>
In-Reply-To: <c8bf0549-5775-7eea-e10b-a3572120be99@...1856...>

--mhxkGyZNpMnnrIPrQ9BKLDsyBax9YZIAP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/06/18 14:14, Steffan Karger wrote:
[cut]
>>> +/**
>>> + * Encode binary data as PEM
>>> + *
>>> + * @param name      The name to use in the PEM header/footer
>>> + * @param dst       Destination buffer for PEM-encoded data.  Must be =
a valid
>>> + *                  pointer to an uninitialized buffer structure.  Iff=
 this
>>> + *                  function returns true, the buffer will contain mem=
ory
>>> + *                  allocated through the supplied gc.
>>
>> minor: I see the current style is inconsistent wrt having a '.' at the
>> end of each doxygen line. Maybe we should decide what to do and stick to
>> that ;P But does not need to be changed in this patch of course.
>=20
> You sound just like my colleague who's pointing out the missing dots in
> my doxygen :')  Any preference from your side?  I think ending each line
> with a dot is best, because that looks best in the generated docs.
>=20

hehe I don't have a strong preference. Let's go for 'always ending with
a dot' then.

[cut]
>>> +    if (!PEM_write_bio(bio, name, "", BPTR(src), BLEN(src)))
>>> +    {
>>> +        ret =3D false;
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    BUF_MEM *bptr;
>>> +    BIO_get_mem_ptr(bio, &bptr);
>>> +
>>> +    *dst =3D alloc_buf_gc(bptr->length, gc);
>>> +    ASSERT(buf_write(dst, bptr->data, bptr->length));
>>
>> why using an ASSERT() here and none in the mbedtls counterpart?
>>
>> If there is no special reason I (personally) think that these helper
>> functions should not use ASSERT() (unless something really bad is
>> happening).
>> Or do you think that a failure here indicates a general memory problem?
>=20
> Because in the mbedtls part, mbed my change the "outlen" value.  While
> here, we create a buffer of bptr->length bytes and then write
> bptr->length bytes to it.  If that fails, our entire logic (or
> executable integrity) is broken.  It's our code only, and it can not fail.

Yeah, makes sense. Thanks for the explanation. My only worries about
ASSERTs if when the code can be tricked to trigger them without a real
general failure. But this can't be the case.

[cut]
>> Another question: do we have any way to verify that pem_buf contains
>> well-formatted PEM data after pem_encode()?
>> I am asking because if both encode and decode become no-op (because of
>> some bug) we won't be able to realize that.
>>
>> However, I am not sure we have an easy way to check that..maybe you
>> could use some SSL function that would normally load PEM data?
>=20
> That is a bit annoying to test indeed.  How about I just verify that
> this is encoding is not a no-op by adding a check that pem_buf is larger
> that src_buf?
>=20

Yeah probably enough.

> As for correct PEM en/decoding, I expect that the crypto lib has tested
> that.

I agree.

>=20
[cut]
>>
>> Cheers,
>=20
> Thanks!

Thank you!



--=20
Antonio Quartulli


--mhxkGyZNpMnnrIPrQ9BKLDsyBax9YZIAP--

--eRc4G9uwt9MTFLBbuEx53ZbwuWtYG8Fx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlssqggACgkQB6U8WA7y
zXQbiw//U3NRQnL/YUs4/dVnRShqp8VDAjruw/g382R8LCtHc0ejy9KzJQ90+kkr
REGanoQ83bEif5ja3dFb6mqC47LzafkL+7EI9lInH9W6ODqdcf3I8TVl16fHaLuJ
lYSYYNP1L+blqAArYNzNRF3pGwX5+I6dXFan5jMOdTv/IZjIsbeoU7t54OSMy9gO
5rUFRn+TiNTknP5Hb7d18k8RPcdueoQd5crBN5be5S1iOwl9MjjLm1mDGXSl7z4u
PxqK1C6vdZguoKAZr0Sd5I6E51/Lr+UCf8V9C3LOeIZ6i74+X65/NbA49aR0oeHV
o7IuvC+96aQHMNAlNHfFu0li+JGWdZt2KD7W8hq7RsREgheMAi15iHPwdp7Xvt/H
kj0UKhpn9LwNna2BXy0rD26IblIqLlf+8iKWowoPUBhPol/O8qr6og0vanMxKrR4
IP9TIXCMEMualrEjie722ycIzHXYyKhPOqfcC6Un57zMgqTLjmr63nnkJyl+LfmC
YgW+0uU55LMwCPDHEUejXj6WyN3eIgPRVwcyG9Y0kwSjcVhdpOMOjzQmpSvGOlJk
VTPCgld/Mrd7XbwNhn42RJa5QBsOkrRdNs/Bqzv66exQvgDG/XlxEu6191r6wnBs
A5fA7jI4/ZbfvrgosyC9zkcMs4quSh4SUP27rwkxwZwDPVff0Zs=
=uTPp
-----END PGP SIGNATURE-----

--eRc4G9uwt9MTFLBbuEx53ZbwuWtYG8Fx9--

