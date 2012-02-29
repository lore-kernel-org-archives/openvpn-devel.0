From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:30 +0200
Message-Id: <1330547854-18889-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 07/11] cleanup: rename
	common.h->tap-windows.h
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/common.h      |   82 -----------------------------------------------------
 src/resource.rc   |    3 --
 src/tap-windows.h |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/tapdrvr.c     |    2 +-
 4 files changed, 83 insertions(+), 86 deletions(-)
 delete mode 100755 src/common.h
 create mode 100755 src/tap-windows.h

diff --git a/src/common.h b/src/common.h
deleted file mode 100755
index 8dceda5..0000000
--- a/src/common.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- *  TAP-Windows -- A kernel driver to provide virtual tap
- *                 device functionality on Windows.
- *
- *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
- *
- *  This source code is Copyright (C) 2002-2010 OpenVPN Technologies, Inc.,
- *  and is released under the GPL version 2 (see below).
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-//===============================================
-// This file is included both by OpenVPN and
-// the TAP-Windows driver and contains definitions
-// common to both.
-//===============================================
-
-#ifndef HAVE_CONFIG_H
-#include "autodefs.h"
-#endif
-
-//=============
-// TAP IOCTLs
-//=============
-
-#define TAP_CONTROL_CODE(request,method) \
-  CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
-
-// Present in 8.1
-
-#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFFERED)
-#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFFERED)
-#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFFERED)
-#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFFERED)
-
-// Added in 8.2
-
-/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
-#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUFFERED)
-
-//=================
-// Registry keys
-//=================
-
-#define ADAPTER_KEY "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
-
-#define NETWORK_CONNECTIONS_KEY "SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
-
-//======================
-// Filesystem prefixes
-//======================
-
-#define USERMODEDEVICEDIR "\\\\.\\Global\\"
-#define SYSDEVICEDIR      "\\Device\\"
-#define USERDEVICEDIR     "\\DosDevices\\Global\\"
-#define TAPSUFFIX         ".tap"
-
-//=========================================================
-// TAP_COMPONENT_ID -- This string defines the TAP driver
-// type -- different component IDs can reside in the system
-// simultaneously.
-//=========================================================
-
-#define TAP_COMPONENT_ID TAP_ID
diff --git a/src/resource.rc b/src/resource.rc
index d50b60f..d5a7c35 100755
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -1,9 +1,6 @@
 #include <windows.h>
 #include <ntverp.h>
 
-/* get VERSION */
-#include "common.h"
-
 #undef VER_PRODUCTVERSION
 #undef VER_PRODUCTVERSION_STR
 #undef VER_COMPANYNAME_STR
diff --git a/src/tap-windows.h b/src/tap-windows.h
new file mode 100755
index 0000000..8dceda5
--- /dev/null
+++ b/src/tap-windows.h
@@ -0,0 +1,82 @@
+/*
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
+ *
+ *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
+ *
+ *  This source code is Copyright (C) 2002-2010 OpenVPN Technologies, Inc.,
+ *  and is released under the GPL version 2 (see below).
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+//===============================================
+// This file is included both by OpenVPN and
+// the TAP-Windows driver and contains definitions
+// common to both.
+//===============================================
+
+#ifndef HAVE_CONFIG_H
+#include "autodefs.h"
+#endif
+
+//=============
+// TAP IOCTLs
+//=============
+
+#define TAP_CONTROL_CODE(request,method) \
+  CTL_CODE (FILE_DEVICE_UNKNOWN, request, method, FILE_ANY_ACCESS)
+
+// Present in 8.1
+
+#define TAP_IOCTL_GET_MAC               TAP_CONTROL_CODE (1, METHOD_BUFFERED)
+#define TAP_IOCTL_GET_VERSION           TAP_CONTROL_CODE (2, METHOD_BUFFERED)
+#define TAP_IOCTL_GET_MTU               TAP_CONTROL_CODE (3, METHOD_BUFFERED)
+#define TAP_IOCTL_GET_INFO              TAP_CONTROL_CODE (4, METHOD_BUFFERED)
+#define TAP_IOCTL_CONFIG_POINT_TO_POINT TAP_CONTROL_CODE (5, METHOD_BUFFERED)
+#define TAP_IOCTL_SET_MEDIA_STATUS      TAP_CONTROL_CODE (6, METHOD_BUFFERED)
+#define TAP_IOCTL_CONFIG_DHCP_MASQ      TAP_CONTROL_CODE (7, METHOD_BUFFERED)
+#define TAP_IOCTL_GET_LOG_LINE          TAP_CONTROL_CODE (8, METHOD_BUFFERED)
+#define TAP_IOCTL_CONFIG_DHCP_SET_OPT   TAP_CONTROL_CODE (9, METHOD_BUFFERED)
+
+// Added in 8.2
+
+/* obsoletes TAP_IOCTL_CONFIG_POINT_TO_POINT */
+#define TAP_IOCTL_CONFIG_TUN            TAP_CONTROL_CODE (10, METHOD_BUFFERED)
+
+//=================
+// Registry keys
+//=================
+
+#define ADAPTER_KEY "SYSTEM\\CurrentControlSet\\Control\\Class\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
+
+#define NETWORK_CONNECTIONS_KEY "SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08002BE10318}"
+
+//======================
+// Filesystem prefixes
+//======================
+
+#define USERMODEDEVICEDIR "\\\\.\\Global\\"
+#define SYSDEVICEDIR      "\\Device\\"
+#define USERDEVICEDIR     "\\DosDevices\\Global\\"
+#define TAPSUFFIX         ".tap"
+
+//=========================================================
+// TAP_COMPONENT_ID -- This string defines the TAP driver
+// type -- different component IDs can reside in the system
+// simultaneously.
+//=========================================================
+
+#define TAP_COMPONENT_ID TAP_ID
diff --git a/src/tapdrvr.c b/src/tapdrvr.c
index 2156f8b..ffc5813 100755
--- a/src/tapdrvr.c
+++ b/src/tapdrvr.c
@@ -35,7 +35,7 @@
 // TAP_IOCTL_CONFIG_TUN ioctl.
 //======================================================
 
-#include "common.h"
+#include "tap-windows.h"
 
 #define NDIS_MINIPORT_DRIVER
 #define BINARY_COMPATIBLE 0
-- 
1.7.3.4


