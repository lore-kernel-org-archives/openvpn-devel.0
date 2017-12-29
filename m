References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
 <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
Date: Fri, 29 Dec 2017 19:02:28 +0800
MIME-Version: 1.0
In-Reply-To: <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CV8PIyiApzio9zbxSVd7TZtkJVFObQIMW"
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CV8PIyiApzio9zbxSVd7TZtkJVFObQIMW
Content-Type: multipart/mixed; boundary="gJZsaTALXJIARYAzw0PWWGKVc66PL4ohZ";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
 <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
In-Reply-To: <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>

--gJZsaTALXJIARYAzw0PWWGKVc66PL4ohZ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 18:23, Steffan Karger wrote:
> Hi,
>=20
> On 29-12-17 11:11, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> thank for the patch.
>>
>> not directly related to the patch itself, but openvpn is shipped with
>> several memory debugging options
>>
>> --with-mem-check=3DTYPE=C2=A0=C2=A0 build with debug memory checking
>>
>>
>> should we get rid of them (in favour of sanitizers) ? or, maybe add to
>> tests instead ?
>=20
> I've tried to use those in the past, but found them hard to use.  I
> think they're a remnant of the past.  I would personally prefer to get
> rid of them and use the (nowadays much better) fully external memory
> checking tools instead (sanitizers, valgrind, etc).

As Selva pointed out, we don't use --with-mem-check in any test,
therefore I am not even sure it still works as expected.

I am also in favour in of getting rid of our custom made check and use
compilers provided sanitizers instead (also gcc provides interesting
sanitizers, thus everybody should be bale to enable them).

Cheers,

--=20
Antonio Quartulli


--gJZsaTALXJIARYAzw0PWWGKVc66PL4ohZ--

--CV8PIyiApzio9zbxSVd7TZtkJVFObQIMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGIMQACgkQB6U8WA7y
zXQrXA//Y6EzLYA+rm5gIXLIyXHJRNvRUwtOCeBdLf0L5k5eigvcTvP2p5ij6DW+
w/wKSIiN+pQSRSFlnTqDMp7r/2w02/1mHeqp50DdUQvGyeJqBZMu4VSMt9Yvav6s
L0n12J8kz0pvic7S+RTHLoGyJrdW2+WBz7lKgc7odDvD6EvNreUU84ka4Z7zlVhc
a63cWGUsCOoC6EFjOsHR66qE/UeI0lzr/rfLUIbRfZ1ayLGdo1LJMAfJ00RBbniF
1663c/Dsw8m26lGAwVsiIFOYPWHx0IYSEIPdc5Y9G+1tLTo9p3GUujOWy9L0kTaO
1sZUbWl3Z98Z05fSRpWZh7n/sFA/SYBxEq5PfTX3acmDuFObDRqaQrEYJKdaJpz1
YBr2bvRTnuLHauzPWOUFrGIqdwhKq/KYnkxDB5GJDAsOauOjzHP0xfCDnjHWM3df
7ea7YFyZBkEPuVdSoYOubt0uurhyLw0fgI6xw5yidww2u1Ga/Y9sn9RYm59DT4i/
y0HE7AdK6MJnYh4teDfKdyeGuY/uP0zu/bP8hP/5IEEGN2dVGVvMQVP/lXO37sWc
IsAmNHNzmnlPo34zaOIH/k5jPgB7F0U+70zT6LDw3Evb7Th+tQswmjzogo23gQsR
WU/1SJ9OscxLrpxiQTZixaUWYWzH7l4tfjgOKePiMfmJQ7IYwkU=
=VtiB
-----END PGP SIGNATURE-----

--CV8PIyiApzio9zbxSVd7TZtkJVFObQIMW--

