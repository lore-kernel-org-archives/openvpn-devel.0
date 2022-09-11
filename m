From: Arne Schwabe <arne@...1227...>
Date: Sun, 11 Sep 2022 16:48:34 +0200
Message-Id: <20220911144834.2220049-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update android.txt to reflect more recent
 changes.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/android.txt | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/doc/android.txt b/doc/android.txt
index e287be0a8..e143e3342 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -1,4 +1,6 @@
-This file documents the support in OpenVPN for Android 4.0 and up.
+This file documents the support in OpenVPN for Android using the
+VPNService API (https://developer.android.com/reference/android/net/VpnService)
+that has been introduced in Android 4.0 (API 14).
 
 This support is primarily used in the "OpenVPN for Android" app
 (https://github.com/schwabe/ics-openvpn). For building see the developer
@@ -8,26 +10,26 @@ Android provides the VPNService API
 (http://developer.android.com/reference/android/net/VpnService.html)
 which allows establishing VPN connections without rooting the device.
 
-Since all the interfaces are are Android specific the calls to this
-interface are made from the UI instead of OpenVPN directly. The API
-needs the following parameters:
+Unlike on other platform, the tun device is openend by UI instead of
+OpenVPN itself.  The VpnService API needs the following parameters:
 
 - IP and netmask of tun interface
 - Networks that should be routed to the tun interface
 - DNS Servers and DNS Domain
 - MTU
 
-All IPs/Routes are in CIDR style. Non CIDR routes are not supported.
+All IPs/Routes are in CIDR style.  Non-CIDR routes are not supported.
 Notable is the lack of support for setting routes to other interfaces
 usually used to avoid the server connection going over the tun
-interface. The Android VPNService API has the concept of protecting
-a socket from being routed over a interface. Calling protect (fd)
-will internally bind the socket to the interface used for the
+interface.  However, Android 13 adds support for exclusion routes that
+serve the same purpose.  The Android VPNService API has the concept
+of protecting a socket from being routed over a interface. Calling
+protect (fd) will internally bind the socket to the interface used for the
 external connection (usually WiFi or mobile data).
 
 To use OpenVPN with the VPNService API OpenVPN must be build with
-the TARGET_ANDROID compile option. Also the UI must use a UNIX
-domain socket to connect to OpenVPN. When compiled as TARGET_ANDROID
+the TARGET_ANDROID compile option.  Also the UI must use a UNIX
+domain socket to connect to OpenVPN.  When compiled as TARGET_ANDROID
 OpenVPN will use management callbacks instead of executing traditional
 ifconfig/route commands use the need-ok callback mechanism which
 will ask
@@ -58,18 +60,16 @@ The GUI will then respond with a "needok 'command' ok' or "needok
 
 PERSIST_TUN_ACTION
 
-In Android 4.4-4.4.2 a bug exists that does not allow to open a new tun fd
-while a tun fd is still open. When OpenVPN wants to open an fd it will do
-this query. The UI should compare the last configuration of
-the tun device with the current tun configuration and reply with either (or
-always respond with OPEN_AFTER_BEFORE/OPEN_BEFORE_CLOSE)
+When OpenVPN wants to open an fd it will do this query via management.
+The UI should compare the last configuration of the tun device with the current
+tun configuration and reply with either NOACTION (or always respond with
+OPEN_BEFORE_CLOSE).
 
 - NOACTION: Keep using the old fd
-- OPEN_AFTER_CLOSE: First close the old fd and then open a new to workaround the bug
 - OPEN_BEFORE_CLOSE: the normal behaviour when the VPN configuration changed
 
 For example the UI could respond with
-needok 'PERSIST_TUN_ACTION' OPEN_AFTER_CLOSE
+needok 'PERSIST_TUN_ACTION' OPEN_BEFORE_CLOSE
 
 To protect a socket the OpenVPN will send a PROTECTFD to the UI.
 When sending the PROTECTFD command command to the UI it will send
@@ -80,7 +80,7 @@ it from being routed over the VPN.
 When opening a tun device the OpenVPN process will first send all
 route, ifconfig and DNS related configuration to the UI and after
 that calls the OPENTUN command to receive a tun fd with the requested
-configuration. The UI will than use the collected information to
+configuration.  The UI will than use the collected information to
 call the VPNService's establish() method to receive a fd which in
 turn is send to the OpenVPN process as ancillary message to the
 "needok 'OPENTUN' ok' response.
@@ -95,7 +95,7 @@ To better support handover between networks, a the management command
 
 network-change [samenetwork]
 
-is used on the Android platform. It tells OpenVPN to do the necessary
-action when the network changes. Currently this is just calling
+is used on the Android platform.  It tells OpenVPN to do the necessary
+action when the network changes.  Currently this is just calling
 the protect callback when using peer-id regardless of the samenetwork.
 Without peer-id OpenVPN will generate USR1 when samenetwork is not set.
-- 
2.32.1 (Apple Git-133)


