Message-ID: <53D803BE.1040500@...1926...>
Date: Tue, 29 Jul 2014 22:27:42 +0200
From: Julien Muchembled <jm@...1926...>
MIME-Version: 1.0
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
In-Reply-To: <20140729185713.GX1118@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MPSOJxF1xDEu1hAKrx2vC5mjedhKN4h5b"
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MPSOJxF1xDEu1hAKrx2vC5mjedhKN4h5b
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Le 07/29/14 20:57, Gert Doering a =E9crit :
> On Tue, Jul 29, 2014 at 07:28:49PM +0200, Julien Muchembled wrote:
>> Socket configuration of MTU discovery was done unconditionally at IP lev=
el,
>> which has no effect for other protocols. This fixes the issue of OpenVPN
>> sending fragmented tcp6/udp6 packets even when 'mtu-disc yes' option is =
passed.
>=20
> Sounds good.  I'm not sure I understand what that socket option *does*,
> though...  will it make the kernel report back any ICMP packet too big
> messages received?  Or will it not honour those unless IPV6_MTU_DISCOVER
> is set?
>=20
> Is there documentation for that socket option somewhere?

'man 7 ip' and 'man 7 ipv6'

For example:
  A --[mtu=3D1500]-- B --[mtu=3D1400]-- C

Given a UDP6 socket on A with IPV6_MTU_DISCOVER=3DIP_PMTUDISC_DO,
    sendto(1452 bytes, B) will succeed
but sendto(1452 bytes, C) will return EMSGSIZE (except for the first send t=
o C)

Yes, at some point, there are icmp packets.

> (Last not least, because I'm too lazy to look: is that patch against
> git master or against release/2.3?)

master


--MPSOJxF1xDEu1hAKrx2vC5mjedhKN4h5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJT2APDAAoJEEwjvlkacWMkwIIQAJl0xIFXPsSQLEyuhlv7LU4K
EDyguHMbhq6FMgBlqU1hmGCpJ7cQM+HTYWaOI4/JBrwQtfBnJHIXwZMIwRg3d0A5
YH/5pkxGsYfLcvxyeYDDdrlpLQBrVZeK33zLhsRpyzg6H9NmZ0GBuyI091cw82KG
CRI8z1m1abpsAYRxu81RlyrVtRVGIB4EMEcWNkehPab2i6L12O26riRGNG724o3k
A3KCqENXJrLdnqiQYHBzhwIKMzQuhWs85VhC/R2//F8HzPnoechcgAGsfw/kkziF
SYz2INQW18a9GwK007jwq5e0BCEwE96r/AanKtPQj2Xzz1yU8iM39kWxZ6EzOHRn
fjmAnkBpVpjXyr46JiaSvEYeXGIg0suKTwbjnY4SryJsTnCZ1pcPPiOLkVVWg0UU
RKStrSkM4V/6cn+QmmrR+Wb1/HdbvHpKbqNK/Uig5fs2N/BEuQ5ooZtHm49nRWQF
BZLCVWoNXtNW8fHd9fyelZEBf1Je4LZmHGc70hgHEF/FovIau9kMKn9KWXL52LUj
uNJD62Nu870wHM88YMWRWu7ungWqQ9ny2nssBLIjmizyoUc+eU0BotKa5sz6kOzg
/qDqNdeK8Lh9O2bxoglRjwwG9BiI0DJ70IO69jKWELmFNzkpNj+ereH40PLZVOBY
zcUk8Xaho83+c0Stvbe5
=shji
-----END PGP SIGNATURE-----

--MPSOJxF1xDEu1hAKrx2vC5mjedhKN4h5b--

