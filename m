References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-2-a@...2181...> <20180613110630.GO57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c5e3a021-feaf-d516-f25a-07244730ff97@...2181...>
Date: Wed, 13 Jun 2018 19:41:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180613110630.GO57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MYu73aRVt8B60anoFFy0c5qfZabBKJxXC"
Subject: Re: [Openvpn-devel] [PATCH 1/3] tun: ensure gc and argv are always
 freed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MYu73aRVt8B60anoFFy0c5qfZabBKJxXC
Content-Type: multipart/mixed; boundary="rpMZ4VFdF0gaDiP9u4i9UlCgI9ukO1cub";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c5e3a021-feaf-d516-f25a-07244730ff97@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] tun: ensure gc and argv are always
 freed
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-2-a@...2181...> <20180613110630.GO57262@...1296...>
In-Reply-To: <20180613110630.GO57262@...1296...>

--rpMZ4VFdF0gaDiP9u4i9UlCgI9ukO1cub
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/06/18 19:06, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jun 13, 2018 at 04:12:15PM +0800, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> Everytime a argv object is initialized with argv_new(), it has
>> to be released with argv_reset() once not needed anymore.
>>
>> The same holds for gc_arena objects initialized with gc_new() that
>> have to be released with gc_free().
>>
>> Ensure both kind of objects are always properly released to avoid
>> memory leaks.
>=20
> This is good housekeeping.  Still, I need to NAK this, because I never
> agree to anything on the first go ;-)
>=20
> Specifically...
>=20
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>> ---
>>  src/openvpn/tun.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 3eb0f78a..466d4d42 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -2615,6 +2615,8 @@ close_tun(struct tuntap *tt)
>>          openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun inte=
rface' failed (non-critical)");
>>=20=20
>>          free(tt);
>> +        argv_reset(&argv);
>> +        gc_free(&gc);
>>      }
>>  }
>=20
> While this is technically correct, the gc_arena is not used at all in=20
> this close_tun() instance (OPENBSD).  So, please do not add a cleanup cal=
l,=20
> but just remove the "struct gc_arena gc =3D gc_new()" call instead.
>=20

Oh, right! I was so focused on the gc_new/gc_free pattern that I did not
realize it was not used at all. Well, I assumed it was there for a
reason :-)

> The same holds for the NETBSD and AIX variants - gc/argv initialized, but=
=20
> only argv used.  So, please remove gc_arena instead :-)
>=20

ok

> (Side note: the FREEBSD close_tun() variant is mostly the same, but does
> not have a gc_arena ... seems someone already stumbled across that one
> and fixed it)
>=20
>=20
> ACK on the remaining AIX argv_reset() - oops, that was me :-)
>=20

Thanks,


--=20
Antonio Quartulli


--rpMZ4VFdF0gaDiP9u4i9UlCgI9ukO1cub--

--MYu73aRVt8B60anoFFy0c5qfZabBKJxXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlshAwQACgkQB6U8WA7y
zXTDuQ/8Cl+Zdm45R5VsBX0NvE9f/k/wmsGyM9Grrs4J2aPyuNk5q9eQho8iobGC
scDNi07o+Rms6MVXfxBRtVX/M5JaM7eTmaOiwKTcqkd9lypvQexSUDGka5zvN2sa
0kgxjEWH4RJcuXZytxWV51m45228ijFb+AeCmVFUw2L4dancN3dBD+IzAmKgY0Mq
PLLzFcOlcxkv4o6KJNg1dEDiKZh7T4f5fqDcp4KrQF3basMxhFwnyF0J42HuYz7K
UC3khxvdHm5tihxIwbLg0usZjjspp0vOVO+UieVW2jYd4wU1QmTA1yESH1vlguQz
0RVSuHUTrucwtbzrNGr4rcz1rx27AB813ygUO2ls6D86VMaG4kFpkbTVDvOGQ1OT
ILoWMW/RAZwgNu7jjURJTAmLj0rO2FNwGrk+eY8BC5hER7mMDHk0jN4HC2pO+UWW
uuBFzLeW7WDUgasbJ5J9KAludiM2Qc6U2Khqx69UiqjPiN2FfvhsktOS1l5VsF+m
OrTrvq+jpOzqb3ACr3ul2GyS3GJ+vr7tMI+T9nZKDx0zAkGuyCYuWbH7rxC4g8zx
aMzRCwQnrlNogq6G8CLy2yhx0UxoiOkwupAN0pgqI3dX05SourSuHJokWmM0mElc
kzW0pWmDtf4PGnWlj0VCgP8M+uG8kQM2rblrlcQ1H9Rpa2Fpt7M=
=xoaE
-----END PGP SIGNATURE-----

--MYu73aRVt8B60anoFFy0c5qfZabBKJxXC--

