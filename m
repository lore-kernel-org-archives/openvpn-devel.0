From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 15 Apr 2020 10:30:17 +0300
Message-Id: <20200415073017.22839-1-lstipakov@...277...>
In-Reply-To: <b6450eb9-93db-63b9-7e13-4cacbcad39c9@...1227...>
References: <b6450eb9-93db-63b9-7e13-4cacbcad39c9@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Fix illegal client float
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

There is a time frame between allocating peer-id and initializing data
channel key, which is performed on receiving push request.

If a "rogue" data channel packet arrives during that time frame from
another address and  with same peer-id, this would cause client to float
to that new address. This is because:

 - tls_pre_decrypt() sets packet length to zero if
   data channel key has not been initialized, which leads to

 - openvpn_decrypt() returns true if packet length is zero,
which leads to

 - process_incoming_link_part1() returns true, which
calls multi_process_float(), which commits float

Note that problem doesn't happen when data channel key
is initialized, since in this case openvpn_decrypt() returns false.

Fix illegal float by adding buffer length check before calling
multi_process_float().

This should fix Trac #1272.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: add comment explaning why nonzero check needed

 src/openvpn/multi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index da0aeeba..37d2a6f2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2555,7 +2555,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
             orig_buf = c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
-                if (floated)
+                /* nonzero length means that we have a valid, decrypted packed */
+                if (floated && c->c2.buf.len > 0)
                 {
                     multi_process_float(m, m->pending);
                 }
-- 
2.24.1 (Apple Git-126)


