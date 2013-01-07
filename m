From: Eric Crist <ecrist@...1286...>
Message-Id: <00D1D856-A942-490E-957C-1BBD71ADE4B6@...1286...>
Date: Mon, 7 Jan 2013 14:30:01 -0600
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: [Openvpn-devel] Correct Man Page: client-to-client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is something I've been meaning to address for quite some time, since t=
he documentation is very, very wrong.  I'm not very good at reading the cod=
e (yet), so please correct me if I'm wrong.  This update is based on behavi=
or I've seen and not as much on my ability to read our source.

The human-readable difference:

=3D=3D=3D OLD =3D=3D=3D
Because the OpenVPN server mode handles mutliple clients
through a single tun or tap interface, it is effectively
a router.  The --client-to-client flag tells OpenVPN
to internally route client-to-client traffic rather than
pushing all client-originating traffic to the TUN/TAP interface.

When this options is used, each client with "see" the other=20
clients which are currently connected.  Otherwise, each client
will only see the server.  Don't use this option if you want
to firewall tunnel traffic using custom, per-client rules.

=3D=3D=3D NEW =3D=3D=3D
Because the OpenVPN server mode handles mutliple clients
through a single tun or tap interface, it is effectively
a router.  The --client-to-client flag tells OpenVPN
to allow traffic between clients connected to the VPN.  This
also exposes the traffic between client to the TUN/TAP
interface, allow for firewalling on a per-client basis.

When this options is used, each client with "see" the other=20
clients which are currently connected.




diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2ed5201..009aeda 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2987,15 +2987,13 @@ Because the OpenVPN server mode handles multiple cl=
ients
 through a single tun or tap interface, it is effectively
 a router.  The
 .B \-\-client-to-client
-flag tells OpenVPN to internally route client-to-client
-traffic rather than pushing all client-originating traffic
-to the TUN/TAP interface.
+flag tells OpenVPN to allow traffic between clients
+connected to the VPN.  This also exposes the traffic between
+clients to the TUN/TAP inteface, allowing for firewalling
+on a per-client basis.
=20
 When this option is used, each client will "see" the other
-clients which are currently connected.  Otherwise, each
-client will only see the server.  Don't use this option
-if you want to firewall tunnel traffic using
-custom, per-client rules.
+clients which are currently connected.=20=20
 .\"*********************************************************
 .TP
 .B \-\-duplicate-cn



-----
Eric F Crist




