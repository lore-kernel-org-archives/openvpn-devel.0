From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:33 +0200
Message-Id: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 01/13] Added ENABLE_PASSWORD_SAVE to
	config-win32.h
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

This change adds ENABLE_PASSWORD_SAVE to config-win32.h. This option is also
defined in win/settings.in, but it does not have any effect there.
---
 config-win32.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/config-win32.h b/config-win32.h
index be0b320..87a0b68 100644
--- a/config-win32.h
+++ b/config-win32.h
@@ -50,6 +50,9 @@ typedef unsigned long in_addr_t;
 #define TAP_WIN32_DEBUG
 #endif
 
+/* Enable reading credentials from a file */
+#define ENABLE_PASSWORD_SAVE 1
+
 /* Enable client/server capability */
 #define ENABLE_CLIENT_SERVER 1
 
-- 
1.6.3.3


