From: Arne Schwabe <arne@...1227...>
Date: Tue, 30 Apr 2013 22:33:17 +0200
Message-Id: <1367353997-6669-1-git-send-email-arne@...1227...>
In-Reply-To: <1367006045-13576-1-git-send-email-arne@...1227...>
References: <1367006045-13576-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v5 5/5] Document the Android implementation
	in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Also fix a minor mistake in the manpage.
---
 doc/android.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 doc/openvpn.8   |    1 +
 2 files changed, 42 insertions(+)
 create mode 100644 doc/android.txt

diff --git a/doc/android.txt b/doc/android.txt
new file mode 100644
index 0000000..fe97027
--- /dev/null
+++ b/doc/android.txt
@@ -0,0 +1,41 @@
+This file documents the support of OpenVPN in Android 4.0 and up. This support is primarily used in the "OpenVPN for Android" app (http://code.google.com/p/ics-openvpn/). For building see the developer README: http://code.google.com/p/ics-openvpn/source/browse/README.txt. 
+
+Android provides the VPNService API (http://developer.android.com/reference/android/net/VpnService.html) which allows establishing VPN connections without routing the device.
+
+Since all the interfaces are are Android specific the calls to this interface are made from the UI instead of OpenVPN directly. The API needs the following parameters:
+
+- IP and netmask of tun interface 
+- Networks that should be routed to the tun interface
+- DNS Servers and DNS Domain
+- MTU
+
+All IPs/Routes are in CIDR style. Non CIDR routes are not supported. Notable is the lack of support for setting routes to other interfaces usually used to avoid the server connection going over the tun interface. The Android VPNService API has the concept of protecting a socket from being routed over a interface. Calling protect (fd) will internally bind the socket to the interface used for the external connection (usually WiFi or mobile data).
+
+To use OpenVPN with the VPNService API OpenVPN must be build with the TARGET_ANDROID compile option. Also the UI must use a UNIX domain socket to connect to OpenVPN. When compiled as TARGET_ANDROID OpenVPN will use management callbacks instead of executing traditional ifconfig/route commands use the need-ok callback mechanism which will ask 
+
+> NEED-OK command
+
+where command can be:
+
+IFCONFIG6 IPv6/netmask
+IFCONFIG local remoteOrNetmask MTU topology
+
+To tell the UI which IPs addresses OpenVPN expects on the interface. Topology is one of "net30","p2p","subnet" or "undef".
+
+ROUTE6 network/netmask
+ROUTE network netmask
+
+To tell the UI which routes should be set on the tun interface.
+
+DNSSERVER serverip
+DNSDOMAIN searchdomain
+
+To set the DNS server and search domain.
+
+The GUI will then respond with a "needok 'command' ok' or "needok 'command' cancel', e.g. "needok 'IFCONFIG' ok".
+
+To protect a socket the OpenVPN will send a PROTECTFD to the UI. When sending the PROTECTFD command command to the UI it will send the fd of the socket as ancillary message over the UNIX socket. The UI will then call protect(fd) on the received socket protecting it from being routed over the VPN.
+
+When opening a tun device the OpenVPN process will first send all route, ifconfig and DNS related configuration to the UI and after that calls the OPENTUN command to receive a tun fd with the requested configuration. The UI will than use the collected information to call the VPNService's establish() method to receive a fd which in turn is send to the OpenVPN process as ancillary message to the "needok 'OPENTUN' ok' response.
+
+The OpenVPN for Android UI extensively uses other features that are not specific to Android but are rarely used on other platform. For example using SIGUSR1 and management-hold to restart, pause, continue the VPN on network changes or the external key management --management-external-key option and inline files.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d590714..cbfc107 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2487,6 +2487,7 @@ Allow management interface to override
 .B \-\-remote
 directives (client-only).
 .\"*********************************************************
+.TP
 .B \-\-management-external-key
 Allows usage for external private key file instead of
 .B \-\-key
-- 
1.7.9.5


