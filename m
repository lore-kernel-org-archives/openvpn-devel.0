References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
 <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
 <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <25e4f660-3a83-ec26-462a-0891acf7467f@...2181...>
Date: Thu, 9 Nov 2017 22:14:13 +0800
MIME-Version: 1.0
In-Reply-To: <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1796UWGr6TO2tBe6T8wjn5mDJ90X8rxRw"
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path:
 prevent memory leak if gc == NULL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1796UWGr6TO2tBe6T8wjn5mDJ90X8rxRw
Content-Type: multipart/mixed; boundary="PcCxKtgbKWPuGxDqXFrcEB6k10H90C8RC";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <25e4f660-3a83-ec26-462a-0891acf7467f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
 <20171101220342.14648-5-steffan@...1856...>
 <2bacffe7-e42b-9a33-b502-924ef38c628a@...2181...>
 <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>
In-Reply-To: <531fd06f-c0f4-9068-a6e6-58e52c8c32e3@...1435...>

--PcCxKtgbKWPuGxDqXFrcEB6k10H90C8RC
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 09/11/17 21:46, Steffan Karger wrote:
> Hi,
>=20
> On 09-11-17 04:25, Antonio Quartulli wrote:
>>> @@ -812,6 +816,12 @@ gen_path(const char *directory, const char *filena=
me, struct gc_arena *gc)
>>>  #else
>>>      const int CC_PATH_RESERVED =3D CC_SLASH;
>>>  #endif
>>> +
>>> +    if (!gc)
>>> +    {
>>> +        return NULL; /* Would leak memory otherwise */
>>
>> As far as I understood the ratio behind this change, we are basically
>> saying that passing gc =3D=3D NULL is a real programming error and not a
>> runtime problem. If so, wouldn't it be better to assert(gc) directly?
>> I am saying so because we should make this failure louder, so that it
>> can be recognized in an early test.
>>
>> Or can we have cases when this function is called with NULL because of a
>> temporary failure (my understanding is that this should not be possible)?
>=20
> I'm a bit in doubt here - if this parameter is NULL, that's a
> programming error.  But we've seen before that programming errors
> sometimes can be triggered by external input.  In this case, this
> function can be called when a client connects.  It *should* never hit
> this case, but if it somehow does, that becomes a DoS vuln.  So I think
> I prefer 'graceful error handling' in paths that are exposed like this,
> unless the error indicates a system integrity error such as an
> out-of-bounds read or write.

Yeah, makes sense. I was also worried about the DoS, that's why I was
trying to convince myself that passing NULL was not possible at all. But
I like your defensive approach more.

Acked-by: Antonio Quartulli <a@...2181...>

--=20
Antonio Quartulli


--PcCxKtgbKWPuGxDqXFrcEB6k10H90C8RC--

--1796UWGr6TO2tBe6T8wjn5mDJ90X8rxRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloEYrUACgkQB6U8WA7y
zXTpiQ//c4DqqOXP4D8Gas5KiaKESsipE33d//UQswLeUfmZgy4U33WEFmA/NYv5
dlo/FithaPi87NqspmMab6sl3rsKJktdDAzo3nNgFLSUfsKMo1Yh5/nRpmVZM2pO
DoFcjdAcfr7Lr5M/ZpfSG7ML0a0hc+mlu4EOeIHBbA4HOrh9+T0nhXfI+0Zz3Uf8
71uCYnA+JA0Bgqvx6Yjv8UFfEUCVcEUYnyuKgRbKAEXKdZAompqhKuUakna0bKIC
Z+ETQ65arhEr9DNAIUV7MQSFBOuzt6++Q8NbFkrbYUNprqVKqWODtBAvhOOjC6dO
kSkW0uYgTBqG8OGt+6+iHrAdXrArOLuK5GOHGYUFm5YgClKlje/l3+TN8D07We7k
bhdtAd/iI5VZESAleRC4NA8U0Bl8zUhEaRw/7ulPqP2M86Dm2mPWrWE/yzHzGarX
Km+TxqtxX/Me3mupmYu5tZmAUy4CkvoQrvvsF2cSSM3GAd++Onud9iKT9apSu7bi
/FRMvgVpuH2TvsQZYIA0Ib0ibNR5ZRO+UYepQ+dM1/8Vf+GBfpQKQPcTPTUxfFXd
mHuJPkKP6wvKDwucA4XVf5jGtPEZ9Aij2LPZdNq5QiB4oM9PgwyyNZaTMprEjmm+
e+km+2FusicdT03WxdulwZcJTrFVqyPNudr7XqefipqVAexiVc0=
=e9jc
-----END PGP SIGNATURE-----

--1796UWGr6TO2tBe6T8wjn5mDJ90X8rxRw--

