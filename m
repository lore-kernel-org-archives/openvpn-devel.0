From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:25 +0200
Message-Id: <20210401131337.3684-3-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 02/14] Remove superflous ifdefs around enum
 like defines
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

The variables are not used without the configured options but the
ifdef around them does not help readibility either.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtcp.c    | 5 -----
 src/openvpn/mudp.c    | 2 --
 src/openvpn/openvpn.h | 4 ----
 3 files changed, 11 deletions(-)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 22c824aaa..7d2a69b99 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -59,13 +59,8 @@
 #define MTCP_SOCKET      ((void *)1)
 #define MTCP_TUN         ((void *)2)
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
-#ifdef ENABLE_MANAGEMENT
 #define MTCP_MANAGEMENT ((void *)4)
-#endif
-
-#ifdef ENABLE_ASYNC_PUSH
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
-#endif
 
 #define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
 
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index e95a7ac81..5af1081fc 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -195,12 +195,10 @@ multi_process_io_udp(struct multi_context *m)
     {
         strcat(buf, "TW/");
     }
-#ifdef ENABLE_ASYNC_PUSH
     else if (status & FILE_CLOSED)
     {
         strcat(buf, "FC/");
     }
-#endif
     printf("IO %s\n", buf);
 #endif /* ifdef MULTI_DEBUG_EVENT_LOOP */
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3cef26381..1063351d3 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -252,13 +252,9 @@ struct context_2
 #define TUN_WRITE         (1<<3)
 #define ES_ERROR          (1<<4)
 #define ES_TIMEOUT        (1<<5)
-#ifdef ENABLE_MANAGEMENT
 #define MANAGEMENT_READ  (1<<6)
 #define MANAGEMENT_WRITE (1<<7)
-#endif
-#ifdef ENABLE_ASYNC_PUSH
 #define FILE_CLOSED       (1<<8)
-#endif
 
     unsigned int event_set_status;
 
-- 
2.30.1


