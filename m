References: <20190812134513.20758-1-arne@...1227...>
 <a1b2525b-fb00-4d8d-d877-797305c6ec2f@...2181...>
 <038d3040-5133-9841-ca28-d433ca228f0c@...2080...>
 <a214be99-8c20-56e0-7dcd-3a8425129dfb@...2181...>
 <2d7656f6-319b-c667-7e1c-e67800995bd4@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <39275f45-d889-6f44-1388-0f590c0a1164@...2080...>
Date: Wed, 14 Aug 2019 00:51:23 +0200
MIME-Version: 1.0
In-Reply-To: <2d7656f6-319b-c667-7e1c-e67800995bd4@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="x4qoP44Mx68V5lVYSF4ujUw9ExmAsvGFe"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix check if iface name is set
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
--x4qoP44Mx68V5lVYSF4ujUw9ExmAsvGFe
Content-Type: multipart/mixed; boundary="hXdW2ghysNoUiwOpzag9JyoqaobeAyAGX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <39275f45-d889-6f44-1388-0f590c0a1164@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix check if iface name is set
References: <20190812134513.20758-1-arne@...1227...>
 <a1b2525b-fb00-4d8d-d877-797305c6ec2f@...2181...>
 <038d3040-5133-9841-ca28-d433ca228f0c@...2080...>
 <a214be99-8c20-56e0-7dcd-3a8425129dfb@...2181...>
 <2d7656f6-319b-c667-7e1c-e67800995bd4@...1856...>
In-Reply-To: <2d7656f6-319b-c667-7e1c-e67800995bd4@...1856...>

--hXdW2ghysNoUiwOpzag9JyoqaobeAyAGX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13/08/2019 23:46, Steffan Karger wrote:
> Hi,
>=20
> On 13-08-19 23:31, Antonio Quartulli wrote:
>> On 13/08/2019 23:26, David Sommerseth wrote:
>>> wouldn't it be better to
>>> do 'if (rgi6->iface[0])' instead?  Since the buffer should be NULL term=
inated
>>> and has to be NULL terminted for strlen() to function anyhow.  But the
>>> compiled code would be a bit more efficient (even though, this isn't
>>> necessarily a performance critical code section).
>>
>> In my opinion strlen() is more readable for the casual developer
>> checking this code. Behind iface[0] we may hide other ambiguous
>> assumptions (even though this is not the case here, but we won't
>> remember in some months from now).
>=20
> Antionio's answer is of course the real reason to use strlen(), but you
> nerd-sniped me by saying "compiled code would be a bit more efficient".
> As you said, that wouldn't matter here, but still: compilers nowadays do
> optimize calls to strlen, memset, memcpy, etc.
>=20
> The following code
>=20
> #include <string.h>
>=20
> int test(const char *buf) {
>     return (strlen(buf) > 0);
> }
>=20
> for example compiles with -O3 on my GCC 8.3 to
>=20
> 0000000000000000 <test>:
>    0:	31 c0                	xor    %eax,%eax
>    2:	80 3f 00             	cmpb   $0x0,(%rdi)
>    5:	0f 95 c0             	setne  %al
>    8:	c3                   	retq
>=20
> which indeed just compares the first byte of the buffer against zero.
>=20
> So, unless there are important performance constraints, let's optimize
> code for readability, rather than performance :)

Cool!  Thanks!  I didn't run such a check, as I really didn't expect the
compiler to be _that_ smart ... but I agree with you both, and especially w=
hen
the end result is optimized for both readability *and* performance ;-)


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--hXdW2ghysNoUiwOpzag9JyoqaobeAyAGX--

--x4qoP44Mx68V5lVYSF4ujUw9ExmAsvGFe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdUz7yAAoJEIbPlEyWcf3y/toQAIjEL12DsoakFw1fLkSB2URU
nBtm7fnc8sacADHCVuVhahQ4DHKF506w0aeDdnk12acf3FCOFca5Og+phP48c7mV
+TI1Z/BuIyHG1PiCNGUrszipF/8c8d0aHU25j92+uAM9iGQGbEHsABK5aE9cY0N6
ZGormaZUz/JUla8AZTjy1EMKsh9Af+wcYMyMz0/pBAm3E2uqeZ/Qjwn4tbMsmhi7
CImVprmZlwxHP81mSsn0Rm5pALj3pS+eKbbp9pCr6A2pGB76XDHqnuiU9i6H2I2F
WmVYcEuh/4HTiupAhskmF7LBolHt13NcK8MnJVzGoAxvr+7/KwOghU+hnGJmZ8Fz
3Au2jdE9ghfEl8U9l01j6qAVCoCzM87M/fAzt5ePG6l8zDi9WEXf1Ny2wPTdKLVO
yshMEtVxGEI9L1+00MkLBMPPTuKVix/hvuSihGdHzU+FMYIQgsGXGmZ+ntixjdf8
A+IiK6NwbZ1PB8ilrajPTbJ9lpbA0KrXeIwTwxR201ObYsbbDBn/qUmI7VZPuh6l
LptrhAsK9FxHfZlEtych/axZC7LTJ9men30cI78fKHF8EogDLoI1go33Z8o8fB6+
/arc9A/DUhD1qj1dKRzg/e5+kvKV5ncrHdl6RUD+GuQxC1CHpzoph59FH9syZVPp
6cCG0o6Wdz+SCfkIXCaI
=6Sdx
-----END PGP SIGNATURE-----

--x4qoP44Mx68V5lVYSF4ujUw9ExmAsvGFe--

