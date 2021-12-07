From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:01:54 +0100
Message-Id: <20211207170211.3275837-5-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 04/21] Fix triggering assertion of
 ks->authticated after tls_deauthenticate
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

When tls_deauthenticate is called (e.g. by management kicking of a client)
the key auth state is changed to KS_AUTH_FALSE while the key state is
still in S_GENERATED_KEYS. This triggers the assertion. Remove the assertions
and instead check that the auth state is KS_AUTH_TRUE

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 05096ee0a..8cbb129d2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3276,9 +3276,9 @@ handle_data_channel_packet(struct tls_multi *multi,
          * active side is the client which initiates connections).
          */
         if (ks->state >= S_GENERATED_KEYS && key_id == ks->key_id
+            && ks->authenticated == KS_AUTH_TRUE
             && (floated || link_socket_actual_match(from, &ks->remote_addr)))
         {
-            ASSERT(ks->authenticated == KS_AUTH_TRUE);
             if (!ks->crypto_options.key_ctx_bi.initialized)
             {
                 msg(D_MULTI_DROPPED,
@@ -3861,9 +3861,8 @@ struct key_state *tls_select_encryption_key(struct tls_multi *multi)
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        if (ks->state >= S_GENERATED_KEYS)
+        if (ks->state >= S_GENERATED_KEYS && ks->authenticated == KS_AUTH_TRUE)
         {
-            ASSERT(ks->authenticated == KS_AUTH_TRUE);
             ASSERT(ks->crypto_options.key_ctx_bi.initialized);
 
             if (!ks_select)
-- 
2.33.0


