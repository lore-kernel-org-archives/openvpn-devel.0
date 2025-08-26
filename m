From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:48:57 +0200
Message-ID: <20250826184904.22057-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I0937165c5efa95136bd951345a076e33e396f26a@...2715...>
References: <gerrit.1753360288000.I0937165c5efa95136bd951345a076e33e396f26a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] manage: Make sure various management
 flags are treated as unsigned
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

From: Frank Lichtenheld <frank@...2641...>

The variables that hold them are already unsigned, make sure
the flags are as well to avoid spurious conversion warnings.

Change-Id: I0937165c5efa95136bd951345a076e33e396f26a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1105
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 40ae2c8..f937ee1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -370,7 +370,7 @@
         && ((ce->flags >> CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE_MASK)
                == CE_MAN_QUERY_REMOTE_QUERY)
     {
-        int flags = 0;
+        unsigned int flags = 0;
         if (!strcmp(p[1], "ACCEPT"))
         {
             flags = CE_MAN_QUERY_REMOTE_ACCEPT;
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 083caf5..911e15b 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -24,24 +24,24 @@
 #define MANAGE_H
 
 /* management_open flags */
-#define MF_SERVER                 (1 << 0)
-#define MF_QUERY_PASSWORDS        (1 << 1)
-#define MF_HOLD                   (1 << 2)
-#define MF_SIGNAL                 (1 << 3)
-#define MF_FORGET_DISCONNECT      (1 << 4)
-#define MF_CONNECT_AS_CLIENT      (1 << 5)
-#define MF_CLIENT_AUTH            (1 << 6)
-/* #define MF_CLIENT_PF         (1<<7) *REMOVED FEATURE* */
-#define MF_UNIX_SOCK              (1 << 8)
-#define MF_EXTERNAL_KEY           (1 << 9)
-#define MF_EXTERNAL_KEY_NOPADDING (1 << 10)
-#define MF_EXTERNAL_KEY_PKCS1PAD  (1 << 11)
-#define MF_UP_DOWN                (1 << 12)
-#define MF_QUERY_REMOTE           (1 << 13)
-#define MF_QUERY_PROXY            (1 << 14)
-#define MF_EXTERNAL_CERT          (1 << 15)
-#define MF_EXTERNAL_KEY_PSSPAD    (1 << 16)
-#define MF_EXTERNAL_KEY_DIGEST    (1 << 17)
+#define MF_SERVER                 (1u << 0)
+#define MF_QUERY_PASSWORDS        (1u << 1)
+#define MF_HOLD                   (1u << 2)
+#define MF_SIGNAL                 (1u << 3)
+#define MF_FORGET_DISCONNECT      (1u << 4)
+#define MF_CONNECT_AS_CLIENT      (1u << 5)
+#define MF_CLIENT_AUTH            (1u << 6)
+/* #define MF_CLIENT_PF              (1u << 7) *REMOVED FEATURE* */
+#define MF_UNIX_SOCK              (1u << 8)
+#define MF_EXTERNAL_KEY           (1u << 9)
+#define MF_EXTERNAL_KEY_NOPADDING (1u << 10)
+#define MF_EXTERNAL_KEY_PKCS1PAD  (1u << 11)
+#define MF_UP_DOWN                (1u << 12)
+#define MF_QUERY_REMOTE           (1u << 13)
+#define MF_QUERY_PROXY            (1u << 14)
+#define MF_EXTERNAL_CERT          (1u << 15)
+#define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
+#define MF_EXTERNAL_KEY_DIGEST    (1u << 17)
 
 
 #ifdef ENABLE_MANAGEMENT
@@ -64,9 +64,9 @@
 {
     unsigned long cid;
 
-#define DAF_CONNECTION_ESTABLISHED (1 << 0)
-#define DAF_CONNECTION_CLOSED      (1 << 1)
-#define DAF_INITIAL_AUTH           (1 << 2)
+#define DAF_CONNECTION_ESTABLISHED (1u << 0)
+#define DAF_CONNECTION_CLOSED      (1u << 1)
+#define DAF_INITIAL_AUTH           (1u << 2)
     unsigned int flags;
 
     unsigned int mda_key_id_counter;
@@ -117,23 +117,23 @@
     union log_entry_union u;
 };
 
-#define LOG_PRINT_LOG_PREFIX   (1 << 0)
-#define LOG_PRINT_ECHO_PREFIX  (1 << 1)
-#define LOG_PRINT_STATE_PREFIX (1 << 2)
+#define LOG_PRINT_LOG_PREFIX   (1u << 0)
+#define LOG_PRINT_ECHO_PREFIX  (1u << 1)
+#define LOG_PRINT_STATE_PREFIX (1u << 2)
 
-#define LOG_PRINT_INT_DATE  (1 << 3)
-#define LOG_PRINT_MSG_FLAGS (1 << 4)
-#define LOG_PRINT_STATE     (1 << 5)
-#define LOG_PRINT_LOCAL_IP  (1 << 6)
+#define LOG_PRINT_INT_DATE  (1u << 3)
+#define LOG_PRINT_MSG_FLAGS (1u << 4)
+#define LOG_PRINT_STATE     (1u << 5)
+#define LOG_PRINT_LOCAL_IP  (1u << 6)
 
-#define LOG_PRINT_CRLF   (1 << 7)
-#define LOG_FATAL_NOTIFY (1 << 8)
+#define LOG_PRINT_CRLF   (1u << 7)
+#define LOG_FATAL_NOTIFY (1u << 8)
 
-#define LOG_PRINT_INTVAL (1 << 9)
+#define LOG_PRINT_INTVAL (1u << 9)
 
-#define LOG_PRINT_REMOTE_IP (1 << 10)
+#define LOG_PRINT_REMOTE_IP (1u << 10)
 
-#define LOG_ECHO_TO_LOG (1 << 11)
+#define LOG_ECHO_TO_LOG (1u << 11)
 
 const char *log_entry_print(const struct log_entry *e, unsigned int flags, struct gc_arena *gc);
 
@@ -175,7 +175,7 @@
 {
     void *arg;
 
-#define MCF_SERVER (1 << 0) /* is OpenVPN being run as a server? */
+#define MCF_SERVER (1u << 0) /* is OpenVPN being run as a server? */
     unsigned int flags;
 
     void (*status)(void *arg, const int version, struct status_output *so);
@@ -253,9 +253,9 @@
     int client_gid;
 
 /* flags for handling the management interface "signal" command */
-#define MANSIG_IGNORE_USR1_HUP  (1 << 0)
-#define MANSIG_MAP_USR1_TO_HUP  (1 << 1)
-#define MANSIG_MAP_USR1_TO_TERM (1 << 2)
+#define MANSIG_IGNORE_USR1_HUP  (1u << 0)
+#define MANSIG_MAP_USR1_TO_HUP  (1u << 1)
+#define MANSIG_MAP_USR1_TO_TERM (1u << 2)
     unsigned int mansig;
 };
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 38e67c8..5ee6e93 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -147,14 +147,14 @@
     int explicit_exit_notification; /* Explicitly tell peer when we are exiting via OCC_EXIT or
                                        [RESTART] message */
 
-#define CE_DISABLED                (1 << 0)
-#define CE_MAN_QUERY_PROXY         (1 << 1)
+#define CE_DISABLED                (1u << 0)
+#define CE_MAN_QUERY_PROXY         (1u << 1)
 #define CE_MAN_QUERY_REMOTE_UNDEF  0
 #define CE_MAN_QUERY_REMOTE_QUERY  1
 #define CE_MAN_QUERY_REMOTE_ACCEPT 2
 #define CE_MAN_QUERY_REMOTE_MOD    3
 #define CE_MAN_QUERY_REMOTE_SKIP   4
-#define CE_MAN_QUERY_REMOTE_MASK   (0x07)
+#define CE_MAN_QUERY_REMOTE_MASK   (0x07u)
 #define CE_MAN_QUERY_REMOTE_SHIFT  (2)
     unsigned int flags;
 

