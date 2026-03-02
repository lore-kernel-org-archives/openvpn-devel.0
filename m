From: Gert Doering <gert@...1296...>
Date: Mon,  2 Mar 2026 16:25:45 +0100
Message-ID: <20260302152553.12035-1-gert@...1296...>
In-Reply-To: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
References: <gerrit.1768848003000.I704c560fa23c03237d0f8adc30908a617265a5a1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tls: reject incoming reneg request if
 primary key is not fully valid
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

From: Ralf Lici <ralf@...2726...>

Incoming P_CONTROL_SOFT_RESET_V1 can arrive while the active key is not
yet fully valid for renegotiation. This includes the window where we are
still waiting for auth_deferred_expire (derived from handshake/reneg
timing), as well as cases where deferred or mid-session auth later
leaves the key non-authenticated even though state is S_GENERATED_KEYS.

This patch keeps read_control_auth as the first gate, then rejects the
incoming renegotiation requests unless the primary key is KS_AUTH_TRUE
and auth_deferred_expire has passed.

Change-Id: I704c560fa23c03237d0f8adc30908a617265a5a1
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1478
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1478
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..98641a1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3747,6 +3747,20 @@
                 goto error;
             }
 
+            /*
+             * Do not allow incoming renegotiation unless our primary key is
+             * fully authenticated and past the deferred-auth/transition gate.
+             */
+            time_t auth_deferred_left = ks->auth_deferred_expire - now;
+            if (ks->authenticated != KS_AUTH_TRUE || auth_deferred_left > 0)
+            {
+                msg(D_TLS_ERRORS,
+                    "TLS Error: rejecting incoming renegotiation request for key-id %d: "
+                    "auth=%s, auth_deferred_expire in %d seconds",
+                    ks->key_id, ks_auth_name(ks->authenticated), auth_deferred_left > 0 ? (int)auth_deferred_left : 0);
+                goto error;
+            }
+
             key_state_soft_reset(session);
 
             dmsg(D_TLS_DEBUG, "TLS: received P_CONTROL_SOFT_RESET_V1 s=%d sid=%s", i,

