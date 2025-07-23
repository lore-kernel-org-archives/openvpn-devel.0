From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 08:10:25 +0200
Message-ID: <20250723061034.20240-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
References: <gerrit.1753215725000.Ibf64c681e02ac572d339d4d98e75ceb0cd417c45@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] multi: store multi_context address
 inside top instance
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

From: Antonio Quartulli <antonio@...2726...>

Future modifications to DCO require accessing the
server multi_context object.

Since it is currently a stack variable that is pointed
by no one, we'd need to pass it to all kind of functions
to ensure it can reach the DCO code.

To make the implementation simpler, it is preferable to
simply assign its address to a struct context's field.

While at it, make some multi_* functions static as they
used only inside multi.c, where they are defined.

Change-Id: Ibf64c681e02ac572d339d4d98e75ceb0cd417c45
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1093
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4696686..ec260a2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -290,9 +290,10 @@
 /*
  * Main initialization function, init multi_context object.
  */
-void
-multi_init(struct multi_context *m, struct context *t)
+static void
+multi_init(struct context *t)
 {
+    struct multi_context *m = t->multi;
     int dev = DEV_TYPE_UNDEF;
 
     msg(D_MULTI_LOW, "MULTI: multi_init called, r=%d v=%d",
@@ -706,7 +707,7 @@
 /*
  * Called on shutdown or restart.
  */
-void
+static void
 multi_uninit(struct multi_context *m)
 {
     if (m->hash)
@@ -3922,14 +3923,14 @@
     }
 }
 
-void
-multi_top_init(struct multi_context *m, struct context *top)
+static void
+multi_top_init(struct context *top)
 {
-    inherit_context_top(&m->top, top);
-    m->top.c2.buffers = init_context_buffers(&top->c2.frame);
+    inherit_context_top(&top->multi->top, top);
+    top->multi->top.c2.buffers = init_context_buffers(&top->c2.frame);
 }
 
-void
+static void
 multi_top_free(struct multi_context *m)
 {
     close_context(&m->top, -1, CC_GC_FREE);
@@ -4324,6 +4325,7 @@
     struct multi_context multi;
 
     top->mode = CM_TOP;
+    top->multi = &multi;
     context_clear_2(top);
 
     /* initialize top-tunnel instance */
@@ -4334,10 +4336,10 @@
     }
 
     /* initialize global multi_context object */
-    multi_init(&multi, top);
+    multi_init(top);
 
     /* initialize our cloned top object */
-    multi_top_init(&multi, top);
+    multi_top_init(top);
 
     /* initialize management interface */
     init_management_callback_multi(&multi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index fe9e847..8b2704c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -263,14 +263,6 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */
 
-void multi_init(struct multi_context *m, struct context *t);
-
-void multi_uninit(struct multi_context *m);
-
-void multi_top_init(struct multi_context *m, struct context *top);
-
-void multi_top_free(struct multi_context *m);
-
 struct multi_instance *multi_create_instance(struct multi_context *m, const struct mroute_addr *real,
                                              struct link_socket *sock);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3c8ce39..7d48888 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -491,6 +491,9 @@
                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
                                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */
 
+    struct multi_context *multi; /**< Pointer to the main P2MP context.
+                                  *   Non-NULL only when mode == CM_TOP. */
+
     struct gc_arena gc;         /**< Garbage collection arena for
                                  *   allocations done in the scope of this
                                  *   context structure. */

