References: <20170812040546.8439-1-a@...2181...>
 <7f21e47a-5d35-7fff-eed7-cc29e9d0bfcb@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <144b3f2c-346a-fa04-716a-e5e094d07b55@...2181...>
Date: Wed, 16 Aug 2017 04:20:15 +0800
MIME-Version: 1.0
In-Reply-To: <7f21e47a-5d35-7fff-eed7-cc29e9d0bfcb@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4hrfelOcVuGwvDiSC0JVgI2rtcWq3nUqC"
Subject: Re: [Openvpn-devel] [PATCH] ntlm: avoid breaking anti-aliasing rules
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
--4hrfelOcVuGwvDiSC0JVgI2rtcWq3nUqC
Content-Type: multipart/mixed; boundary="OhUMfJrBRD7817RMR0a4MidM7UR3V2lq2";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <144b3f2c-346a-fa04-716a-e5e094d07b55@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] ntlm: avoid breaking anti-aliasing rules
References: <20170812040546.8439-1-a@...2181...>
 <7f21e47a-5d35-7fff-eed7-cc29e9d0bfcb@...1856...>
In-Reply-To: <7f21e47a-5d35-7fff-eed7-cc29e9d0bfcb@...1856...>

--OhUMfJrBRD7817RMR0a4MidM7UR3V2lq2
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 16/08/17 04:15, Steffan Karger wrote:
> Hi,
>=20
> On 12-08-17 06:05, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> The problem is visible when compiling with -O2:
>>
>> ntlm.c: In function =E2=80=98ntlm_phase_3=E2=80=99:
>> ntlm.c:305:9: warning: dereferencing type-punned pointer will break stri=
ct-aliasing rules [-Wstrict-aliasing]
>>          if ((*((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000)
>>
>> The spec suggests to interpret those 4 bytes as a long, but
>> this needs to be done carefully.
>>
>> Signed-off-by: Antonio Quartulli <antonio@...515...>
>> ---
>>
>> I have tried to make the statement more clear and "aliasing safe" at the=
 same
>> time. However, this is only compiled tested as I have no way to test the=
 whole
>> NTLM thing. Sorry :(
>>
>> Cheers,
>>
>>  src/openvpn/ntlm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
>> index 65c1cbf5..a251c11d 100644
>> --- a/src/openvpn/ntlm.c
>> +++ b/src/openvpn/ntlm.c
>> @@ -302,7 +302,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const =
char *phase_2,
>>          /* Add target information block to the blob */
>>=20=20
>>          /* Check for Target Information block */
>> -        if ((*((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000)
>> +        unsigned long *flags =3D (unsigned long *)(buf2 + 0x14);
>> +        if ((*flags & htonl(0x00800000)) =3D=3D htonl(0x00800000))
>>          {
>>              tib_len =3D buf2[0x28];            /* Get Target Informatio=
n block size */
>>              if (tib_len > 96)
>>
>=20
>=20
> I *think* this will break the functionality.  Consider the following
> test code:
>=20
> #include <arpa/inet.h>
> #include <stdio.h>
>=20
> int main(char *argv[], int argc)
> {
>     unsigned char buf[4] =3D {0, 0, 0x80, 0};
>=20
>     if ((*((long *)&buf[0]) & 0x00800000) =3D=3D 0x00800000)
>         printf("old: true\n");
>     else
>         printf("old: false\n");
>=20
>     unsigned long *flags =3D (unsigned long *)(buf);
>     if ((*flags & htonl(0x00800000)) =3D=3D htonl(0x00800000))
>         printf("new: true\n");
>     else
>         printf("new: false\n");
>=20
>     return 0;
> }
>=20
> On amd64, this prints:
>=20
> old: true
> new: false
>=20
> I'd expect some 'ntohl' call in this code somewhere, but that assumes
> that the NTLM spec was designed somewhat sane and uses network byte order=
...
>=20

Right, that's also what I imagined, otherwise the code as it is wouldn't
work on every platform (not sure it does on LE archs)

> For now, I'd suggest to stick to just fixing the type-punned dereference
> and leave out any htonl/ntohl calls.
>=20

yeah, might be safer. Will send v2.

Cheers,


--=20
Antonio Quartulli


--OhUMfJrBRD7817RMR0a4MidM7UR3V2lq2--

--4hrfelOcVuGwvDiSC0JVgI2rtcWq3nUqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmTV38ACgkQ0+HICM1s
oFB7eA/8D5ggvXaWHd3XFV5kZ+KzYx+q9JHnToSInItYaELWBMe4CSDILy7lUTbu
5ro8alZcfvcFskRhFYvyru9D5Zsv69AGRDye4LYsNy2W52f5KcA7bm9fu+tZ2b3O
1d54say7DFNSnNoy14bbW1rVp2QVWwRenT1ryNa7zZWFfaFizKiNJA5Jzdw//UQd
6xBgBjdOMrq3NXNSatZ/v+1Ovou72L/TvTYlMAOUab/ZYvaZhHeDwi8vOxNQG9qf
Xe/hDJn5p5TLa88bfBAmM6QHxLoagSbLU4DsLtNFfjTDrkAis9biQlHFqAI1mBrI
ZDYDpgm4Tejm8E+5mVkhXmuF7pdot3tAeY8G42rrrhSydruHBxreL6ezQf+csO5g
rjFv+D3HyHUOomTjlihbqbChWyTfRPXMk9sw81cNXy89PPk4H0HMSxoaeP35aY40
FNE8ooERpKrEKyuQeLiMr0HuFj8biZnajVt9ABLu/T+N388suyW9HMeVB17O0GsI
yGV7IV8nAflQE7zXrRnUDcA/rwHq0462U0r4TQnhmo82mCfl8H2QU2YXU3TsFXX9
12umo1DktXxRjtcbIDj9UPv9ZxhC0JYSdMWBi6wsVkL57+SP/0iUdqtr1pqERYyL
LArSD5Xjbj0PQnxICm8hCEoW9maDc+n6gH/Snswom/rrQsB/eX0=
=gzhD
-----END PGP SIGNATURE-----

--4hrfelOcVuGwvDiSC0JVgI2rtcWq3nUqC--

