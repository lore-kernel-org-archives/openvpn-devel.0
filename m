From: s7r <s7r@...2137...>
Message-ID: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
Date: Fri, 27 Jul 2018 17:57:14 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Oo5RtCiDCeZGXlDJPj0AOQTYpzvAZ5CFW"
Subject: [Openvpn-devel] Set interface metric instead letting it on auto (OS
 choice) when we have redirect-gateway present to enforce the desired effect
 for IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oo5RtCiDCeZGXlDJPj0AOQTYpzvAZ5CFW
Content-Type: multipart/mixed; boundary="530BNMNy8avaEt4fM7sqJR7X4clvwnSar";
 protected-headers="v1"
From: s7r <s7r@...2137...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
Subject: Set interface metric instead letting it on auto (OS choice) when we
 have redirect-gateway present to enforce the desired effect for IPv6

--530BNMNy8avaEt4fM7sqJR7X4clvwnSar
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have run into a problem which raised my attention. I am not sure if I
can call this a bug, but I think it's best to discuss here and decide if
it should be addressed in OpenVPN or let it as it is at operating system
layer.

I am connecting to a VPN server that assigns:
- one public IPv4 address;
- one public IPv6 /64 subnet;

It is aimed to redirect all client's internet traffic for internet
destinations for both IPv4 and IPv6 so all required parameters for this
purpose are present (redirect-gateway def1, redirect-gateway ipv6,
route-ipv6 ::/0).

The client has only IPv4 internet connectivity, the VPN server is
listening only on IPV4 as well, so both sides of the tunnel are always IPv4.

When the client connects to the VPN using a Wi-Fi default internet
connection, it works as expected. Client's IPv4 traffic and IPv6 traffic
goes through the VPN for all internet destination, and as expected IPv6
has priority for dual-stacked destinations in the internet.

When the same client with the same environment / setup connects to the
same VPN but using a wired network connection (1gbps), the traffic is
routed via the VPN for IPv4 but IPv6 is not preferred for dual-stacked
destinations. The IPv6 default route is present, but somehow not used
automatically for dual-stacked destinations on the internet. It only
works if raw IPv6 addresses are stated (excluded DNS hostnames) like $
ping -6 <raw_IPv6_address>.

Solution was to set interface metric for the TAP adapter for both
TCP/IPv4 and TCP/IPv6 to 15, which is lower than what the wired ethernet
interface had (25), and then it worked as expected, IPv6 from the tunnel
was preferred for dual-stacked destinations on the internet.

The question here is if it makes sense to also set the interface metric
for both TCP/IPv4 and TCP/IPv6 to the lowest value (for example 1) when
redirect-gateway def1 / redirect-gateway ipv6 are present (or pushed) in
client config, since if these are present it is obvious what is the
desired effect for the client.


--530BNMNy8avaEt4fM7sqJR7X4clvwnSar--

--Oo5RtCiDCeZGXlDJPj0AOQTYpzvAZ5CFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEfDaSMlq9+wswIQPxg3+lLIEmWxEFAltbMtAACgkQg3+lLIEm
WxEpgQgAw1Wqw2xwBII8EFjc4qEuhdFR77qm1KrmrVQOkwgP/MchrYliVh1oOfai
Q/hbFEH1FxcvXc8LSn2qHdNZWNS33Vj6HvfEqg+RBZW/1fovtv5/cIsbDrlCRiRB
ZQhAF/bQcIPkIWtoFEZy9mBzfkdtKesMzofyHbDrke61a0n4uGuMo2fmYZ6kI5HD
5bbvjDotkK6Ih3LqwdMXwI4UFfyfO7zTvZbc3byAlTy2kINzcl3zqGFgqD3HybE8
Fllca51YzBHb0zzWea4EGjgXCmGlbzGtQi98gE3h+LrDTrnT4HBwZ9oWXy34fS3N
PUJUA6z2ApWFmEBkwOyIoipEuuSD+g==
=x6RR
-----END PGP SIGNATURE-----

--Oo5RtCiDCeZGXlDJPj0AOQTYpzvAZ5CFW--

