Date: Thu, 10 Nov 2011 20:19:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111110191943.GS8496@...1296...>
References: <20111110182004.GR8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fxri3eXrEZPyNeTU"
Content-Disposition: inline
In-Reply-To: <20111110182004.GR8496@...1296...>
Subject: Re: [Openvpn-devel] patch to windows tap driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--fxri3eXrEZPyNeTU
Content-Type: multipart/mixed; boundary="F8R9OcEdaIlHLWng"
Content-Disposition: inline

--F8R9OcEdaIlHLWng
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as per David's request, a properly git-format-patch formatted patch
attached below.

(The bug and fix are *so* obvious if you know where to look)

gert

On Thu, Nov 10, 2011 at 07:20:04PM +0100, Gert Doering wrote:
> Hi,
>=20
> I received a bugfix for my IPv6 patch to the Windows TAP driver today,
> which affects IPv4 - and there is this open bug with small-size IPv4
> packets in our trac, which this should fix...
>=20
> The problem is a missing "break" statement at the end of the IPv6=20
> block, which now leads to "fall into IPv6 block" and that one has a
> larger minimum packet size...
>=20
> ACK from me - David, could you please integrate the one-line patch,
> and then we need James to compile + sign a new driver  (and I think
> this warrants a 2.2 bugfix release).
>=20
> [I'm not on IRC these days as I'm technically on vacation, but I saw
> this mail today and it warrants action]
>=20
> gert
>=20
>=20
> ----- Forwarded message from Christian Niessner <bug-report@...1523...> -=
----
>=20
>=20
> @@ -1611,6 +1766,27 @@ AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
>=20=20
>             // Packet looks like IPv4, queue it.
>             l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
> +
> +         case ETH_P_IPV6:
> +           // make sure that packet is large
> +           // enough to be IPv6
> +           if (l_PacketLength
> +               < ETHERNET_HEADER_SIZE + IPV6_HEADER_SIZE)
> +             goto no_queue;
> +
>=20
> [..]
>=20
> --- ../tap-win32-latest/tapdrvr.c       2011-11-09 17:12:19.000000000 +01=
00
> +++ tapdrvr.c   2011-11-10 09:24:24.000000000 +0100
> @@ -1766,6 +1766,7 @@
>=20=20
>             // Packet looks like IPv4, queue it.
>             l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
> +           break;
>=20=20
>           case ETH_P_IPV6:
>             // make sure that packet is large
>=20
>=20
> ----- End forwarded message -----
>=20
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~=
gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...



> -------------------------------------------------------------------------=
-----
> RSA(R) Conference 2012
> Save $700 by Nov 18
> Register now
> http://p.sf.net/sfu/rsa-sfdev2dev1
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--F8R9OcEdaIlHLWng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-add-missing-break-between-case-IPv4-and-case-IPv6-le.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 3e3f3b57e06f1c4d116c006c81494418c79901cb Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 10 Nov 2011 20:15:44 +0100
Subject: [PATCH] add missing break between "case IPv4" and "case IPv6", lea=
ding to
 the minimum-size for IPv6 being applied to IPv4 packets, subsequently
 leading to drop of small-sized IPv4 packets.

Bug found & fixed by Christian Niessner.

Signed-off-by: Christian Niessner <bug-report@...1523...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
---
 tap-win32/tapdrvr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tap-win32/tapdrvr.c b/tap-win32/tapdrvr.c
index 7ab3916..e5760dc 100755
--- a/tap-win32/tapdrvr.c
+++ b/tap-win32/tapdrvr.c
@@ -1766,6 +1766,7 @@ AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
=20
 	    // Packet looks like IPv4, queue it.
 	    l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
+	    break;
=20
 	  case ETH_P_IPV6:
 	    // make sure that packet is large
--=20
1.7.3.4


--F8R9OcEdaIlHLWng--

--fxri3eXrEZPyNeTU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTrwjz6kuBuNlUUl1AQJQbAP9GH57GzD4YnCmrh4jGv1mHHBj632pEoGD
h9FOa8eFgGyjM+cRMKgVO2kkJXDX4jjrxZcqVZlpc1RoL5I6OKSX/36tlB6YN/0a
M9XHisb9iyPEmtCg1KJkVEjI+EswMGgFDzvwXgXs8h+IDXvL5mOhY40B/gz1b5ge
F/vE1Wfvtpw=
=U65M
-----END PGP SIGNATURE-----

--fxri3eXrEZPyNeTU--

