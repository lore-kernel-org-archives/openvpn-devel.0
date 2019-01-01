From: Simon Rozman <simon@...2293...>
Date: Wed,  2 Jan 2019 00:35:47 +0100
Message-Id: <20190101233547.10100-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Strip _stdcall suffixes (@nn) for 32-bit
 builds
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

This makes DLL exported function names consistent between 32 and 64-bit
builds.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/Makefile.am | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index f00a01d8..db8502b8 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -2,7 +2,7 @@
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
 #  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2018-2019 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
@@ -40,7 +40,8 @@ lib_LTLIBRARIES = libopenvpnmsica.la
 libopenvpnmsica_la_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
-	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+	-D_WIN32_WINNT=_WIN32_WINNT_VISTA \
+	-Wl,--kill-at
 libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshell32 -lshlwapi -lversion -no-undefined -avoid-version
 endif
 
-- 
2.19.0.windows.1


