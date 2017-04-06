References: <1527b3e1-ac4f-14c8-d804-846949c57a31@...277...>
	<CAFHpkQE6Hm-_dQTr78yWYDstFrzBi-vt2bwAgJ4ugk2dr89V5Q@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <afbe51a2-f17b-1222-45c1-0b0d7e6af83c@...2080...>
Date: Thu, 6 Apr 2017 17:22:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQE6Hm-_dQTr78yWYDstFrzBi-vt2bwAgJ4ugk2dr89V5Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HD5cR4RUd8suxEb0EgXi5rN2OTQ4HwA0i"
Subject: Re: [Openvpn-devel] Listen on multiple interfaces but not all
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Kor Korrd <kor.korrd+openvpn@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HD5cR4RUd8suxEb0EgXi5rN2OTQ4HwA0i
Content-Type: multipart/mixed; boundary="LXb1pK8ihIjW089rNsv0ntHVf1CjHhdD1";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	Kor Korrd <kor.korrd+openvpn@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <afbe51a2-f17b-1222-45c1-0b0d7e6af83c@...2080...>
Subject: Re: [Openvpn-devel] Listen on multiple interfaces but not all
References: <1527b3e1-ac4f-14c8-d804-846949c57a31@...277...>
	<CAFHpkQE6Hm-_dQTr78yWYDstFrzBi-vt2bwAgJ4ugk2dr89V5Q@...278...>
In-Reply-To: <CAFHpkQE6Hm-_dQTr78yWYDstFrzBi-vt2bwAgJ4ugk2dr89V5Q@...278...>

--LXb1pK8ihIjW089rNsv0ntHVf1CjHhdD1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 06/04/17 17:11, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Usually, you can bind to certain interface and forward packets by
> firewall from other interfaces
>=20
> 6 =D0=B0=D0=BF=D1=80. 2017 =D0=B3. 19:41 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Kor Korrd"
> <kor.korrd+openvpn@...277... <mailto:kor.korrd%2Bopenvpn@...277...>>
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>=20
>     Hi,
>=20
>     is it possible for the Server part to listen on more than one specific
>     interface but not on all interfaces?

No.  Currently that is not possible in OpenVPN.  Some of the core
developers are looking into resolving this, but it has turned out to be
quite hard to resolve and fix properly.  So this is still being worked
on, but we have no ETA for this.

What most users do is to listen to all interfaces and only open up the
port in the firewalling.  Some have chosen a different path using NAT to
forward packets from one IP/interface to the one OpenVPN is listening
too.  But some have needed to also add --multihome in the OpenVPN to
make this work.

For most of our OpenVPN users, only open up the OpenVPN port on specific
interfaces/IP addresses in the firewall is more than good enough from a
security perspective, and really simple to achieve without too much
troubles.  But YMMV.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--LXb1pK8ihIjW089rNsv0ntHVf1CjHhdD1--

--HD5cR4RUd8suxEb0EgXi5rN2OTQ4HwA0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5l1RAAoJEIbPlEyWcf3yUHYQALICflopAeGxHs9fyfMVEwvT
SodWqRVVGBRJrordE8nrCofqwPFw9vloDD+67tF6zdM8p9GDarKix4x1viZlO0Tg
ZPpmDpke5fws89EF68dRKv4WUQMNbhZGYOLMYQ20UDEOApjDLei6j4EWlDfiTp2r
VVaqmkEygITkcCh/n2532tt0Rm71zL00/3zCG80D36XdW3IBja+P8ddtWYKlHJU5
apsAEhlxLvgPu1EcUDX3BJCNmnEf1scnY0mQTti6MrE630hhNOM8BusogCDlcdGT
XYvx+PhvZ17smHXDNwVdFs3ZYqijurYn07fce83hQtnEZNZJEg75dOmO49byHKcC
tB6KXRO2F3h8DAkl8XlRs61lLM3rL8fs5F2BfLDuoMxHHlkxM07jtdKL67WNV1Y2
3KejTlDKSTHccO9a/1dVkughU/3WDuNMUUZF0Vi4u7UGdu0hsUZG6Ouf6iFj6lpl
gsF9/H7nv0JRjDw5picabrWXyWblxQ0/GER2gRkkQk+RDt6MGTUn5Q1Z7nHnUJIK
uLfmEfCTzJrt8pMzVnSqJFY2SMtEnoWnlL9MNoCS2WR+HTiU88mhsTJghL4+bWj9
bHnKKmWdbhmMJVcg0aikSd7bjeD+3AjxM/B7oErZz8lkF1xD5xQY/ybiylgwwayw
v/9xIsYEifm+XQZI3mP8
=Y9vb
-----END PGP SIGNATURE-----

--HD5cR4RUd8suxEb0EgXi5rN2OTQ4HwA0i--

