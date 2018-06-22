References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
Date: Fri, 22 Jun 2018 22:48:30 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pWhFmGHAGFaPoMtrRe87LWPs0El958fKB"
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pWhFmGHAGFaPoMtrRe87LWPs0El958fKB
Content-Type: multipart/mixed; boundary="ql3nmsTI52OCoUOuPLVIHtj1EIylnnGf0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <5858f87b-165f-f390-6769-938e5a43ce55@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
References: <20180622102110.21888-1-a@...2181...>
 <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>
In-Reply-To: <CAKuzo_iAnVU=6bar7a6TLXOjWqMuNjLhiznD9oPBnpyGC4sfTg@...278...>

--ql3nmsTI52OCoUOuPLVIHtj1EIylnnGf0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/06/18 22:45, Selva Nair wrote:
[cut]
>> --- a/src/openvpn/route.c
>> +++ b/src/openvpn/route.c
>> @@ -1616,7 +1616,7 @@ add_route(struct route_ipv4 *r, const struct tuntap
> *tt, unsigned int flags,
>>          if (is_on_link(is_local_route, flags, rgi))
>>          {
>>              ai =3D rgi->adapter_index;
>> -            argv_printf_cat(&argv, "IF %lu", ai);
>> +            argv_printf_cat(&argv, "IF %u", ai);
>>          }
>>
>>          argv_msg(D_ROUTE, &argv);
>=20
> Thanks for cleaning up my mistake (commit
> 06ad53e067d9a8be571a27f44005fa7e8038f69e introduced this). One
> purpose of that commit was to get rid of -Wformat warnings as those
> are not always benign. But this will re-introduce a warning as "ai" is
> unsigned long even though its the same size as unsigned.
>=20
> Currently we do support building with -Werror=3Dformat (see
> https://patchwork.openvpn.net/patch/234/#463), so I suggest either
> cast to (unsigned)  which we know is safe here, or add "%lu" to
> argv_printf_arglist().
>=20
> I would prefer the latter as its easy to overlook the fact that
> argv_printf_cat() can't handle %lu which is commonly used
> on Windows.

I was just about to test a v2 of this patch with the explicit cast to
"unsigned int". I was leaning towards the explicit cast because we
already print DWORD variables in several spots and we always cast them
to int or unsigned int.

However, if we believe supporting %lu can be more useful, I can do that.

Last opinion? :)

Cheers,



--=20
Antonio Quartulli


--ql3nmsTI52OCoUOuPLVIHtj1EIylnnGf0--

--pWhFmGHAGFaPoMtrRe87LWPs0El958fKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlstDD4ACgkQB6U8WA7y
zXR+IRAAuu+DJM84i+xzEFCrXvYFNW0QRqAjzv5nAZqomvZSqlAyrSwmLOBH9vZp
qqYRxyPyfgqopj6GkBIfpbOch/KcZh8jLv+WOeYCJy2CiNqn9tX1uHjZVu0M3RM5
zEBzv2WdeA+sGAeyvaeVgw+E2uBJvWq+a5ReXbstWq4Oo5OKMCXENJHNbu6e9l3S
MJLq0/yUZ0ExlOSyDHoYejn1yKuoLnmkVkMooYMlFYCIJuo8AaNpL8/kojH9KvXO
e8y2bjogwGlBN9fpmX1jqNFqa2We6VrSpKqsjlQEOE7PEt+7l7h5xybcnRKIdqNF
6jl3JwPa4rkIwX0VymoqLBChmnmn+meotilzWfloMQcLyfsC20hNpROAkSWmFC6R
Pst0ytxNyMQh2hOhJjgcPHrPws+MLUobkcmc6/HxXv0xRRBIjf9zL1p9Vs2CMIoe
TtcJEs4SuYJlRDXiIml5uqO6YtSVL6JjKP0057JJfE5F3nOvqFCN2UbitlO+MoPc
0kfOA2uJbqe/JvQV8MyhZhsWiFgoooynxoLVw13egOW8Pe1B9Cp7zMtkzQsTh8wI
aC1nwgDL7fXH3gdziA6vrJC7itAheszgaQGMSssMoAUiLkIgcQpHGD1QBFfHWtUJ
0E+1gD+I/juvtk2UXCGORva527Di5dKJoUFo/0mXb9P3REmKBl0=
=jcYb
-----END PGP SIGNATURE-----

--pWhFmGHAGFaPoMtrRe87LWPs0El958fKB--

