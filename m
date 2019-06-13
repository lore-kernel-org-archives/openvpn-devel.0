From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 16:41:12 +0200
Message-Id: <20190613144113.6418-5-arne@...1227...>
In-Reply-To: <20190613144113.6418-1-arne@...1227...>
References: <20190613144113.6418-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/5] Implement sending response to challenge
 via CR_RESPONSE
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

When a client announces its support to support text based
challenge/response via IV_SOO=cr_text,the client needs to also
be able to reply to that response.

This adds the "cr-response" management function to be able to
do this. The answer should be base64 encoded.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt |  8 ++++++++
 src/openvpn/init.c       | 25 +++++++++++++++++++++++++
 src/openvpn/manage.c     | 37 ++++++++++++++++++++++++++++++++++++-
 src/openvpn/manage.h     |  1 +
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 05d30b0a..29f2da75 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -806,6 +806,14 @@ To accept connecting to the host and port directly, use this command:
 
   proxy NONE
 
+COMMAND -- cr-response (OpenVPN 2.5 or higher)
+-------------------------------------------------
+Provides support for sending responses a challenge/response
+query via INFOMSG,CR_TEXT. The response should be base64 encoded:
+
+  cr-response SGFsbG8gV2VsdCE=
+
+
 COMMAND -- pk-sig (OpenVPN 2.5 or higher, management version > 1)
 COMMAND -- rsa-sig (OpenVPN 2.3 or higher, management version <= 1)
 -----------------------------------------------------------------
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 647f5336..08425d85 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -287,6 +287,30 @@ ce_management_query_proxy(struct context *c)
     return ret;
 }
 
+static bool
+management_callback_send_cc_mesage(void *arg,
+                                   const char *command,
+                                   const char *parameters)
+{
+    struct context *c = (struct context *) arg;
+    size_t len = strlen(command) + 1 + sizeof(parameters) + 1;
+    if (len > PUSH_BUNDLE_SIZE)
+    {
+        return false;
+    }
+
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(len, &gc);
+    ASSERT(buf_printf(&buf, "%s", command));
+    if (parameters)
+    {
+        ASSERT(buf_printf(&buf, ",%s", parameters));
+    }
+    bool status = send_control_channel_string(c, BSTR(&buf), D_PUSH);
+
+    gc_free(&gc);
+    return status;
+}
 
 static bool
 management_callback_remote_cmd(void *arg, const char **p)
@@ -3920,6 +3944,7 @@ init_management_callback_p2p(struct context *c)
         cb.show_net = management_show_net_callback;
         cb.proxy_cmd = management_callback_proxy_cmd;
         cb.remote_cmd = management_callback_remote_cmd;
+        cb.send_cc_message = management_callback_send_cc_mesage;
 #ifdef TARGET_ANDROID
         cb.network_change = management_callback_network_change;
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index a2b58296..8ec90bb1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -75,6 +75,7 @@ man_help(void)
     msg(M_CLIENT, "auth-retry t           : Auth failure retry mode (none,interact,nointeract).");
     msg(M_CLIENT, "bytecount n            : Show bytes in/out, update every n secs (0=off).");
     msg(M_CLIENT, "echo [on|off] [N|all]  : Like log, but only show messages in echo buffer.");
+    msg(M_CLIENT, "cr-response response   : Send a challenge response answer via CR_RESPONSE to server");
     msg(M_CLIENT, "exit|quit              : Close management session.");
     msg(M_CLIENT, "forget-passwords       : Forget passwords entered so far.");
     msg(M_CLIENT, "help                   : Print this message.");
@@ -779,6 +780,27 @@ man_net(struct management *man)
     }
 }
 
+static void
+man_send_cc_message(struct management *man, const char* message, const char* parameters)
+{
+    if (man->persist.callback.send_cc_message)
+        {
+            const bool status = (*man->persist.callback.send_cc_message)
+                (man->persist.callback.arg, message, parameters);
+            if (status)
+            {
+                msg(M_CLIENT, "SUCCESS: command succeeded");
+            }
+            else
+            {
+                msg(M_CLIENT, "ERROR: command failed");
+            }
+        }
+    else
+    {
+        msg(M_CLIENT, "ERROR: This command is not supported by the current daemon mode");
+    }
+}
 #ifdef ENABLE_PKCS11
 
 static void
@@ -1144,7 +1166,13 @@ man_load_stats(struct management *man)
 }
 
 #define MN_AT_LEAST (1<<0)
-
+/**
+ *
+ * @param p         pointer to the parameter array
+ * @param n         number of arguments required
+ * @param flags     if MN_AT_LEAST require at least n parameters and not exactly n
+ * @return          Return wether p has n (or at least n) parameters
+ */
 static bool
 man_need(struct management *man, const char **p, const int n, unsigned int flags)
 {
@@ -1460,6 +1488,13 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
             man_query_need_str(man, p[1], p[2]);
         }
     }
+    else if (streq(p[0], "cr-response"))
+    {
+        if (man_need (man, p, 1, 0))
+        {
+             man_send_cc_message (man, "CR_RESPONSE", p[1]);
+        }
+    }
     else if (streq(p[0], "net"))
     {
         man_net(man);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 5f19cc3d..6a749725 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -164,6 +164,7 @@ struct management_callback
     int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port);
     void (*delete_event) (void *arg, event_t event);
     int (*n_clients) (void *arg);
+    bool (*send_cc_message) (void *arg, const char *message, const char *parameter);
 #ifdef MANAGEMENT_DEF_AUTH
     bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);
     bool (*client_auth) (void *arg,
-- 
2.22.0


