Message-ID: <48818309.30109@...1085...>
Date: Sat, 19 Jul 2008 01:00:41 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <alpine.LNX.1.10.0807190603560.21295@...1117...>
In-Reply-To: <alpine.LNX.1.10.0807190603560.21295@...1117...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41065D4C03783E6AAE2EAE51"
Subject: [Openvpn-devel] Assertion failed at lzo.c:165
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41065D4C03783E6AAE2EAE51
Content-Type: multipart/mixed; boundary="------------050502020406090001070505"

This is a multi-part message in MIME format.
--------------050502020406090001070505
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

This message was based on a reply I made to the openvpn-users list with=20
some additional details of interest to developers.  I apologize for any=20
confusion cross-posting this might cause, but feel the analysis of this=20
from a development perspective didn't really belong in the users list.

The original poster reported this fatal error:
Assertion failed at lzo.c:165

Winfried Truemper wrote:
> OpenVPN 2.1_rc7 i686-pc-linux-gnu [SSL] [LZO2] [EPOLL] built on Jul  6 20=
08
For the purpose of identifying the line causing the problem I'm going to
assume this is an unpatched version of OpenVPN (or at least one that
doesn't change what line 165 is from the vanilla 2.1_rc7 codebase.)

> There is data corruption on the link over which OpenVPN operates.
> Is that the cause for the failed assertion? It exits from server mode the=
n.
The "Assertion failed at lzo.c:165" message indicates a condition during
the compression routine where the packet to compress is larger than the
maximum allowable payload size for the connection.  Normally this will
never occur, but you said that you are operating over a possibly
corrupted link. It's possible that the VPN peer is attempting to
compress a packet that is malformed and happens to exceed this limit.

Assuming I have read the source correctly, it seems to me that the=20
packet could be dropped (probably with an associated error to the log)=20
rather than using an ASSERT() call.  This way malformed data from=20
internal clients behind a VPN peer won't bring down the VPN.

--=20
Josh



--------------050502020406090001070505
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC45IChH
TlUvTGludXgpCgppRVlFQVJFQ0FBWUZBa2lCZ2ZzQUNna1FIU1NnSnk1YVVTZmsyZ0NmYldM
SGRZZXRmMkhiTmtkTFBzR21HcFJLCmxnRUFvSU9Ea2F6OHpGa0h6VWh0Q2M1RGo1bTlVWFlR
Cj1kckZpCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoK
--------------050502020406090001070505--

--------------enig41065D4C03783E6AAE2EAE51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiBgwoACgkQHSSgJy5aUSfzogCdHsBDYynf0nV9tYWzKr+Ve31k
a/gAnRQ4ZStZFNKxuOlSs3aOaFDpyoHs
=76A6
-----END PGP SIGNATURE-----

--------------enig41065D4C03783E6AAE2EAE51--


