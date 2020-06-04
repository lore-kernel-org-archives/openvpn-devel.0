References: <4f3b6d5e-5354-558d-2e58-c8f588fbd18f@...2181...>
 <20200416152619.5465-1-arne@...1227...>
 <20200416152619.5465-2-arne@...1227...>
 <6671d706-6c99-66e9-20a3-265d4643d53f@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a4d45152-7571-bdac-5abc-bf34f752b365@...1227...>
Date: Fri, 5 Jun 2020 00:15:46 +0200
MIME-Version: 1.0
In-Reply-To: <6671d706-6c99-66e9-20a3-265d4643d53f@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KfsKH4sUVNROrp2axjER4rkcKeKqgpNbc"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Implement tls-groups option to
 specify eliptic curves/groups
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
--KfsKH4sUVNROrp2axjER4rkcKeKqgpNbc
Content-Type: multipart/mixed; boundary="kGa9X7Bam1iVRIbrcjo111p6WK6bsTO69"

--kGa9X7Bam1iVRIbrcjo111p6WK6bsTO69
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>>  The default for \-\-tls\-ciphersuites is to use the crypto library's de=
fault.
>>  .\"*********************************************************
>>  .TP
>> +.B \-\-tls\-groups l
>> +A list
>> +.B l
>> +of allowable groups/curves in order of preference.
>       ^^^ shouldn't this be "allowed" ?

It is a very tiny semantic difference and both forms are correct. We use
the same wording for tls-cipher and considering that we ignore unknown
curves allowable is IMO the better fit. I prefer allowable but will not
fight for it.


>>          options->show_tls_ciphers =3D true;
>>      }
>> -    else if (streq(p[0], "show-curves") && !p[1])
>> +    else if ((streq(p[0], "show-curves") || streq(p[0], "show-groups"))=
 && !p[1])
> shouldn't we deprecate --show-curves at this point?
> what's the point of keeping both options?

It is a nice thing to and does not extra complexity. So still accepting
is a thing gesture for users.


>> +void
>> +tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
>> +{
>> +    ASSERT(ctx);
>> +    struct gc_arena gc =3D gc_new();
>> +
>> +    /* Get number of groups and allocate an array in ctx */
>> +    int groups_count =3D get_num_elements(groups, ':');
>> +    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count +=
 1)
>> +
>> +    /* Parse allowed ciphers, getting IDs */
>> +    int i =3D 0;
>> +    char *tmp_groups =3D string_alloc(groups, &gc);
>> +
>> +    const char *token =3D strsep(&tmp_groups, ":");
>> +    while (token)
>=20
> Couldn't we avoid having the assignment here and at the end of the loop
> by doing:
>=20
> const char *token;
> while ((token =3D strsep(&tmp_groups, ":"))
>=20

Yes, this is a left over from an earlier version where the first call
had to be made differently iirc.

>=20
>> +    {
>> +        const mbedtls_ecp_curve_info *ci =3D
>> +            mbedtls_ecp_curve_info_from_name(token);
>> +        if (!ci)
>> +        {
>> +            msg(M_WARN, "Warning unknown curve/group specified: %s", to=
ken);
>> +        }
>> +        else
>> +        {
>> +            ctx->groups[i] =3D ci->grp_id;
>> +            i++;
>> +        }
>> +        token =3D strsep(&tmp_groups, ":");
>> +    }
>> +    ctx->groups[i] =3D MBEDTLS_ECP_DP_NONE;
>> +
>> +    gc_free(&gc);
>> +}
>> +
>> +
>>  void
>>  tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
>>  {
>> @@ -1043,6 +1084,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>>          mbedtls_ssl_conf_ciphersuites(ks_ssl->ssl_config, ssl_ctx->allo=
wed_ciphers);
>>      }
>>=20=20
>> +    if (ssl_ctx->groups)
>> +    {
>> +        mbedtls_ssl_conf_curves(&ks_ssl->ssl_config, ssl_ctx->groups);
>=20
> the '&' should not be there I guess.
>=20
> /usr/include/mbedtls/ssl.h:2925:51: note: expected =E2=80=98mbedtls_ssl_c=
onfig
> *=E2=80=99 but argument is of type =E2=80=98mbedtls_ssl_config **=E2=80=99

The commit mbedTLS: Make sure TLS session survives was commited in the
meantime that change the argument from * to **

https://github.com/openvpn/openvpn/commit/a59e0754afd37a606d96cf24cea771ace=
3467289


>>  #ifndef OPENSSL_NO_EC
>>      EC_builtin_curve *curves =3D NULL;
>>      size_t crv_len =3D 0;
>> @@ -2188,7 +2242,7 @@ show_available_curves(void)
>>      ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
>>      if (EC_get_builtin_curves(curves, crv_len))
>>      {
>> -        printf("Available Elliptic curves:\n");
>> +        printf("\nAvailable Elliptic curves/groups:\n");
>>          for (n =3D 0; n < crv_len; n++)
>>          {
>>              const char *sname;
>>
>=20
>=20
> The rest looks good.
>=20
> I applied this patch on top of master with git am -3 because there are
> some trivial conflicts to fix.


Will send a V3 with the changes.

Arne


--kGa9X7Bam1iVRIbrcjo111p6WK6bsTO69--

--KfsKH4sUVNROrp2axjER4rkcKeKqgpNbc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7ZcpIACgkQFRhsZwKx
RFQwhw//dbLx/iM5IgKhQzG3/qg1az5wvvllZkNq8lwIpjToOs8CNS3lLiyGfZEl
TR72TcFC0deU5kMMIk5HlD/ZcupZMQDZqZxasgM0RUbbxYWNlXzONqwOg1Rfr1mO
TQWDAL/udmve6x8YhxErknbvk9+SGWCcMFB+lDUCnSgz+Y1Z2hc/MnWFXhHMjXj5
V18WDZ2ZYHouBLxUVoENa8CLpXgWyD6fFPmUOO847l+0a9Syk1ZgXiwlVwh7yNKL
7hszLs+I4YvtmjaQTGIk0Be9B8aO7LFcxze75ZifmOb2Yjnly6UfLUe2Njw/9y/0
6NKXYaOuG4DJh+UINkS3HIqV6Ckm8LkK3h8QlaFAci/8/DzkwtrPzQAkGU18jpv0
uOO8gHIyI3TyHyiXiOlOa4sJ3F0WMNauLdcbp9CJtXEKchmHao8QqApOen4CXhRd
k+jIdbgLH7Rf+pXMfKn2v2Nj1SZAoCFDwUozJ3qq4tgDwlhYeHBEZPGPi0x21ZSV
NeKaphXHHdTNDQav88yRclFxjD2WwDazuDUjkGeszhlYDMrAdZtsPvBdc4J39FwH
pkcIxoMbWRxUQsDZPUofJ65ITGyC+j8gj6bhVxV92HEWF/uGiWVG4HCZWZpIH9tv
k+yFVkc/4UUzy+F+f0vi8YYeSoJzJTt/opZxnjowYIMw8wDEuOo=
=2SjU
-----END PGP SIGNATURE-----

--KfsKH4sUVNROrp2axjER4rkcKeKqgpNbc--

