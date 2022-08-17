From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 17 Aug 2022 22:12:23 +0200
Message-Id: <20220817201223.302-1-lstipakov@...277...>
In-Reply-To: <Yv0CHd2TYMtR9xk3@...1296...>
References: <Yv0CHd2TYMtR9xk3@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco.h: fix return type when DCO is not
 enabled
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

The correct return type for those functions is int,
so adjust return type accordingly for the cases
when DCO is not defined.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: also do "return 0" in dco_p2p_add_new_peer()

 src/openvpn/dco.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 6b5c016a..e063853c 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -292,10 +292,10 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     ASSERT(false);
 }
 
-static inline bool
+static inline int
 dco_p2p_add_new_peer(struct context *c)
 {
-    return true;
+    return 0;
 }
 
 static inline int
@@ -310,10 +310,10 @@ dco_remove_peer(struct context *c)
 {
 }
 
-static inline bool
+static inline int
 dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
 {
-    return true;
+    return 0;
 }
 
 static inline void
-- 
2.23.0.windows.1


