References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
Date: Wed, 5 Apr 2017 17:53:51 +0200
MIME-Version: 1.0
In-Reply-To: <267890da-2186-dddb-d4c4-d6374da7e086@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wMNg1q1o1qjE8IgfpSlV9whCjthTO2uiG"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wMNg1q1o1qjE8IgfpSlV9whCjthTO2uiG
Content-Type: multipart/mixed; boundary="fdvM39bD0BImktf7HfUFsFt7k2m5S95Vp";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
In-Reply-To: <267890da-2186-dddb-d4c4-d6374da7e086@...277...>

--fdvM39bD0BImktf7HfUFsFt7k2m5S95Vp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 16:42, debbie10t wrote:
>=20
>=20
> On 05/04/17 05:34, Simon Matter wrote:
>>>> Hi,
>>>>
>>>> On Tue, Apr 04, 2017 at 08:29:49AM +0200, Simon Matter wrote:
>>>>> Interesting to see that there is zero interest in this patch here.
>>>>
>>>> This is a misinterpretation.
>>>>
>>>
>>> Hi Gert,
>>>
>>> Thanks for the explanation, I'll be patient then :)
>>>
>>> If it's preferred for the patch to keep it even simpler and compatible =
the
>>> current configs, it could be broken down to something like this in init=
.c:
>>
>> I've attached v2 now which works without any config change:
>>
>> --reneg-sec n
>>     Renegotiate data channel key after n seconds (default=3D3600).
>>
>>     Note that the effective value used here is a per session pseudo-
>>     randomized 25% of n deducted from n.  With the default value  of
>>     3600 this results in an effective per session value in the range
>>     of 2701 ... 3600 seconds.
>>
>=20
>=20
> A different approach could be like so:
>=20
> --reneg-sec 3600
> --reneg-sec-1sttime-rand 1|0 (The name here for detail)

Too complicated ;-)

--reneg-sec      # 60 minutes, with X % in randomness
--reneg-sec 1800 # 30 minutes, with X % in randomness
(X is what we figure is reasonable by default; between 10-25%)

--reneg-sec 3600 30  # 60 minutes, 30% randomness
--reneg-sec 1800 0   # 30 minutes, no randomness

This won't break any configurations and gives full flexibility without
adding new options (which we really try to avoid).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--fdvM39bD0BImktf7HfUFsFt7k2m5S95Vp--

--wMNg1q1o1qjE8IgfpSlV9whCjthTO2uiG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5RMPAAoJEIbPlEyWcf3yelMP/2QwiXbESajDIOpmoxpnLqKY
liLxrAnJXaY6odLLiFMa0IIhEVXEytrpkyoC1aErqsWIwQi6+XDSnOzRTvERvaBn
AzDgBaMqhR+Cjpb0BMyZXnk8a16epyqbTrViWY8Tce8LRcMV2xMsjpBV7cRYJ3zD
LCEgboItmP66jwKVlOOYyfOiIOQYtXLKSqUGXNOWycJ9lLrpX9KvLzE5CThfuDtI
IpKhtvsrOY0Le45q4/wsm0NtVegBLuetWkhMwoJVyr7Wfe3dk/7Vjdv7u4/r21W6
GO/rGAK3DNeRF6Eo/5A8D8CqduykVL/YvPPyvhfkRVmg/+UnQ8/RYSw2M+st2qFp
Ry/BAsYug6oAZuFMjBo3xpXMvrd4L8Gi4WnJv/IGvbg5Ma1lqz6UNUyN9AQAFVZU
MQ5d4F5XsH2h3r5QqIrm1gtbo32UEhsAQWxC+Qu1/mUk4Cotc6sYk4LXwvFdADfD
YwPk5smfXrlOFLlMK9n9NCJ7hAns4R7E+j3xCUJ7ZMDisSpBMVlnbEUa0mPs+4hg
SYBofanj0gRz6pzYqB8ceJZaRDVMzqFM0wkUuYSLNLlz5XSUJwER3oXMaeIIkGFf
P/BI3NW24ecai2dHA/L0iQX62huUnJAVuSuABGcF2hSB6g0HDTr8Czca5Mp8SLlW
VqsrL6VlVPSqBYWmYk+y
=dzk0
-----END PGP SIGNATURE-----

--wMNg1q1o1qjE8IgfpSlV9whCjthTO2uiG--

