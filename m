From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:41 +0100
Message-Id: <20221215190143.2107896-7-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/8] Remove unused gc_arena
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

Reported-By: Trail of Bits
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 3 ---
 src/openvpn/multi.c   | 2 --
 2 files changed, 5 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7924fd5c6..c04511ee1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1869,8 +1869,6 @@ process_outgoing_link(struct context *c)
 void
 process_outgoing_tun(struct context *c)
 {
-    struct gc_arena gc = gc_new();
-
     /*
      * Set up for write() call to TUN/TAP
      * device.
@@ -1956,7 +1954,6 @@ process_outgoing_tun(struct context *c)
     buf_reset(&c->c2.to_tun);
 
     perf_pop();
-    gc_free(&gc);
 }
 
 void
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 870e3fa61..fcb308151 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3497,7 +3497,6 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
 bool
 multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags)
 {
-    struct gc_arena gc = gc_new();
     bool ret = true;
 
     if (BLEN(&m->top.c2.buf) > 0)
@@ -3583,7 +3582,6 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             }
         }
     }
-    gc_free(&gc);
     return ret;
 }
 
-- 
2.37.1 (Apple Git-137.1)


