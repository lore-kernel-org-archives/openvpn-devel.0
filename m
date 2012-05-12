From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:37 +0300
Message-Id: <1336850389-23719-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 04/16] cleanup: syshead: remove useless
	constant USE_64_BIT_COUNTERS
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
 src/openvpn/common.h  |   13 ++++---------
 src/openvpn/syshead.h |    5 -----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index de2d609..845faee 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -28,16 +28,11 @@
 /*
  * Statistics counters and associated printf formats.
  */
-#ifdef USE_64_BIT_COUNTERS
-  typedef unsigned long long int counter_type;
-# ifdef WIN32
-#  define counter_format  "%I64u"
-# else
-#  define counter_format  "%llu"
-# endif
+typedef unsigned long long int counter_type;
+#ifdef WIN32
+# define counter_format  "%I64u"
 #else
-  typedef unsigned int counter_type;
-# define counter_format   "%u"
+# define counter_format  "%llu"
 #endif
 
 /*
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 99a6674..ccd78af 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -456,11 +456,6 @@ socket_defined (const socket_descriptor_t sd)
 }
 
 /*
- * Should statistics counters be 64 bits?
- */
-#define USE_64_BIT_COUNTERS
-
-/*
  * Should we enable the use of execve() for calling subprocesses,
  * instead of system()?
  */
-- 
1.7.3.4


