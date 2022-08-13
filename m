From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 14 Aug 2022 00:20:40 +0300
Message-Id: <20220813212040.113-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] error.c: remove unused crash() function
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This has been added in 2006 and as of now not used.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/error.c | 9 ---------
 src/openvpn/error.h | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 7cd35b17..c8c77358 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -808,15 +808,6 @@ msg_flags_string(const unsigned int flags, struct gc_arena *gc)
     return BSTR(&out);
 }
 
-#ifdef ENABLE_DEBUG
-void
-crash(void)
-{
-    char *null = NULL;
-    *null = 0;
-}
-#endif
-
 #ifdef _WIN32
 
 const char *
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 972619fe..89adb3e6 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -220,11 +220,6 @@ __attribute__((__noreturn__))
     [!!sizeof(struct { int __error_if_negative : (expr) ? 2 : -1; })]
 #endif
 
-#ifdef ENABLE_DEBUG
-void crash(void);  /* force a segfault (debugging only) */
-
-#endif
-
 /* Inline functions */
 
 static inline bool
-- 
2.23.0.windows.1


