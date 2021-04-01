From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:31 +0200
Message-Id: <20210401131337.3684-9-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 08/14] Remove unused function
 tls_test_auth_deferred_interval
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

This function appears to completely unused and has not been touched
since 2008.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 8c8cbe028..300a70d35 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -530,17 +530,6 @@ tls_initial_packet_received(const struct tls_multi *multi)
     return multi->n_sessions > 0;
 }
 
-static inline bool
-tls_test_auth_deferred_interval(const struct tls_multi *multi)
-{
-    if (multi)
-    {
-        const struct key_state *ks = &multi->session[TM_ACTIVE].key[KS_PRIMARY];
-        return now < ks->auth_deferred_expire;
-    }
-    return false;
-}
-
 static inline int
 tls_test_payload_len(const struct tls_multi *multi)
 {
-- 
2.30.1


