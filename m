From: Gert Doering <gert@...1296...>
Date: Mon, 20 Apr 2026 18:59:17 +0200
Message-ID: <20260420165923.14226-1-gert@...1296...>
In-Reply-To: <gerrit.1776701747000.I974e10ec91a0b63f52387f1406ce1b49145eb0be@...2715...>
References: <gerrit.1776701747000.I974e10ec91a0b63f52387f1406ce1b49145eb0be@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco: port core/context infrastructure
 needed for backport of commit 7791f53
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

From: Ralf Lici <ralf@...2726...>

Change ovpn_dco_init() to take a reference to struct context, add a
backlink from the platform DCO contexts to the owning openvpn context,
and store the top multi context in struct context for server mode.

This prepares the tree for the follow-up backend changes from commit
7791f53 ("dco: process messages immediately after read") where Linux and
FreeBSD process DCO notifications directly from their backend read
paths.

It is part of a reworked backport of PR #945 originally proposed by
Nikolai Shelekhov <nickshv13@...2314...>.

Change-Id: I974e10ec91a0b63f52387f1406ce1b49145eb0be
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1631
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1631
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 50ebb35..334d468 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -104,11 +104,10 @@
 /**
  * Initialize the DCO context
  *
- * @param mode      the instance operating mode (P2P or multi-peer)
- * @param dco       the context to initialize
+ * @param c         the main instance context
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco);
+bool ovpn_dco_init(struct context *c);
 
 /**
  * Open/create a DCO interface
@@ -284,7 +283,7 @@
 }
 
 static inline bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 15add74..b164bd3 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -220,9 +220,11 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
-    if (open_fd(dco) < 0)
+    c->c1.tuntap->dco.c = c;
+
+    if (open_fd(&c->c1.tuntap->dco) < 0)
     {
         msg(M_ERR, "Failed to open socket");
         return false;
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index ab5891e8..e8f723e 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -57,6 +57,7 @@
     int dco_message_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
+    struct context *c;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2584b9..493fce6 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -391,9 +391,11 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco = &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case CM_TOP:
             dco->ifmode = OVPN_MODE_MP;
@@ -407,6 +409,10 @@
             ASSERT(false);
     }
 
+    /* store pointer to context as it may be required by message
+     * parsing routines
+     */
+    dco->c = c;
     ovpn_dco_init_netlink(dco);
     return true;
 }
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 5179912..cf6bdd4 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -43,6 +43,8 @@
     struct nl_cb *nl_cb;
     int status;
 
+    struct context *c;
+
     enum ovpn_mode ifmode;
 
     int ovpn_dco_id;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 0b8f831..bc465db 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -53,7 +53,7 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1476737..c2cfd24 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1882,7 +1882,7 @@
 #endif
         if (dco_enabled(&c->options))
         {
-            ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
+            ovpn_dco_init(c);
         }
 
         /* open the tun device */
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3e33b15..38c938e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -792,6 +792,7 @@
     int status;
 
     top->mode = CM_TOP;
+    top->multi = &multi;
     context_clear_2(top);
 
     /* initialize top-tunnel instance */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index f7c9ffd..8cc717b 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -466,6 +466,7 @@
     struct multi_context multi;
 
     top->mode = CM_TOP;
+    top->multi = &multi;
     context_clear_2(top);
 
     /* initialize top-tunnel instance */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 9cba1c5..3879772 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -492,6 +492,9 @@
                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
                                  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP. */
 
+    struct multi_context *multi; /**< Pointer to the main P2MP context.
+                                  *   Non-NULL only when mode == CM_TOP. */
+
     struct gc_arena gc;         /**< Garbage collection arena for
                                  *   allocations done in the scope of this
                                  *   context structure. */

