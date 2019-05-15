References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
Date: Wed, 15 May 2019 19:32:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="O3ptvSazV74Q7QbuBXlyFrvAoW1N4SEVY"
Subject: Re: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, wireguard@...2500...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O3ptvSazV74Q7QbuBXlyFrvAoW1N4SEVY
Content-Type: multipart/mixed; boundary="cFAGVrySS71eMk0tZ1Lv7c67iYmZfD3xM";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 wireguard@...2500...
Message-ID: <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
Subject: Re: [Openvpn-devel] Wintun performance results
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
In-Reply-To: <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>

--cFAGVrySS71eMk0tZ1Lv7c67iYmZfD3xM
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/05/2019 16:49, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> it will most probably get lost in mailing list.
> can we add it to https://openvpn.net website ? something like "performance
> testing" with full configs provided ?

Good idea, but maybe not the official corp web pages just yet.  But we shou=
ld
definitely have some wiki pages under https://community.openvpn.net/ related
to how to prepare a good setup for performance testing.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


> =D1=81=D1=80, 15 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 18:49, Lev Stipak=
ov <lstipakov@...277...
> <mailto:lstipakov@...277...>>:
>=20
>     Hi guys,
>=20
>     I made openvpn3 (required changes will be incorporated into main bran=
ch at
>     some point) work with wintun and did performance testing in AWS.
>=20
>     Client:=C2=A0 =C2=A0 c5.xlarge, Windows Server 2016, patched openvpn3=
 test client
>     and OpenVPN Connect 2.7.1.103 (uses tap-windows6, based on openvpn3).
>=20
>     Server:=C2=A0 c5.xlarge, Ubuntu 18.04, openvpn 2.4.4
>=20
>     Client and server instances are in the same VPC and placement group.
>=20
>     iPerf3 running on server:
>=20
>     > iperf3 -s -B 0.0.0.0 -V
>=20
>     iPerf3 running on client:
>=20
>     > iperf3 -c 10.8.0.1 -V (server VPN address)
>     > iperf3 -c 10.0.0.18 -V (server VPC address)=C2=A0=C2=A0
>=20
>     Results:
>=20
>     - no vpn
>=20
>     [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Transfer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bandwidth
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A08.67 GBytes=C2=A0=C2=A07.45 Gbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
sender
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A08.67 GBytes=C2=A0=C2=A07.45 Gbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
receiver
>     CPU Utilization: local/sender 61.4% (5.6%u/55.8%s), remote/receiver 3=
3.9%
>     (1.7%u/32.2%s)
>=20
>     - tap-windows6
>=20
>     [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Transfer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bandwidth
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A0=C2=A0404 MBytes=C2=A0=C2=A0=C2=A0339 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0sender
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A0=C2=A0404 MBytes=C2=A0=C2=A0=C2=A0339 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0receiver
>     CPU Utilization: local/sender 4.6% (0.3%u/4.3%s), remote/receiver 21.=
4%
>     (2.2%u/19.2%s)
>=20
>     - wintun
>=20
>     [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Transfer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Bandwidth
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A0=C2=A0536 MBytes=C2=A0=C2=A0=C2=A0449 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0sender
>     [=C2=A0=C2=A04]=C2=A0=C2=A0=C2=A00.00-10.00=C2=A0=C2=A0sec=C2=A0=C2=
=A0=C2=A0536 MBytes=C2=A0=C2=A0=C2=A0449 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0receiver
>     CPU Utilization: local/sender 2.9% (0.1%u/2.8%s), remote/receiver 10.=
1%
>     (0.7%u/9.3%s)
>=20
>     As you see, wintun performs 30% better comparison to tap-windows6 and
>     incurs significantly less CPU usage.
>=20
>     --=20
>     -Lev


--cFAGVrySS71eMk0tZ1Lv7c67iYmZfD3xM--

--O3ptvSazV74Q7QbuBXlyFrvAoW1N4SEVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJc3E08AAoJEIbPlEyWcf3ykI4QAK2KumYR5jRlBMDn2FyNFSqC
Ch9uOdwRd3p0uuR+yyMt+ai+Mjob9JddRpDOtXeaE0QQIDMEpP8erwuJbohCrsFR
CIwMxdyEnkyPDhA/Jw975wjlh4imUvqUnwaP+qbRgoeN/uVJ/NJFFCcpVd9Z2ePe
xF8uY8i77s1Z/mlOuYSe+Q1tZN6eWyeVNB7vw0il4FvlEZVbA61CaJx2q9Q9fHjs
YSkt5Vv7SxAOvmJkYtUI8nO0A3wqfQwoO0F6GuL43u4Tcvcy6nCuRBr+0+KeKHfd
ZRdBnpw/XszCGQ2uSsP8o4YUfYnwyHe4XGkBQ/ckrvKoDg2mOZZhKWrmdGfrUqxB
ELWB5ulnZdZ0naexRRFtS2T+KjScrpNuH7fyd0IRh3ZksRhC1Aw1wjJubCo7rxed
c6FOyvT9J8+Oxa0lyKJKsH3bfLd7Ahl8Efo6piZuwmkazZuXB0z2WAkVH+wRlk2Z
RDoCZGxDFYwWWnVfx8cQ7PgxNPJU1XDdTok5hbLzMPgy4c8AA0lUHStPjlPg8iTT
GoJeLF1+YMuUYLehRA8u9AGTmCd5slqV6kGwUdXKPBrXI1RQxVGSjp2RXpWzyT/c
gcF6G8ts7O2Z0BhmIO7V8bAxn1Ns5xuSOxxT/cSFgDBRITnbvU9u9Mlp/YdZiwUT
4MaZf0UuHM6u/eqSqHZO
=83Fb
-----END PGP SIGNATURE-----

--O3ptvSazV74Q7QbuBXlyFrvAoW1N4SEVY--

