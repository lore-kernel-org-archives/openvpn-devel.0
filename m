From: Steffan Karger <steffan@...1856...>
Date: Wed,  4 Jul 2018 19:54:02 +0200
Message-Id: <20180704175404.22371-7-steffan@...1856...>
In-Reply-To: <20180704175404.22371-1-steffan@...1856...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
 <20180704175404.22371-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2 7/9] tls-crypt-v2: add
 P_CONTROL_HARD_RESET_CLIENT_V3 opcode
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

From: Steffan Karger <steffan.karger@...1435...>

Not used yet, but prepare for sending and receiving tls-crypt-v2 handshake
messages.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ps.c         |  3 ++-
 src/openvpn/ssl.c        | 23 ++++++++++++++++++-----
 src/openvpn/ssl.h        |  5 ++++-
 src/openvpn/ssl_common.h |  2 ++
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 25ab3749..adec0724 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -985,7 +985,8 @@ is_openvpn_protocol(const struct buffer *buf)
     {
         return p[0] == 0
                && p[1] >= 14
-               && p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2<<P_OPCODE_SHIFT);
+               && (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2<<P_OPCODE_SHIFT)
+                   || p[2] == (P_CONTROL_HARD_RESET_CLIENT_V3<<P_OPCODE_SHIFT));
     }
     else if (len >= 2)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941b..bfe37fcd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -792,6 +792,9 @@ packet_opcode_name(int op)
         case P_CONTROL_HARD_RESET_SERVER_V2:
             return "P_CONTROL_HARD_RESET_SERVER_V2";
 
+        case P_CONTROL_HARD_RESET_CLIENT_V3:
+            return "P_CONTROL_HARD_RESET_CLIENT_V3";
+
         case P_CONTROL_SOFT_RESET_V1:
             return "P_CONTROL_SOFT_RESET_V1";
 
@@ -864,7 +867,8 @@ is_hard_reset(int op, int key_method)
 
     if (!key_method || key_method >= 2)
     {
-        if (op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_SERVER_V2)
+        if (op == P_CONTROL_HARD_RESET_CLIENT_V2 || op == P_CONTROL_HARD_RESET_SERVER_V2
+            || op == P_CONTROL_HARD_RESET_CLIENT_V3)
         {
             return true;
         }
@@ -1095,8 +1099,15 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
     }
     else /* session->opt->key_method >= 2 */
     {
-        session->initial_opcode = session->opt->server ?
-                                  P_CONTROL_HARD_RESET_SERVER_V2 : P_CONTROL_HARD_RESET_CLIENT_V2;
+        if (session->opt->server)
+        {
+            session->initial_opcode = P_CONTROL_HARD_RESET_SERVER_V2;
+        }
+        else
+        {
+            session->initial_opcode = session->opt->tls_crypt_v2 ?
+                    P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
+        }
     }
 
     /* Initialize control channel authentication parameters */
@@ -3427,7 +3438,8 @@ tls_pre_decrypt(struct tls_multi *multi,
             {
                 /* verify client -> server or server -> client connection */
                 if (((op == P_CONTROL_HARD_RESET_CLIENT_V1
-                      || op == P_CONTROL_HARD_RESET_CLIENT_V2) && !multi->opt.server)
+                      || op == P_CONTROL_HARD_RESET_CLIENT_V2
+                      || op == P_CONTROL_HARD_RESET_CLIENT_V3) && !multi->opt.server)
                     || ((op == P_CONTROL_HARD_RESET_SERVER_V1
                          || op == P_CONTROL_HARD_RESET_SERVER_V2) && multi->opt.server))
                 {
@@ -3812,7 +3824,8 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
         /* this packet is from an as-yet untrusted source, so
          * scrutinize carefully */
 
-        if (op != P_CONTROL_HARD_RESET_CLIENT_V2)
+        if (op != P_CONTROL_HARD_RESET_CLIENT_V2
+            && op != P_CONTROL_HARD_RESET_CLIENT_V3)
         {
             /*
              * This can occur due to bogus data or DoS packets.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a2501c9b..bbc84192 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -63,9 +63,12 @@
 #define P_CONTROL_HARD_RESET_CLIENT_V2 7     /* initial key from client, forget previous state */
 #define P_CONTROL_HARD_RESET_SERVER_V2 8     /* initial key from server, forget previous state */
 
+/* indicates key_method >= 2 and client-specific tls-crypt key */
+#define P_CONTROL_HARD_RESET_CLIENT_V3 10    /* initial key from client, forget previous state */
+
 /* define the range of legal opcodes */
 #define P_FIRST_OPCODE                 1
-#define P_LAST_OPCODE                  9
+#define P_LAST_OPCODE                  10
 
 /*
  * Set the max number of acknowledgments that can "hitch a ride" on an outgoing
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..e3c852af 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -286,6 +286,8 @@ struct tls_options
     const char *config_authname;
     bool ncp_enabled;
 
+    bool tls_crypt_v2;
+
     /** TLS handshake wrapping state */
     struct tls_wrap_ctx tls_wrap;
 
-- 
2.17.1


