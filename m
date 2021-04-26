From: Antonio Quartulli <a@...2181...>
Date: Mon, 26 Apr 2021 17:29:14 +0200
Message-Id: <20210426152914.18314-1-a@...2181...>
In-Reply-To: <20210426132603.31629-1-a@...2181...>
References: <20210426132603.31629-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Add documentation on
 EVENT_READ/EVENT_WRITE constants
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Changes from v3:
- re-introduce READ/WRITE_SHIFT because they are different from EVENT_READ/WRITE
- define also EVENT_READ/WRITE using READ/WRITE_SHIFT

Changes from v2:
- moved event definitions to event.h
- removed READ/WRITE_SHIFT and use EVENT_READ/WRITE
- removed ifdefs around *_SHIFTS definitions in event.h

Changes from v1:
- fixed typ0s
- extended comment
- moved *_SHIFT definition to openvpn.h
- made READ/WRITE events dependant on _SHIFT definition with a macro

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/event.h   | 44 +++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/forward.c | 14 ++++++++------
 src/openvpn/openvpn.h | 12 +-----------
 3 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 4af6371e..bfc3d51f 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -32,9 +32,49 @@
  * rwflags passed to event_ctl and returned by
  * struct event_set_return.
  */
+#define READ_SHIFT	0
+#define WRITE_SHIFT	1
+
 #define EVENT_UNDEF    4
-#define EVENT_READ     (1<<0)
-#define EVENT_WRITE    (1<<1)
+#define EVENT_READ     (1 << READ_SHIFT)
+#define EVENT_WRITE    (1 << WRITE_SHIFT)
+
+/* event flags returned by io_wait.
+ *
+ * All these events are defined as bits in a bitfield.
+ * Each event type owns two bits in the bitfield: one for the READ
+ * event and one for the WRITE event.
+ *
+ * For this reason, the specific event bit is calculated by adding
+ * the event type identifier (always a multiple of 2, as defined
+ * below) to 0 for READ and 1 for WRITE.
+ *
+ * E.g.
+ * MANAGEMENT_SHIFT = 6;  <---- event type identifier
+ * MANAGEMENT_READ = (1 << (6 + 0)),  <---- READ event
+ * MANAGEMENT_WRITE = (1 << (6 + 1))  <---- WRITE event
+ *
+ * 'error' and 'file_close' are special and use read/write for different
+ * signals.
+ */
+
+#define EVENT_SHIFT(_name, _op)   (1 << (_name ## _SHIFT + _op ## _SHIFT))
+
+#define SOCKET_SHIFT        0
+#define SOCKET_READ         EVENT_SHIFT(SOCKET, READ)
+#define SOCKET_WRITE        EVENT_SHIFT(SOCKET, WRITE)
+#define TUN_SHIFT           2
+#define TUN_READ            EVENT_SHIFT(TUN, READ)
+#define TUN_WRITE           EVENT_SHIFT(TUN, WRITE)
+#define ERR_SHIFT           4
+#define ES_ERROR            EVENT_SHIFT(ERR, READ)
+#define ES_TIMEOUT          EVENT_SHIFT(ERR, WRITE)
+#define MANAGEMENT_SHIFT    6
+#define MANAGEMENT_READ     EVENT_SHIFT(MANAGEMENT, READ)
+#define MANAGEMENT_WRITE    EVENT_SHIFT(MANAGEMENT, WRITE)
+#define FILE_SHIFT          8
+#define FILE_CLOSED         EVENT_SHIFT(FILE, READ)
+
 /*
  * Initialization flags passed to event_set_init
  */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index df96d048..e302d8e0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1867,15 +1867,17 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     unsigned int tuntap = 0;
     struct event_set_return esr[4];
 
-    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
-    static int socket_shift = 0;   /* depends on SOCKET_READ and SOCKET_WRITE */
-    static int tun_shift = 2;      /* depends on TUN_READ and TUN_WRITE */
-    static int err_shift = 4;      /* depends on ES_ERROR */
+    /* These shifts all depend on EVENT_READ (=1) and EVENT_WRITE (=2)
+     * and are added to the shift. Check openvpn.h for more details.
+     */
+    static int socket_shift = SOCKET_SHIFT;
+    static int tun_shift = TUN_SHIFT;
+    static int err_shift = ERR_SHIFT;
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
+    static int management_shift = MANAGEMENT_SHIFT;
 #endif
 #ifdef ENABLE_ASYNC_PUSH
-    static int file_shift = 8;     /* listening inotify events */
+    static int file_shift = FILE_SHIFT;
 #endif
 
     /*
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a15ff08d..6e4651cf 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -232,17 +232,7 @@ struct context_2
     int event_set_max;
     bool event_set_owned;
 
-    /* event flags returned by io_wait */
-#define SOCKET_READ       (1<<0)
-#define SOCKET_WRITE      (1<<1)
-#define TUN_READ          (1<<2)
-#define TUN_WRITE         (1<<3)
-#define ES_ERROR          (1<<4)
-#define ES_TIMEOUT        (1<<5)
-#define MANAGEMENT_READ  (1<<6)
-#define MANAGEMENT_WRITE (1<<7)
-#define FILE_CLOSED       (1<<8)
-
+    /* bitmask for event status. Check event.h for possible values */
     unsigned int event_set_status;
 
     struct link_socket *link_socket;     /* socket used for TCP/UDP connection to remote */
-- 
2.26.3


