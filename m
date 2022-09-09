From: Arne Schwabe <arne@...1227...>
Date: Fri,  9 Sep 2022 21:59:00 +0200
Message-Id: <20220909195902.2011798-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Allows renegotiation only to start if
 session is fully established
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

This change makes the state machine more strict in terms of transation
that are allowed. The benefit of this change are two:

 - allows any option that might be pushed to affect renegotiation consistently
   This is a prerequisite for the upcoming secure renegotiation patch set
 - avoids corner cases of a peer (or an attacker) trying to renegotiate the
   session while the original session is not fully setup. Currently there
   there are no problems known with this but it is better to avoid the
   corner case in the first time.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 002871288..36a236fe3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3011,7 +3011,7 @@ tls_process(struct tls_multi *multi,
     ASSERT(session_id_defined(&session->session_id));
 
     /* Should we trigger a soft reset? -- new key, keeps old key for a while */
-    if (ks->state >= S_ACTIVE
+    if (ks->state >= S_GENERATED_KEYS
         && ((session->opt->renegotiate_seconds
              && now >= ks->established + session->opt->renegotiate_seconds)
             || (session->opt->renegotiate_bytes > 0
@@ -3733,9 +3733,11 @@ tls_pre_decrypt(struct tls_multi *multi,
         }
 
         /*
-         * Remote is requesting a key renegotiation
+         * Remote is requesting a key renegotiation.  We only allow renegotiation
+         * when the previous session is fully established to avoid weird corner
+         * cases.
          */
-        if (op == P_CONTROL_SOFT_RESET_V1 && TLS_AUTHENTICATED(multi, ks))
+        if (op == P_CONTROL_SOFT_RESET_V1 && ks->state >= S_GENERATED_KEYS)
         {
             if (!read_control_auth(buf, &session->tls_wrap, from,
                                    session->opt))
-- 
2.32.1 (Apple Git-133)


