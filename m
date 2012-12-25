Message-ID: <50D9AA21.3040706@...1227...>
Date: Tue, 25 Dec 2012 14:29:05 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <50D6F4EA.6050504@...1227...>
	<20121225124856.GT22465@...1296...>
In-Reply-To: <20121225124856.GT22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE8E06A19D6A65135769CC72"
Subject: Re: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE8E06A19D6A65135769CC72
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 25.12.12 13:48, schrieb Gert Doering:
> Hi,
>
> On Sun, Dec 23, 2012 at 01:11:22PM +0100, Arne Schwabe wrote:
>> I fear we may have to delay the final release. While debugging a problem=
=20
>> with a user of my app I found a nasty bug which causes OpenVPN to crash=
=20
>> if two PUSH_CONTROL messages are received.
> The appended patch fixes this for me (Client on Linux/i386, but that=20
> should be OS and architecture agnostic).
>
ACK. Also works on Android/ARMv7a.

Arne


--------------enigAE8E06A19D6A65135769CC72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDZqicACgkQe8+cMNS4zRepewCgu4t0pDsxy0yDwKv6lVADzi6C
8JYAoIzVylDFwwGa+DUWqi76qCBPIPCJ
=ldnV
-----END PGP SIGNATURE-----

--------------enigAE8E06A19D6A65135769CC72--

