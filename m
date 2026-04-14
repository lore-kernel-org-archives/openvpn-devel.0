From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 14 Apr 2026 14:56:37 +0200
Message-ID: <20260414125637.42082-1-frank@...2641...>
In-Reply-To: <gerrit.1775138817000.I3157e1a228ac7058fca6a88f94076052e33d2e01@...2715...>
References: <gerrit.1775138817000.I3157e1a228ac7058fca6a88f94076052e33d2e01@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] build: Use info fetched from version.m4
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
Cc: Luis Cruz <luis.cruz@...3019...>

From: Luis Cruz <luis.cruz@...3019...>

Change-Id: I3157e1a228ac7058fca6a88f94076052e33d2e01
Signed-off-by: Luis Cruz <luis.cruz@...3019...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1605
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1605
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..72e349c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -141,6 +141,10 @@
 set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
 set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})
 
+set(TAP_WIN_COMPONENT_ID "${PRODUCT_TAP_WIN_COMPONENT_ID}")
+set(TAP_WIN_MIN_MAJOR ${PRODUCT_TAP_WIN_MIN_MAJOR})
+set(TAP_WIN_MIN_MINOR ${PRODUCT_TAP_WIN_MIN_MINOR})
+
 set(CMAKE_C_STANDARD 11)
 
 # Set the various defines for config.h.cmake.in
diff --git a/config.h.cmake.in b/config.h.cmake.in
index a93fcd5..ae1d264 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -366,13 +366,13 @@
 #undef SYSTEMD_ASK_PASSWORD_PATH
 
 /* The tap-windows id */
-#define TAP_WIN_COMPONENT_ID "tap0901"
+#define TAP_WIN_COMPONENT_ID "@TAP_WIN_COMPONENT_ID@"
 
 /* The tap-windows version number is required for OpenVPN */
-#define TAP_WIN_MIN_MAJOR 9
+#define TAP_WIN_MIN_MAJOR @TAP_WIN_MIN_MAJOR@
 
 /* The tap-windows version number is required for OpenVPN */
-#define TAP_WIN_MIN_MINOR 9
+#define TAP_WIN_MIN_MINOR @TAP_WIN_MIN_MINOR@
 
 /* Are we running on Mac OS X? */
 #cmakedefine TARGET_DARWIN

