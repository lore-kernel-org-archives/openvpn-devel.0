Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
Date: Tue, 22 May 2018 21:10:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="F2urCrmFKBMeYTXaXYlFa8BGG1frcIsCc"
Subject: Re: [Openvpn-devel] Minimum Linux Version for OpenVPN 2.4.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin <volleynbike@...277...>, "<openvpn-devel@lists.sourceforge.net>" <Openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F2urCrmFKBMeYTXaXYlFa8BGG1frcIsCc
Content-Type: multipart/mixed; boundary="1ODMzyvzp1ASlDypEHUYkmA2Dsji1UWtN";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Marvin <volleynbike@...277...>,
 "<openvpn-devel@lists.sourceforge.net>" <Openvpn-devel@lists.sourceforge.net>
Message-ID: <d42dfd0b-8309-2409-0a21-aa97c8a3b651@...2080...>
Subject: Re: [Openvpn-devel] Minimum Linux Version for OpenVPN 2.4.x
References: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>
In-Reply-To: <CAAF3xa85gmN5GEjguVA6cpUPFZuSOKP39g1FKf1hYfmyoo9X5w@...278...>

--1ODMzyvzp1ASlDypEHUYkmA2Dsji1UWtN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/05/18 19:32, Marvin wrote:
> Can someone tell me the minimum Linux version that OpenVPN 2.4.x will bui=
ld
> and run on?=C2=A0 We have an older appliance the runs on an older 2.4.31 =
kernel
> (cannot be upgraded -- but it's very hardened so really doesn't need to b=
e for
> our use.)

First of all, kernel 2.4.31 is very old - hardened or not.  I might work if
you don't attempt any IPv6 features at all.  But I do know there has been s=
ome
code changes over the years which is strictly 2.6 kernel and newer; but its
quite a long time ago so I don't recall exactly what and when.

IIRC, since OpenVPN 2.2, we have had RHEL 5 as the oldest supported Linux
distribution, which was based on kernel 2.6.18.  With OpenVPN 2.4, that mov=
ed
up to RHEL 6 (kernel 2.6.32 baseline).


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--1ODMzyvzp1ASlDypEHUYkmA2Dsji1UWtN--

--F2urCrmFKBMeYTXaXYlFa8BGG1frcIsCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbBGscAAoJEIbPlEyWcf3yCqwQAMMmcvQ/gMGPKtICgltEUfck
uyL9cji8eak+86oloVXiHoqumH0BhWoEx+KMwCk4z+pBAmVozQB+F+NOd8iDUaFZ
jF8aggUosggX92EVgrJKcMEyX4VUoSozD7AU7ylp9JFH+RyWaxDJkYaw3pXMPDKJ
HfKGIgraYuQ/17WnQLE/trbr4Vl8fiYi/VTjEXTlk6tXQswzRuQyzfCVmcdYhbBH
cLM6wQktnS3foxjMgT72+QCr5GYsTcXOkriR5p7XCqG9P0rDFLQZWyrYeRcVYNG9
OfXMtfkwJ0/RoWTNuNOB/CS4mP675W1uwZmCC8TklKROkwRSVpQZPiLb8K3uJS8P
8cUYKO3U5an4qhKkTkDYchY6eNiZlkpfOBAzczdyoD+hjPHOPb2GM/LezW9DY9eg
c8r/5MHY4SYUoRY2OaGfCcVfrKDPFUIRRfEu5yeRRM9GB+PQQXHKursaQDc8cZR4
pxBH7CivYKIQ513yUsnkRH+VFUnZhGSAGQrroQwxBWTywlAxNqYMTnTy1r8ODLuT
ANuCpCcQ1l3Uyku/iI9WU0FecjZo7RhW8eWqE2oQ8gMExSwQaLAF4PUSfGXMKBBh
24SFsQ/geQhsP5v1K45+I46nNlF90YadbG0ESa//Bpbj7eUnyQxaqaWbdhQi1qHt
MLFW+08/z1JTyl2QRgJt
=Ji9h
-----END PGP SIGNATURE-----

--F2urCrmFKBMeYTXaXYlFa8BGG1frcIsCc--

