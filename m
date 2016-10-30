References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
From: ValdikSS <iam@...2070...>
Message-ID: <deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
Date: Sun, 30 Oct 2016 12:18:39 +0300
MIME-Version: 1.0
In-Reply-To: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qHaHpjwiwo3gQ4fCVaIIGo8VCwLjBcbUQ"
Subject: Re: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
	client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qHaHpjwiwo3gQ4fCVaIIGo8VCwLjBcbUQ
Content-Type: multipart/mixed; boundary="noKpMBKnP505lSqGAL5TcairNX8CBhhF2";
	protected-headers="v1"
From: ValdikSS <iam@...2070...>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
Subject: Re: dhcp-option DNS IPv6 server address for windows client
References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
In-Reply-To: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>

--noKpMBKnP505lSqGAL5TcairNX8CBhhF2
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

=85probably not only DHCPv6, but also Router Advertisement too. I doubt tha=
t DHCPv6 could be used without RA on Windows.


On 10/30/2016 12:55 AM, debbie10t wrote:
> Hi,
>
> currently, openvpn does not accept an IPv6 dhcp-option DNS server address.
>
> See:
> https://forums.openvpn.net/viewtopic.php?f=3D23&t=3D22705
>
> I also tested this on Win10 client and got the same error:
> Options error: dhcp-option parameter DNS '12fc:1918::10:8:0:101' must be=
=20
> an IP address
>
> So pushing this is ok but once pulled is rejected.
>
>  From IRC openvpn-devel:
>
> cron2 | there is no way to transmit IPv6 DNS information via IPv4 DHCP,=20
> and our current DHCP stuff is IPv4-DHCP
>
> cron2 | this is not an openvpn limitation but an IPv4 DHCP limitation -=20
> we would have to implement an IPv6 DHCP server, which we currently do=20
> not have
>
> dazo | slypknot: could you mail d12fk and selva regarding this and get=20
> their opinion? they're kind of driving the windows part=20
>
>
> Regards
>
> -------------------------------------------------------------------------=
-----
> The Command Line: Reinvented for Modern Developers
> Did the resurgence of CLI tooling catch you by surprise?
> Reconnect with the command line and become more productive.=20
> Learn the new .NET and ASP.NET CLI. Get your free copy!
> http://sdm.link/telerik



--noKpMBKnP505lSqGAL5TcairNX8CBhhF2--

--qHaHpjwiwo3gQ4fCVaIIGo8VCwLjBcbUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss, https://keybase.io/verify

iQIxBAEBCAAbBQJYFbryFBxpYW1AdmFsZGlrc3Mub3JnLnJ1AAoJEFzXIC7viPdy
NuoP/2iVYzfqUs3r51vRbzdxGXVYQONtOt6BcR+KZVRyKyWcckSWRbgBXVHRplSW
nlArvl4veexXxkC00hGWTTyzHVsMQaNHHk+CXrl5t7QiJn7MfYgRRvKt0dbOvco7
Hy/Cw4I/VsMZZaiX70fBnLIfsF7EID1gAY4wpezetW3+H3kdPt/BjX2fgHUVUHGQ
x+6tqR6Sgx6EjsQsRarhqakPWd/Q7SUGJzJll2uWSvW6gRImo5hPJsIb2dCEwZdS
A2c3rTC9ks8uU6IIcR/bV45s8439uDuHyoJl6ghpvHHtA5n9MWBqr0DybAL+/zoB
9u8xDAXGV3KemD9bHyDZnKRe3vZBfz8xlWbDImoS7PVu+ecPsBiy6WD9+jasOrh9
J1Uj1BrAlNw+K3DQuzzNKgsk2O7sARI8RG45GuO3CJg+I0eeqdas47rTS9m0hAXa
7ScVDaBmB6SAY3URqlgPs7kNLQ6fabkR631yvRjVre0K79nABGoJlXng+u9Yuzw6
xuBR6ugRPYCF+rOS77k/lLPew+NNh7Wjr/al2FXYvkWqmzV1lUf1NwiBHnaVX5MB
gLt/TjafeI2GD+padr9NieSRcBd+2AZkMbwrebJc8vECn6uWxU1k0BK2KfSyFUeP
foB/So1k/VFo1a+TroRsiZRwc2vg/jT1JuSBoL0qkPr8hzNn
=1Rvt
-----END PGP SIGNATURE-----

--qHaHpjwiwo3gQ4fCVaIIGo8VCwLjBcbUQ--

