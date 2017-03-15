References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
	<20170315210046.GW93896@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d4b41c50-b5f8-cbe6-792f-62c2622da7d8@...1856...>
Date: Wed, 15 Mar 2017 22:31:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170315210046.GW93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SwwBWJAH2btjulrwfa7iOUIuQVd93doUG"
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SwwBWJAH2btjulrwfa7iOUIuQVd93doUG
Content-Type: multipart/mixed; boundary="BKRgvcldjcv3lEuPPQIcQs4lXjBxGHbf9";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <d4b41c50-b5f8-cbe6-792f-62c2622da7d8@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix Building Using MSVC
References: <1b2fc2aa-74b0-6a91-aeb0-a45d7a8062cc@...1918...>
	<20170315210046.GW93896@...1296...>
In-Reply-To: <20170315210046.GW93896@...1296...>

--BKRgvcldjcv3lEuPPQIcQs4lXjBxGHbf9
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 15-03-17 22:00, Gert Doering wrote:
> On Tue, Mar 14, 2017 at 09:26:52AM +1100, Eric Thorpe wrote:
>>   #ifdef HAVE_CONFIG_MSVC_LOCAL_H
>>   #include <config-msvc-local.h>
>> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
>> index 5549d70..bed39f3 100644
>> --- a/src/openvpn/crypto_openssl.c
>> +++ b/src/openvpn/crypto_openssl.c
>> @@ -287,7 +287,12 @@ show_available_ciphers()
>>
>>       /* If we ever exceed this, we must be more selective */
>>       const size_t cipher_list_len =3D 1000;
>> +#ifdef _MSC_VER
>> +    //While GCC will allow you to use a const, MSVC won't (at least=20
>> with a simple declaration). Use a compile time constant for now
>> +    const EVP_CIPHER *cipher_list[1000];
>> +#else
>>       const EVP_CIPHER *cipher_list[cipher_list_len];
>> +#endif
>>       size_t num_ciphers =3D 0;
>=20
> I don't think we should do this.  If we have a length, use it.  If
> the compiler is too daft to understand consts, maybe we should go
> for "#define CIPHER_LIST_LEN 1000" instead - indeed, more changes,
> but no magic numbers.  Or abandon the definition, use [1000], and
> sizeof() in the out of bounds check below.
>=20
> Steffan, your code, what would you say?

Hm, this is somewhat chewing on our decision that 'we now only support
compilers that do C99', but I can see that this is easily fixed so I can
live with just begin pragmatic.  In that case, let's go for the
sizeof().  Adding a define of course works, but I find it somewhat clunky.

-Steffan


--BKRgvcldjcv3lEuPPQIcQs4lXjBxGHbf9--

--SwwBWJAH2btjulrwfa7iOUIuQVd93doUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYybLOAAoJEJgCyj0AftKIGlUH/0QxSOpZeefuHumaXsf8jS05
bZ4ydCcP5+uDc23BPZU+THpAm0O+79MpMOAHHQiybMRQViL+CarmWEzao1Xf2KCY
3hWt80kKYW/oC56oCtTK3D/a85uWyqLJA8+VlPGRgxY3cYaU/WppuGJoeO0dvgz3
2Q67akU0zgqljzwmu/K0dpxkdO9HBPWRNla/FIyBlrGQwlTHG3ihSbQpCwb6fNwj
YlEOGx0oAnIvh8q6CsqwPRYdvQVceDX5oFZzgjwFwFafeORGNgPFLFVFI1UhhALf
1YFWNzczGbRt3ySV0hWwAuXdZ2Vl8EQ6MbMnuKXTQDd1ew8rsKERDQ4LW3PWD2c=
=LHKX
-----END PGP SIGNATURE-----

--SwwBWJAH2btjulrwfa7iOUIuQVd93doUG--

