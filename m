References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
 <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>
Date: Sun, 22 Jul 2018 11:53:22 +0200
MIME-Version: 1.0
In-Reply-To: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zxdAMLcbTRe4G48gDXnP21uFYlwVWlXCg"
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode, decode}()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zxdAMLcbTRe4G48gDXnP21uFYlwVWlXCg
Content-Type: multipart/mixed; boundary="WF7zcacSBdG7KZMjJaOwrv0BeRyeXGRfh";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b670578c-910e-fa94-587f-469a5af2e92d@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/9] Add crypto_pem_{encode,decode}()
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
 <20180704175404.22371-3-steffan@...1856...>
 <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>
In-Reply-To: <8eebd206-6742-712d-2097-ee196bbb025c@...2181...>

--WF7zcacSBdG7KZMjJaOwrv0BeRyeXGRfh
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20-07-18 13:20, Antonio Quartulli wrote:
> Hi,
>=20
> On 05/07/18 01:53, Steffan Karger wrote:
> [CUT]
>=20
>> +bool
>> +crypto_pem_decode(const char *name, struct buffer *dst,
>> +                  const struct buffer *src)
>> +{
>> +    bool ret =3D false;
>> +    BIO *bio;
>> +
>> +    if (!(bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src))))
>=20
> minor style niptick: I think it's common habit to have the assignment on
> one line and the if-condition on the next one, especially when it's
> about functions allocating some kind of object. Check your own
> crypto_pem_encode() in this patch :-)
>=20
> For the sake of consistency, I think this should be split in two lines:
>=20
> BIO *bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src));
> if (!bio)

Agreed, will do.

>> +    {
>> +        crypto_msg(M_FATAL, "Cannot open memory BIO for PEM decode");
>> +    }
>> +
>> +    char *name_read =3D NULL;
>> +    char *header_read =3D NULL;
>> +    uint8_t *data_read =3D NULL;
>> +    long data_read_len =3D 0;
>> +    if (!PEM_read_bio(bio, &name_read, &header_read, &data_read,
>> +                      &data_read_len))
>> +    {
>> +        dmsg(D_CRYPT_ERRORS, "%s: PEM decode failed", __func__);
>> +        goto cleanup;
>> +    }
>> +
>> +    if (strcmp(name, name_read))
>> +    {
>> +        dmsg(D_CRYPT_ERRORS,
>> +             "%s: unexpected PEM name (got '%s', expected '%s')",
>> +             __func__, name_read, name);
>> +        goto cleanup;
>> +    }
>> +
>> +    uint8_t *dst_data =3D buf_write_alloc(dst, data_read_len);
>> +    if (!dst_data)
>> +    {
>> +        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __fun=
c__,
>> +             BCAP(dst), data_read_len);
>> +        goto cleanup;
>=20
> Am I wrong or we are leaking dst_data in case of failure? or are we
> assuming that this memory is now owned by dst and therefore its owner
> (the caller) will take care of this?

I don't think this leaks data; buf_write_alloc returns NULL if there is
not enough space available in dst, and won't change dst in that case.
So nothing to clean up in that case?

>> +    }
>> +    memcpy(dst_data, data_read, data_read_len);
>> +
>> +    ret =3D true;
>> +cleanup:> +    OPENSSL_free(name_read);
>> +    OPENSSL_free(header_read);
>> +    OPENSSL_free(data_read);
>> +    if (!BIO_free(bio))
>> +    {
>> +        ret =3D false;;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>=20
> [CUT]
>=20
> Other than those small remarks the patch looks good.
> Therefore:
>=20
> Acked-by: Antonio Quartulli <antonio@...515...>
>=20
> This code does not do anything yet, as these functions are not used at
> the moment (will be in one of the next patches), but they are tested
> thanks to the new unit_test and everything seems to be working as expecte=
d.

Thanks!

-Steffan


--WF7zcacSBdG7KZMjJaOwrv0BeRyeXGRfh--

--zxdAMLcbTRe4G48gDXnP21uFYlwVWlXCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAltUVCEACgkQmALKPQB+
0ojGNAf+JWNEt0Zp1EFKPMUc1qK7s0QxzxCVjqFkUD2CKgs44azpE3IUfgVUFnFt
Y3j7mt46DykO/jpZTzIxRHg/XOZgr41wAUDRgdhCNi4qjHMpuiKDz0Sz9Ok8xpBB
4uqJVUAVVYTGOnK0oI8DHOG3mwGk+mg7zHHoXNuFqUgdvcr7C3ySMGPfAyqcFQ2E
Ox9laI3/7Be6LpcGy2EOElGsxCLnl12CsscvaTu9QMsCCFSqApy4l2Zo+ZFnkcWE
x0HD4Auq1FnlSYDzTmwzzaCmnAxrFCsWGrPlPoIJ68qKFMrenEhvHqze20Bo5kd4
XthcHkUc4TTlYPeF2esfHrXJCMAmsQ==
=kCWY
-----END PGP SIGNATURE-----

--zxdAMLcbTRe4G48gDXnP21uFYlwVWlXCg--

