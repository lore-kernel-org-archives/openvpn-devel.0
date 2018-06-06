References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <de795646-98dd-fd67-b2cd-c19f8179a4e2@...2181...>
Date: Wed, 6 Jun 2018 09:08:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180605195935.GU57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="svZ3ROAa8KKPzs2tkDA1r0DAVDs4QqMt5"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--svZ3ROAa8KKPzs2tkDA1r0DAVDs4QqMt5
Content-Type: multipart/mixed; boundary="3Sn6hRXu7JofJrL4bc7nIrc5JCiiSQnys";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <de795646-98dd-fd67-b2cd-c19f8179a4e2@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
In-Reply-To: <20180605195935.GU57262@...1296...>

--3Sn6hRXu7JofJrL4bc7nIrc5JCiiSQnys
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 03:59, Gert Doering wrote:
[cut]
>> Here is the diff of what I did for the Windows build run:
>>
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 2e33880..75336a9 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -5824,9 +5824,9 @@ open_tun(const char *dev, const char *dev_type,
>> const char *dev_node, struct tun
>>
>>      if (tt->type =3D=3D DEV_TYPE_TUN)
>>      {
>> -        if (!tt->did_ifconfig_setup)
>> +        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
>>          {
>> -            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
>> +            msg(M_WARN|M_INFO, "WARNING: neither ifconfig nor
>> ifconfig-ipv6 specified");
>>          }
>=20
> Thanks.  This is easy enough to integrate...  Antonio, are you listening?=
 ;-)
>=20

Copy that!
I'll add this change in v2.


Cheers,


--=20
Antonio Quartulli


--3Sn6hRXu7JofJrL4bc7nIrc5JCiiSQnys--

--svZ3ROAa8KKPzs2tkDA1r0DAVDs4QqMt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXNCcACgkQB6U8WA7y
zXTGOw//UPOKnZ9ZC29Fsk0BmEuCz3RTN8vBBuAF+CmXG3wA6ly3y7tohrLtSbiH
kTPSpAEQ3Fq42Do05PuDFjxCfxnLCWLw6skEGHo51XYfhA0PV/K0ltRT6oPAfhHm
kkP7iZN4rWs45UPHAE1Gp89mMsrk9fJRiTc42+t94z17BqaPZlZCjNVjmzo7sSMF
3rSPZGsqPJmCljadCsNWD4sHMVH+60xbLY9gYQZhKH3m9YUiZUd92Gy2pMwqjnfY
NvvJNehUaBymFeukLxS15DJyk8jf8nDNMghLEa5R85UW1HL8Oze9aZsHJ3SzbbAc
tNzrYJRW6MivYSX2Bp54dK/6L/Azv2q+TGG7Ety+Mrsn8fi7T/PD/yVYEpMIc4v2
ANYJgjoeyLDaBXHrPmyd6iPKceOXp3yTl+WCpObazdLf2q2UkaHEJ4kqZHHBA/h5
wL+pCud3tGX5qmrWX51yubSnFW0K8qBJfykUb6O2foNrk7bZJQGw4mNqFB6ewA8r
awbs1nOtLBPOdpvmEdab27USwFba4XrJCxmIOJv/zXeooFGVer+BZxbhD4vvD03A
klhnZrhlqIHa0TmVOxfJj5iY38BRtEGH/j36C+qGv6+03yxvXDqyCqL3YZWiii0M
7MSzl6iIxM7fk198ycPya9g4deDZEmylRU1KLKgzYzgfl9ad8dQ=
=p/8/
-----END PGP SIGNATURE-----

--svZ3ROAa8KKPzs2tkDA1r0DAVDs4QqMt5--

