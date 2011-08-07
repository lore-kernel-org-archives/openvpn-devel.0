From: Bertrand Jacquin <beber@...1472...>
Date: Sun,  7 Aug 2011 13:08:22 +0200
Message-Id: <1312715302-10808-1-git-send-email-beber@...1472...>
In-Reply-To: <1312714757-10317-3-git-send-email-beber@...1472...>
References: <1312714757-10317-3-git-send-email-beber@...1472...>
Subject: [Openvpn-devel] [PATCH 1/3] Win32: Add OpenVPN RC file to add fill
	"Details" exe properties tabs
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

First patch was incomplete

Signed-off-by: Bertrand Jacquin <beber@...1472...>
---
 openvpn-res.rc |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/openvpn-res.rc b/openvpn-res.rc
new file mode 100644
index 0000000..0352807
--- /dev/null
+++ b/openvpn-res.rc
@@ -0,0 +1,35 @@
+/*
+ * (c) 2011 Bertrand Jacquin <beber@...1472...>
+ */
+
+#include <windows.h>
+#include "config.h"
+
+1 VERSIONINFO
+  FILEVERSION    _VERSION_
+  PRODUCTVERSION _VERSION_
+  FILEOS         VOS__WINDOWS32
+  FILETYPE       VFT_APP
+
+BEGIN
+  BLOCK "StringFileInfo"
+  BEGIN
+    BLOCK "040904b0"  /* en_US, Unicode */
+    BEGIN
+      // required
+      VALUE "CompanyName",      PACKAGE_NAME "\0"
+      VALUE "FileDescription",  PACKAGE_NAME "\0"
+      VALUE "FileVersion",      PACKAGE_VERSION "\0"
+      VALUE "InternalName",     PACKAGE_TARNAME "\0"
+      VALUE "OriginalFilename", PACKAGE_TARNAME ".exe\0"
+      VALUE "ProductName",      PACKAGE_NAME "\0"
+      VALUE "ProductVersion",   PACKAGE_VERSION "\0"
+      // optional
+      VALUE "LegalCopyright",   "(C) 2002-2010 " PACKAGE_NAME " Technologies, Inc.\0"
+    END
+  END
+  BLOCK "VarFileInfo"
+  BEGIN
+    VALUE "Translation", 0x409, 0x4b0
+  END
+END
-- 
1.7.6


