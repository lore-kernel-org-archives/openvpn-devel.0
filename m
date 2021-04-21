From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Apr 2021 15:43:44 +0200
Message-Id: <20210421134348.1950392-3-arne@...1227...>
In-Reply-To: <20210421134348.1950392-1-arne@...1227...>
References: <20210421134348.1950392-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] Remove always enabled
 USE_64_BIT_COUNTERS define
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

Also change the types to use C99 uint64_t and its printf u64 define.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/common.h  | 15 +++------------
 src/openvpn/syshead.h |  5 -----
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 623b3e0d7..544fa238e 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -25,19 +25,10 @@
 #define COMMON_H
 
 /*
- * Statistics counters and associated printf formats.
+ * Statistics counters and associated printf format.
  */
-#ifdef USE_64_BIT_COUNTERS
-typedef unsigned long long int counter_type;
-#ifdef _WIN32
-#define counter_format  "%I64u"
-#else
-#define counter_format  "%llu"
-#endif
-#else  /* ifdef USE_64_BIT_COUNTERS */
-typedef unsigned int counter_type;
-#define counter_format   "%u"
-#endif
+typedef uint64_t counter_type;
+#define counter_format  "%" PRIu64
 
 /*
  * Time intervals
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index cb9bf7dc7..f29c63c73 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -458,11 +458,6 @@ socket_defined(const socket_descriptor_t sd)
     return sd != SOCKET_UNDEFINED;
 }
 
-/*
- * Should statistics counters be 64 bits?
- */
-#define USE_64_BIT_COUNTERS
-
 /*
  * Should we enable the use of execve() for calling subprocesses,
  * instead of system()?
-- 
2.31.1


