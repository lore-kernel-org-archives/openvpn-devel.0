From: David Sommerseth <openvpn.list@...1114...>
Date: Mon, 22 Feb 2010 22:41:49 +0100
Message-Id: <1266874909-7144-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] FRP: Present a warning on deprecated
	features during start-up
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
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

Added a new function, warn_deprecated_features(), which is located in
deprecated.[ch].  All deprecated features should present a warning here.
This function will be called during start-up and will show all warnings
after the OpenVPN title string.

Included a deprecated feature warning for the resolv-random feature.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am  |    3 ++-
 deprecated.c |   36 ++++++++++++++++++++++++++++++++++++
 deprecated.h |   30 ++++++++++++++++++++++++++++++
 openvpn.c    |    5 +++++
 4 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 deprecated.c
 create mode 100644 deprecated.h

diff --git a/Makefile.am b/Makefile.am
index 7bccc11..e199b17 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -138,7 +138,8 @@ openvpn_SOURCES = \
 	thread.c thread.h \
 	tun.c tun.h \
 	win32.h win32.c \
-	cryptoapi.h cryptoapi.c
+	cryptoapi.h cryptoapi.c \
+	deprecated.h deprecated.c
 
 
 dist-hook:
diff --git a/deprecated.c b/deprecated.c
new file mode 100644
index 0000000..832413a
--- /dev/null
+++ b/deprecated.c
@@ -0,0 +1,36 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010  David Sommerseth <dazo@...384...>
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
+#include "syshead.h"
+#include "error.h"
+
+
+inline void
+warn_deprecated_features (void)
+{
+#ifdef DEPRECATED_RANDOM_RESOLV
+  msg (M_INFO, "[DEPRECATED FEATURE ENABLED: random-resolv] Resolving hostnames will use randomisation if more than one IP address is found");
+#endif
+}
+
diff --git a/deprecated.h b/deprecated.h
new file mode 100644
index 0000000..cbe74ee
--- /dev/null
+++ b/deprecated.h
@@ -0,0 +1,30 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010  David Sommerseth <dazo@...384...>
+*
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
+#ifndef DEPRECATED_H
+#define DEPRECATED_H
+
+inline void warn_deprecated_features (void);
+
+#endif
diff --git a/openvpn.c b/openvpn.c
index 451fbe4..6e12873 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -28,6 +28,7 @@
 #include "forward.h"
 #include "multi.h"
 #include "win32.h"
+#include "deprecated.h"
 
 #include "memdbg.h"
 
@@ -181,6 +182,10 @@ main (int argc, char *argv[])
 	  /* print version number */
 	  msg (M_INFO, "%s", title_string);
 
+          /* All deprecated features should present a warning
+             in this function, found in deprecated.c */
+	  warn_deprecated_features ();
+
 	  /* misc stuff */
 	  pre_setup (&c.options);
 
-- 
1.6.6


