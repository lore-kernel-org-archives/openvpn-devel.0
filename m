Date: Thu, 10 Nov 2011 19:20:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111110182004.GR8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kf7Emwp3eNAROHJg"
Content-Disposition: inline
Subject: [Openvpn-devel] patch to windows tap driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Kf7Emwp3eNAROHJg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I received a bugfix for my IPv6 patch to the Windows TAP driver today,
which affects IPv4 - and there is this open bug with small-size IPv4
packets in our trac, which this should fix...

The problem is a missing "break" statement at the end of the IPv6=20
block, which now leads to "fall into IPv6 block" and that one has a
larger minimum packet size...

ACK from me - David, could you please integrate the one-line patch,
and then we need James to compile + sign a new driver  (and I think
this warrants a 2.2 bugfix release).

[I'm not on IRC these days as I'm technically on vacation, but I saw
this mail today and it warrants action]

gert


----- Forwarded message from Christian Niessner <bug-report@...1523...> ---=
--


@@ -1611,6 +1766,27 @@ AdapterTransmit (IN NDIS_HANDLE p_AdapterContext,
=20
            // Packet looks like IPv4, queue it.
            l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
+
+         case ETH_P_IPV6:
+           // make sure that packet is large
+           // enough to be IPv6
+           if (l_PacketLength
+               < ETHERNET_HEADER_SIZE + IPV6_HEADER_SIZE)
+             goto no_queue;
+

[..]

--- ../tap-win32-latest/tapdrvr.c       2011-11-09 17:12:19.000000000 +0100
+++ tapdrvr.c   2011-11-10 09:24:24.000000000 +0100
@@ -1766,6 +1766,7 @@
=20
            // Packet looks like IPv4, queue it.
            l_PacketBuffer->m_SizeFlags |=3D TP_TUN;
+           break;
=20
          case ETH_P_IPV6:
            // make sure that packet is large


----- End forwarded message -----

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Kf7Emwp3eNAROHJg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTrwV06kuBuNlUUl1AQLatgP/Tpsc3vxD2nHTXk4THPbh0848H03HvApQ
duQm+zQctRBZq1jQWu8td6BJzlxYKzXnMEMza3YfM9SDstz8LgA8Cu5tJLX/umeC
ThL6mXZJWfzkHPxYTi1EnNBz5YFFdlsGjSA2uk7S3ZflRz/4jGZU0KKpU4riML6U
TfMMzPwvmDk=
=CXNN
-----END PGP SIGNATURE-----

--Kf7Emwp3eNAROHJg--

