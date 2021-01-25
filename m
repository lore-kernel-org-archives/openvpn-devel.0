From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Jan 2021 13:56:21 +0100
Message-Id: <20210125125628.30364-5-arne@...1227...>
In-Reply-To: <20210125125628.30364-1-arne@...1227...>
References: <20210125125628.30364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 04/11] Introduce management client state
 for AUTH_PENDING notifications
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

This allows a UI client to display the correct state. Technically the
client is still waiting for PUSH_REPLY but for every practical concern
this is a different state as we are waiting for the pending
authentication to finish.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c |  3 +++
 src/openvpn/manage.h |  2 ++
 src/openvpn/push.c   | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 98a9a4cc..df987f53 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -169,6 +169,9 @@ man_state_name(const int state)
         case OPENVPN_STATE_TCP_CONNECT:
             return "TCP_CONNECT";
 
+        case OPENVPN_STATE_AUTH_PENDING:
+            return "AUTH_PENDING";
+
         default:
             return "?";
     }
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index aaa3b848..2f94b10c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -493,6 +493,8 @@ management_enable_def_auth(const struct management *man)
 #define OPENVPN_STATE_GET_CONFIG    9  /* Downloading configuration from server */
 #define OPENVPN_STATE_RESOLVE       10 /* DNS lookup */
 #define OPENVPN_STATE_TCP_CONNECT   11 /* Connecting to TCP server */
+#define OPENVPN_STATE_AUTH_PENDING  12 /* Waiting in auth-pending mode
+                                        * techhnically variant of GET_CONFIG */
 
 #define OPENVPN_STATE_CLIENT_BASE   7  /* Base index of client-only states */
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e68fda9f..7d3cf806 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -248,12 +248,30 @@ parse_auth_pending_keywords(const struct buffer *buffer,
     if (!buf_advance(&buf, strlen("AUTH_PENDING"))
         || !(buf_read_u8(&buf) == ',') || !BLEN(&buf))
     {
+#ifdef ENABLE_MANAGEMENT
+        if (management)
+        {
+            management_set_state(management, OPENVPN_STATE_AUTH_PENDING,
+                                 "", NULL, NULL, NULL, NULL);
+        }
+#endif
+
         return;
     }
 
     /* parse the keywords in the same way that push options are parsed */
     char line[OPTION_LINE_SIZE];
 
+#ifdef ENABLE_MANAGEMENT
+    /* Need to do the management notification with the keywords before
+     * buf_parse is called, as it will insert \0 bytes into the buffer */
+    if (management)
+    {
+        management_set_state(management, OPENVPN_STATE_AUTH_PENDING,
+                             BSTR(&buf), NULL, NULL, NULL, NULL);
+    }
+#endif
+
     while (buf_parse(&buf, ',', line, sizeof(line)))
     {
         if (sscanf(line, "timeout %u", server_timeout) != 1)
-- 
2.30.0


