Reply-To: s7r@...2137...
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
 <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
 <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>
From: s7r <s7r@...2137...>
Message-ID: <7ac51ab2-4c62-2bb4-f38b-664a25e3df12@...2137...>
Date: Sun, 29 Jul 2018 16:54:41 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k4ZElrhJi6n5Zft4HQkgRP1WLCyVAV4sj"
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
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
--k4ZElrhJi6n5Zft4HQkgRP1WLCyVAV4sj
Content-Type: multipart/mixed; boundary="fYXTNfM549NksTrib6ufJDYkCdR9B5aX7";
 protected-headers="v1"
From: s7r <s7r@...2137...>
Reply-To: s7r@...2137...
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <7ac51ab2-4c62-2bb4-f38b-664a25e3df12@...2137...>
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
 <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
 <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>
In-Reply-To: <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>

--fYXTNfM549NksTrib6ufJDYkCdR9B5aX7
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Selva Nair wrote:
>>
>> Hope this information is sufficient.
>=20
> Not really. Sounds like DNS resolution is changing with metric of the
> interface which very much points to a WIndows only behaviour.
>=20
> And, in that case whether a DNS server is set on the tun interface and
> which DNS server gets used when its "working" as expected and when its
> "not working" would be relevant. Also whether block-outside-dns is in
> use.
>=20

Thanks for the hint Selva. Indeed it looks like something DNS related.
The primary wired network interface has 1 IPv4-listening DNS server
(192.168.1.1, which uses 2 upstream IPv4-listening DNS server from the
ISP). The tun device has 2 IPv4 listening DNS servers (google) and 2
IPv6 listening DNS servers (google) pushed via dhcp-option DNS.

When it is "not working", the DNS server from the wired network
interface (192.168.1.1) is used. When it is "working", as when the
metric for the tun/tap adapter is changed to be lower than primary wired
network interface, google IPv6 listening DNS server is used.

I imagined that it is a problem because even if the IPv4 listening DNS
server from the wired network interface  is used, that should still be
able to deliver AAAA records for dual-stacked hostnames and then the
IPv6 route to be used for anything (ping,traceroute,whatever).



--fYXTNfM549NksTrib6ufJDYkCdR9B5aX7--

--k4ZElrhJi6n5Zft4HQkgRP1WLCyVAV4sj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEfDaSMlq9+wswIQPxg3+lLIEmWxEFAltdxyYACgkQg3+lLIEm
WxGaoggArroK0xWPCXt4+8SoPBuptJC67+NXIUpcwLT8J36AmYvmOIGcYUEeplX2
753i8/fP5Sr8TPbo2xemlBncE4Wf6+vYcZoYoee2XXSsBnyp+cydY3BbnKgbTkeZ
ndjf5HUVTliGQ1pE4bcYWVUXNKDhnbEtylOhJwV9bh7UtIk7kryC3JB3dwE2/wR4
zJEKoaTmOQsm2aAG0rDM1jvyFOn9WtOlNrsT5fkfZ0zgKukmcpfh1XkOzWi6hL+V
5kXgJlj5xo2rqkWcikMrbzQl61NaBUwknykTX7baM6BEzFg709S8J2huoGCjdTZZ
RvxvSB/XiDZjr2t3bSM7PoZN662sRg==
=CWz1
-----END PGP SIGNATURE-----

--k4ZElrhJi6n5Zft4HQkgRP1WLCyVAV4sj--

