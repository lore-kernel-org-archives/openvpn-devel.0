From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:34:30 +0200
Message-Id: <20201023113431.26691-4-arne@...1227...>
In-Reply-To: <20201023113431.26691-1-arne@...1227...>
References: <20201023113431.26691-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/5] Remove explicit setting of peer_id to
 false
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

Almost everywhere in OpenVPN we rely on zero initialisation to
initialise all bool attributes to false.

ret is cleared by ALLOC_OBJ_CLEAR(ret, struct tls_multi);

Having this one variable treated different is a bit confusing.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7a3eb146..f6f06fa9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1219,9 +1219,6 @@ tls_multi_init(struct tls_options *tls_options)
     ret->key_scan[1] = &ret->session[TM_ACTIVE].key[KS_LAME_DUCK];
     ret->key_scan[2] = &ret->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
 
-    /* By default not use P_DATA_V2 */
-    ret->use_peer_id = false;
-
     return ret;
 }
 
-- 
2.26.2


