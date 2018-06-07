References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
 <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f0a67a1c-8103-5db9-44b2-7f4c82dc70a8@...2181...>
Date: Fri, 8 Jun 2018 01:28:56 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vbmmIPuSwVEVy5R8tBe7xlmIW6XnQs0QP"
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
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vbmmIPuSwVEVy5R8tBe7xlmIW6XnQs0QP
Content-Type: multipart/mixed; boundary="sUzyekgCyl8dIC4CHDCOkm4DPEOX2DIw4";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <f0a67a1c-8103-5db9-44b2-7f4c82dc70a8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
 <20180607165705.GP57262@...1296...>
 <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>
In-Reply-To: <CAKuzo_j23Y5Q367cug-usSheh5h6WXUqswOqNBVS3073rMesVw@...278...>

--sUzyekgCyl8dIC4CHDCOkm4DPEOX2DIw4
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/06/18 01:05, Selva Nair wrote:
> Hi,
>=20
> On Thu, Jun 7, 2018 at 12:57 PM, Gert Doering <gert@...1296...> wrote:
>> Hi,
>>
>> On Thu, Jun 07, 2018 at 12:14:51PM -0400, Selva Nair wrote:
>>> Note: All that said, I can't seem to connect to the server via ipv6
>>> when there is no v4 address. tracert fails before the first hop.
>>> v6 does work when ifconfig is not filtered out.
>>
>> This "should not happen".
>>
>> v6 should work no matter what we break in v4 land.
>>
>> But this is windows, and "should work" land...
>=20
> It happens because the patch skips CONFIG_TUN ioctl when v4 address is
> not set. I think that skips some initialization steps. I had expected
> the patch to setup the driver using 0/0/0 as the addres/mask/net as we
> discussed earlier. Fixing that should make the tap driver talk back to
> us and v6 work.

I have fixed that, but I have not been able to compile/test yet. Feel
free to give it a shot.

Cheers,

>=20
> Selva
>=20

--=20
Antonio Quartulli


--sUzyekgCyl8dIC4CHDCOkm4DPEOX2DIw4--

--vbmmIPuSwVEVy5R8tBe7xlmIW6XnQs0QP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsZa1gACgkQB6U8WA7y
zXSa1g/9HNfij1OPf9CwZA4eEVl7NvoAExtsbc0IcLnY6Qx9NPgzG1yoQgnwB8o2
5spm5xRySdC8tLol9Uo7JvHahdukynmnuhpyeCYust4Z9adPhFBC8UilMfzNcgI2
MDpBR89EzySKqHod1WeAMrA+7ImIeVu41eYBMQb7Wp6xVvdK5NBviWLRhgeoCMVz
rD8hrJY8i+yab2Zxr4a/1O6+FQ01G2xMGiW1a+tMovXLsl4aPvZpKxf8unyv8Xz4
OGVvphNopl+4hniIMrlXJ1nOrjOeMa5pclTlKKr5f35Lpx4gAQqGBDeMA72UvIn8
oy5vqIhTFT16O+g7GhkQ52fQcz7r0i7pIzHQh0wsFdmEruFvO+8d7RyZD8un9HuK
Pp9UrWgVg7Xn9i60JmymXuLIdsJpPeVwBQetoOYhQTkFIjHV/sIcz/1idyfCowRM
g90V0xsuf6u4XkpPKj9byKe9Svohntt0olRHMF8SM/iwIGQ5WaJmWXV6AO7a8AtK
pjGYLIn3buadT2H6kMGxTIKQXiavHlkBLExaxJTtm6g6wt5rkvvlFtnVGlUwNAs3
7CnBLGBAYCEKZLcTCF3+ewe0XqEjC0Ssryo8EUWaIPwOZPFt+DjSOc8n11kesqww
kw0aXHYml/2DWb1jYq8E/zMB57m67snHn71aQCZVohUGjqzJY7k=
=3PnN
-----END PGP SIGNATURE-----

--vbmmIPuSwVEVy5R8tBe7xlmIW6XnQs0QP--

