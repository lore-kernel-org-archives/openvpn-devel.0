From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 May 2023 12:11:38 +0200
Message-Id: <20230522101138.2842378-2-arne@...1227...>
In-Reply-To: <20230522101138.2842378-1-arne@...1227...>
References: <20230517110230.2234266-1-arne@...1227...>
 <20230522101138.2842378-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/2] Fix CR_RESPONSE mangaement message
 using wrong key_id
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

the management interface expects the management key id instead
of the openvpn key id. In the past they often were the same for low ids
which hid the bug quite well.

Also do not pick uninitialised keystates (management key_id is not valid
in these).

Patch v2: do not add logging

Change-Id: If9fa1165a0e886b570b3738546ed810a32367cbe
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/push.c       | 4 ++--
 src/openvpn/ssl_common.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8e9627199..8f0a534ac 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -267,9 +267,9 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     struct man_def_auth_context *mda = session->opt->mda_context;
     struct env_set *es = session->opt->es;
-    int key_id = get_primary_key(c->c2.tls_multi)->key_id;
+    unsigned int mda_key_id = get_primary_key(c->c2.tls_multi)->mda_key_id;
 
-    management_notify_client_cr_response(key_id, mda, es, m);
+    management_notify_client_cr_response(mda_key_id, mda, es, m);
 #endif
 #if ENABLE_PLUGIN
     verify_crresponse_plugin(c->c2.tls_multi, m);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ebfd25432..be0f18746 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -733,7 +733,7 @@ get_key_by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        if (ks->mda_key_id == mda_key_id)
+        if (ks->mda_key_id == mda_key_id && ks->state > S_UNDEF)
         {
             return ks;
         }
-- 
2.39.2 (Apple Git-143)


