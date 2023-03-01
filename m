From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Mar 2023 14:53:52 +0100
Message-Id: <20230301135353.2811069-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Use key_state instead of multi for
 tls_send_payload parameter
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

Currently, this function and other parts of OpenVPN assume that
multi->session[TM_ACTIVE].key[KS_PRIMARY] is always the right session
to send control message.

This assumption was only achieve through complicated session moving and
shuffling in our state machine in the past. The old logic basically also
always assumed that control messages are always for fully authenticated
clients. This assumption was never really true (see AUTH_FAILED message) but
has been broken even more by auth-pending. Cleaning up the state machine
transitions in 7dcde87b7a broke this assumption even more.

This change now allows to specify the key_state/TLS session that is used to
send the control message.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 5 ++++-
 src/openvpn/ssl.c     | 7 ++-----
 src/openvpn/ssl.h     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 257c7c75c..9bb099097 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -372,8 +372,11 @@ send_control_channel_string_dowork(struct tls_multi *multi,
     struct gc_arena gc = gc_new();
     bool stat;
 
+    ASSERT(multi);
+    struct key_state *ks = get_key_scan(multi, 0);
+
     /* buffered cleartext write onto TLS control channel */
-    stat = tls_send_payload(multi, (uint8_t *) str, strlen(str) + 1);
+    stat = tls_send_payload(ks, (uint8_t *) str, strlen(str) + 1);
 
     msg(msglevel, "SENT CONTROL [%s]: '%s' (status=%d)",
         tls_common_name(multi, false),
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 016bdc57f..b84f23c62 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3988,18 +3988,15 @@ tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)
  */
 
 bool
-tls_send_payload(struct tls_multi *multi,
+tls_send_payload(struct key_state *ks,
                  const uint8_t *data,
                  int size)
 {
-    struct key_state *ks;
     bool ret = false;
 
     tls_clear_error();
 
-    ASSERT(multi);
-
-    ks = get_key_scan(multi, 0);
+    ASSERT(ks);
 
     if (ks->state >= S_ACTIVE)
     {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index b0a2823fb..7ea13b920 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -414,7 +414,7 @@ void ssl_put_auth_challenge(const char *cr_str);
 /*
  * Send a payload over the TLS control channel
  */
-bool tls_send_payload(struct tls_multi *multi,
+bool tls_send_payload(struct key_state *ks,
                       const uint8_t *data,
                       int size);
 
-- 
2.37.1 (Apple Git-137.1)


