From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Oct 2014 22:04:00 +0200
Message-Id: <1412712240-3333-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Add documentation for PERSIST_TUN_ACTION
	(Android specific)
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
index 871e399..cf8b3c7 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -2,7 +2,7 @@ This file documents the support in OpenVPN for Android 4.0 and up.
 
 This support is primarily used in the "OpenVPN for Android" app
 (http://code.google.com/p/ics-openvpn/). For building see the developer
-README: http://code.google.com/p/ics-openvpn/source/browse/README.txt.
+README: http://code.google.com/p/ics-openvpn/source/browse/doc/README.txt.
 
 Android provides the VPNService API
 (http://developer.android.com/reference/android/net/VpnService.html)
@@ -74,3 +74,12 @@ are not specific to Android but are rarely used on other platform.
 For example using SIGUSR1 and management-hold to restart, pause,
 continue the VPN on network changes or the external key management
 --management-external-key option and inline files.
+
+Due to a bug in Android 4.4-4.4.2 there the Android Control will also
+query what action the daemon should take when opening the fd. The GUI
+should compare the last configuration of the tun device with the current
+tun configuration and reply with either
+
+- NOACTION: Keep using the old fd
+- OPEN_AFTER_CLOSE: First close the old fd and then open a new to workaround the bug
+- OPEN_BEFORE_CLOSE: the normal behaviour when the VPN configuration changed
-- 
1.8.5.2 (Apple Git-48)


