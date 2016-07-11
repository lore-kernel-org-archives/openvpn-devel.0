From: Arne Schwabe <arne@...1227...>
Date: Mon, 11 Jul 2016 16:50:59 +0200
Message-Id: <1468248659-27123-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Update android documentation to match
	source code
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

---
 doc/android.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/android.txt b/doc/android.txt
index 137edfc..3a096dd 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -2,7 +2,7 @@ This file documents the support in OpenVPN for Android 4.0 and up.
 
 This support is primarily used in the "OpenVPN for Android" app
 (http://code.google.com/p/ics-openvpn/). For building see the developer
-README: http://code.google.com/p/ics-openvpn/source/browse/doc/README.txt.
+README: https://github.com/schwabe/ics-openvpn/blob/master/doc/README.txt
 
 Android provides the VPNService API
 (http://developer.android.com/reference/android/net/VpnService.html)
@@ -89,3 +89,12 @@ are not specific to Android but are rarely used on other platform.
 For example using SIGUSR1 and management-hold to restart, pause,
 continue the VPN on network changes or the external key management
 --management-external-key option and inline files.
+
+To better support handover between networks, a the management command
+
+network-change [samenetwork]
+
+is used on the Android platform. It tells OpenVPN to do the necessary
+action when the network changes. Currently this is just calling
+the protect callback when using peer-id regardless of the samenetwork.
+Without peer-id OpenVPN will generate USR1 when samenetwork is not set.
-- 
2.7.4 (Apple Git-66)


