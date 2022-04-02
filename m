From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Apr 2022 09:08:57 +0200
Message-Id: <20220402070902.30282-3-a@...2181...>
In-Reply-To: <20220402070902.30282-1-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] networking: silence warnings about
 unused arguments
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
Cc: Antonio Quartulli <a@...2181...>

In the net_ctx_init() stub definition, arguments are not used and
therefore they should be explicitly marked to avoid compiler
warnings.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 2cbf6163..9335701e 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -42,6 +42,9 @@ typedef void *openvpn_net_iface_t;
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
+    (void)c;
+    (void)ctx;
+
     return 0;
 }
 
-- 
2.35.1


