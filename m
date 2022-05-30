From: Arne Schwabe <arne@...1227...>
Date: Tue, 31 May 2022 00:41:49 +0200
Message-Id: <20220530224149.201883-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove useless empty line from CR_RESPONSE
 message
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

The out buffer is not filled and this adds an extra empty line for
CR_RESPONSE outputs. Also make minor style fixes.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 5 +----
 src/openvpn/push.c   | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 9c07bf298..edcf0f202 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2883,17 +2883,14 @@ management_notify_client_cr_response(unsigned mda_key_id,
     {
         gc = gc_new();
 
-        struct buffer out = alloc_buf_gc(256, &gc);
         msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s",
             mdac->cid, mda_key_id, response);
         man_output_extra_env(management, "CLIENT");
-        if (management->connection.env_filter_level>0)
+        if (management->connection.env_filter_level > 0)
         {
             man_output_peer_info_env(management, mdac);
         }
         man_output_env(es, true, management->connection.env_filter_level, "CLIENT");
-        management_notify_generic(management, BSTR(&out));
-
         gc_free(&gc);
     }
 }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 7cf882d11..2332bc464 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -249,7 +249,6 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
     struct env_set *es = session->opt->es;
     int key_id = get_primary_key(c->c2.tls_multi)->key_id;
 
-
     management_notify_client_cr_response(key_id, mda, es, m);
 #endif
 #if ENABLE_PLUGIN
-- 
2.32.0 (Apple Git-132)


