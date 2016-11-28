From: Christian Hesse <list@...1798...>
Date: Mon, 28 Nov 2016 18:08:20 +0100
Message-Id: <20161128170820.20371-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] update year in copyright message
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
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

This line has not been touched in a long time... Let's update the
copyright message with recent year.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7c2b989..63dcc24 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3685,7 +3685,7 @@ usage_version (void)
   show_windows_version( M_INFO|M_NOPREFIX );
 #endif
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-  msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>");
+  msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2016 OpenVPN Technologies, Inc. <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
-- 
2.10.2


