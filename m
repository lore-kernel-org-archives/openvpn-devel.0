From: Kristof Provost <kprovost@...2661...>
Date: Mon, 16 May 2022 20:56:18 +0200
Message-Id: <20220516185621.6182-2-kprovost@...2661...>
In-Reply-To: <20220516185621.6182-1-kprovost@...2661...>
References: <20220516185621.6182-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] mtcp: Handle multi_create_instance()
 returning NULL
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

multi_create_instance() can fail (i.e. return NULL).
multi_create_instance_tcp() is ready for this, but called
multi_assign_peer_id() without first checking if mi was non-NULL.
multi_assign_peer_id() assumed that mi is non-NULL, dereferencing it and
causing a crash.

Move the call to multi_assign_peer_id() after the mi NULL check.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/mtcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b4445dbe..414a5676 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -124,7 +124,6 @@ multi_create_instance_tcp(struct multi_context *m)
     struct hash *hash = m->hash;
 
     mi = multi_create_instance(m, NULL);
-    multi_assign_peer_id(m, mi);
 
     if (mi)
     {
@@ -132,6 +131,8 @@ multi_create_instance_tcp(struct multi_context *m)
         const uint32_t hv = hash_value(hash, &mi->real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
 
+        multi_assign_peer_id(m, mi);
+
         he = hash_lookup_fast(hash, bucket, &mi->real, hv);
 
         if (he)
-- 
2.36.1


