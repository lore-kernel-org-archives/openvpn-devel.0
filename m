From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:35 +0300
Message-Id: <1336850389-23719-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 02/16] cleanup: syshead: move O_BINARY
	detection to autoconf
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   11 +++++++++++
 src/openvpn/syshead.h |    7 -------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4592727..6f6a1f4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -519,6 +519,17 @@ AC_CHECK_DECLS(
 	]]
 )
 
+AC_CHECK_DECLS(
+	[O_BINARY],
+	,
+	[AC_DEFINE([O_BINARY], [0], [O_BINARY replacement])],
+	[[
+		#ifdef HAVE_FCNTL_H
+		#include <fcntl.h>
+		#endif
+	]]
+)
+
 AC_FUNC_FORK
 
 AC_CHECK_FUNCS([ \
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c5dbac6..91a23d3 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -439,13 +439,6 @@
 #endif
 
 /*
- * Does this OS draw a distinction between binary and ascii files?
- */
-#ifndef O_BINARY
-#define O_BINARY 0
-#endif
-
-/*
  * Define a boolean value based
  * on Win32 status.
  */
-- 
1.7.3.4


