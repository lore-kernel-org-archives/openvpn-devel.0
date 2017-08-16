References: <20170816103120.13752-1-a@...2181...>
 <20170816114643.1860-1-a@...2181...>
 <02e78857-6fe5-1571-c492-980b0f13dce5@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <571ade27-8ecc-4870-22b1-178e78db3faa@...2181...>
Date: Wed, 16 Aug 2017 20:47:50 +0800
MIME-Version: 1.0
In-Reply-To: <02e78857-6fe5-1571-c492-980b0f13dce5@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ss5fKcjmwsR8U0m1vQFiNI6o5VAwc2rc5"
Subject: Re: [Openvpn-devel] [PATCH v3] route: avoid definition of unused
 variables in certain configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ss5fKcjmwsR8U0m1vQFiNI6o5VAwc2rc5
Content-Type: multipart/mixed; boundary="7ePlmiVLGbPCVUr1DK9Ohut7jJutfUdi5";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <571ade27-8ecc-4870-22b1-178e78db3faa@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] route: avoid definition of unused
 variables in certain configurations
References: <20170816103120.13752-1-a@...2181...>
 <20170816114643.1860-1-a@...2181...>
 <02e78857-6fe5-1571-c492-980b0f13dce5@...1435...>
In-Reply-To: <02e78857-6fe5-1571-c492-980b0f13dce5@...1435...>

--7ePlmiVLGbPCVUr1DK9Ohut7jJutfUdi5
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi and thanks for reviewing this patch,

On 16/08/17 20:41, Steffan Karger wrote:
> Hi,
>=20
> On 16-08-17 13:46, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> Although this patch adds more ifdefs, this is an easy
>> fix towards a no-warning-build process.
>>
>> A proper cleanup should be carried out later on route.c.
>=20
> Even though the #ifdefs are ugly,  Given the perspective of a cleanup I
> think this is worth it.  I'd love to make at least travis compile with
> --enable-werror and yell when we add new warnings for linux.

Yeah, that's my goal as well. Although we still have a warning about a
deprecated LZ4 function to fix before being able to use -Werror.
(patches to fix this warning have been sent by David but are waiting for
review).

>=20
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>> ---
>> v2:
>> - add commit message
>> - fix warning about another unused variable when --enable-iproute2 is se=
lected
>> v3:
>> - don't write into (now) removed variables
>>
>>
>>  src/openvpn/route.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
>> index 1d8bb001..081cfec0 100644
>> --- a/src/openvpn/route.c
>> +++ b/src/openvpn/route.c
>> @@ -1530,7 +1530,9 @@ add_route(struct route_ipv4 *r,
>>      struct gc_arena gc;
>>      struct argv argv =3D argv_new();
>>      const char *network;
>> +#ifndef ENABLE_IPROUTE
>>      const char *netmask;
>> +#endif
>=20
> Even though probably nobody but Gert will notice, this technically needs
> to be "#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)".

Right, I just checked and I saw that in AIX we directly convert to
netbits without using a netmask string. Thanks!

>=20
>>      const char *gateway;
>>      bool status =3D false;
>>      int is_local_route;
>> @@ -1543,7 +1545,9 @@ add_route(struct route_ipv4 *r,
>>      gc_init(&gc);
>>=20=20
>>      network =3D print_in_addr_t(r->network, 0, &gc);
>> +#ifndef ENABLE_IPROUTE
>>      netmask =3D print_in_addr_t(r->netmask, 0, &gc);
>> +#endif
>>      gateway =3D print_in_addr_t(r->gateway, 0, &gc);
>>=20=20
>>      is_local_route =3D local_route(r->network, r->netmask, r->gateway, =
rgi);
>> @@ -2132,8 +2136,12 @@ delete_route(struct route_ipv4 *r,
>>      struct gc_arena gc;
>>      struct argv argv =3D argv_new();
>>      const char *network;
>> +#ifndef ENABLE_IPROUTE
>>      const char *netmask;
>> +#endif
>=20
> As above, "#if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)".

ditto.

>=20
>> +#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
>>      const char *gateway;
>> +#endif
>>      int is_local_route;
>>=20=20
>>      if ((r->flags & (RT_DEFINED|RT_ADDED)) !=3D (RT_DEFINED|RT_ADDED))
>> @@ -2144,8 +2152,12 @@ delete_route(struct route_ipv4 *r,
>>      gc_init(&gc);
>>=20=20
>>      network =3D print_in_addr_t(r->network, 0, &gc);
>> +#ifndef ENABLE_IPROUTE
>>      netmask =3D print_in_addr_t(r->netmask, 0, &gc);
>> +#endif
>> +#if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
>>      gateway =3D print_in_addr_t(r->gateway, 0, &gc);
>> +#endif
>>=20=20
>>      is_local_route =3D local_route(r->network, r->netmask, r->gateway, =
rgi);
>>      if (is_local_route =3D=3D LR_ERROR)
>>
>=20
> -Steffan

v4 is coming!

Cheers,


--=20
Antonio Quartulli


--7ePlmiVLGbPCVUr1DK9Ohut7jJutfUdi5--

--ss5fKcjmwsR8U0m1vQFiNI6o5VAwc2rc5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmUPvYACgkQ0+HICM1s
oFA77RAAgjkeLciD6csVNXyLUpDTLCRcCkx9kMqx2zN5Ty+xsf9Ps09pBmNr9fQp
EbDXqyVlSKEmu1UQXmclpYUiHw72YYMcF3ugDYYbEjOVmOxXmQWvsxEF5v4Npkup
rDNussCpUqUkb03UaBRcMQ0JLzVOQOJl5e4zST/FZYO+DIOMOdlQY/SXH4Ja2mig
8OP1Q43aKsxPcoYb/dEj1MdrU4qR487+ui36y+MP8YWu7ZvuuwJD3H3ddkA5Czrm
9dsY/Z2adlh6waKBt0c+ugW8Yt+GVxWOP89hdAXfsfhtxX3WrGf3gaS0ed6oYj2h
F2TBX8D0gS+JOEHxEY3lAop8/8TWZG6C3GFid3hDWi6lQJ/pGooQrp0SFWe/Dg8b
n9LF4k1Zts+E5DsRw1UQ1eDzyKLDTgyEbFCxEASBJdg1/NoWmuulFEPAi94bGJat
+cxEtqXgC3adFjyCm0ORx4k8+hSD81qOoej2ZBFpRy+FJLXfqpY39IkSJYTE1H6B
j8jEth3Suigfn45FOq8j6ftJyOLoEMcNI7i+VLwSSX+mrV7zsQEPRp4kecCwGUQy
DK+5vzbZWHvVObTzLHHGOwFJY+YjAv4pAdMug+odPlCkerfMI4KyLJakj/1oD56X
R+y+SncQ/jYwSrDY6S5MI9563/xrN/i8pyAi4Va5K5OyD7wHqYI=
=/AwG
-----END PGP SIGNATURE-----

--ss5fKcjmwsR8U0m1vQFiNI6o5VAwc2rc5--

