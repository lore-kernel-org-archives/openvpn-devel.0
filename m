From: Antonio Quartulli <a@...2181...>
References: <20170828085620.23186-1-a@...2181...>
 <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>
 <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>
Message-ID: <0193f862-eb79-b20e-30a1-48dd6d057c87@...2181...>
Date: Mon, 18 Sep 2017 14:15:13 +0800
MIME-Version: 1.0
In-Reply-To: <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w128S9wvleSVjc6oWi14HdDLOR8x67bBD"
Subject: Re: [Openvpn-devel] [PATCH 1/2] merge *-inline.h files with their
 main header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w128S9wvleSVjc6oWi14HdDLOR8x67bBD
Content-Type: multipart/mixed; boundary="wPqCejwu7WfWGA6DGsBQvAwH0QNU4XP68";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <0193f862-eb79-b20e-30a1-48dd6d057c87@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] merge *-inline.h files with their
 main header
References: <20170828085620.23186-1-a@...2181...>
 <e22ea0fa-4e1b-980b-a1a2-dc4ba1352a6d@...1856...>
 <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>
In-Reply-To: <a187f8ca-afe6-5633-9d3b-be22aee9a3ec@...2181...>

--wPqCejwu7WfWGA6DGsBQvAwH0QNU4XP68
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 18/09/17 13:18, Antonio Quartulli wrote:
> Hi,
>=20
> On 17/09/17 20:00, Steffan Karger wrote:
>=20
> [CUT]
>=20
>>> @@ -101,4 +104,16 @@ void pf_context_print(const struct pf_context *pfc=
, const char *prefix, const in
>>>=20=20
>>>  #endif
>>>=20=20
>>> +bool pf_c2c_test(const struct context *src, const struct context *dest,
>>> +                 const char *prefix);
>>> +
>>> +bool pf_addr_test(const struct context *src, const struct mroute_addr =
*dest,
>>> +                  const char *prefix);
>>
>> Why are these no longer inline?  They seem to be simple wrappers to
>> prevent a function call is pf is not enabled.
>>
>=20
> Oh, I needed sometime, but then I understood what you mean :)
>=20
> You are saying that by keeping this function inline, we have a slight
> performance gain because we won't invoke pf_cn_test() when pf is
> disabled. And such decision can be made inline.

Now I recall why I changed that.

pf_c2c_test is dereferencing an object of type "struct context" for
which we have no definition available at that point.

A fix could be to include openvpn.h in pf.h, but then we get other weird
problems due to circular inclusions. Having pf-inline.h was, of course,
much easier because you could place its inclusion at the most convenient
place and the problem was solved.

I'll try to restructure the functions a bit so that we don't lose the
gain given by the inline attribute, but we don't need to dereference the
context as well.

Cheers,

>=20
>=20
> I agree. I will send a v2 of this patch.
>=20
>=20
>>>
>>
>> Otherwise this patch looks good.
>=20
> Thanks for reviewing!
>=20
> Cheers,
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--wPqCejwu7WfWGA6DGsBQvAwH0QNU4XP68--

--w128S9wvleSVjc6oWi14HdDLOR8x67bBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlm/ZHEACgkQ0+HICM1s
oFCQIA//WwKgI601ceIkGjR5df+UkUeuplKzOh6gPwVG/N1IWhcLMd48RKDlhD87
4UnTCwqnO3TtZBVooaJsA5KM08xOVJx5w0NeXsmPeIp1rk/vElxH0NVpf9iEqx+y
1h+9tj2E3BDV+BLyifoGdNle0Ov5dI5S+D3AbpwUcavfhJsyCJtFu3+1xdiSnBwf
UThI1nEKakqdWDmxQvF14d6RPEXAuYXQwB76/HbIep4UIiOsPKySSsvVfUEwb0z1
14oTgcf3E+snRmsLgCch09gx2Z7RbPRIFJ092e/C3IeOj5A+0AcP1BdTXPW26/p4
ioEFcVMyiuCe9L9rp/LNhH97shsLulT6wQm5IhYZduCG+u+9d2pFpuwuPOSMRsrM
u4B6t0uyAz1yExRQPPK0krukoXty62UTeJM3NHBTgDVGa6YZscMFL8elZXAAbmz0
xhNnfeO2kAtPoLsycuSlm0WNhipVmdipfyocm9acQLwyXpc16HeFG88x07jjUX2v
4ZabYrTB6Xr5LyqKbditNnDDhwzWR2pFefcEbdQZbe3/X36UvmZUsFyr5Dsb7Yge
kx/ewXjh3OhOn3hFFaZ8gS4tAMpcEJXx0swYMwO1B8Kht+0Pf3uF+AeaoC9aMeNU
KbytvVEALMy1s7+1uLG7cHjs6UsTwKXvoL8d5rV9rQkzUdhwf2A=
=8i/g
-----END PGP SIGNATURE-----

--w128S9wvleSVjc6oWi14HdDLOR8x67bBD--

