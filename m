From: Gert Doering <gert@...1296...>
Date: Wed, 23 Jul 2025 15:39:11 +0200
Message-ID: <20250723133918.19431-1-gert@...1296...>
In-Reply-To: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
References: <gerrit.1753215725000.I673a17f8c5dec66cc6c28c1ed44780a7a63927d7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] dco: only pass struct context to init
 function
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

Future DCO code will require accessing the `multi` member of the
context object.

For this reason a pointer to the context has to be stored in the
DCO context along with the rest.

At this point, rather than making the call to ovpn_dco_init()
longer with more and more parameters, pass the struct context
only and let the implementation extract the needed fields.

Change-Id: I673a17f8c5dec66cc6c28c1ed44780a7a63927d7
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1094
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index f38316d..9078417 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -104,12 +104,10 @@
 /**
  * Initialize the DCO context
  *
- * @param mode      the instance operating mode (P2P or multi-peer)
- * @param dco       the context to initialize
- * @param dev_node  device node, used on Windows to specify certain DCO adapter
+ * @param c         the main instance context
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node);
+bool ovpn_dco_init(struct context *c);
 
 /**
  * Open/create a DCO interface
@@ -297,7 +295,7 @@
 }
 
 static inline bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
     return true;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b8816c6..98d8fb5 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -165,9 +165,9 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    if (open_fd(dco) < 0)
+    if (open_fd(&c->c1.tuntap->dco) < 0)
     {
         msg(M_ERR, "Failed to open socket");
         return false;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3652a49..ec6efaa 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -438,9 +438,11 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco = &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case CM_TOP:
             dco->ifmode = OVPN_MODE_MP;
@@ -454,6 +456,10 @@
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
index 676b8cd..5e61cf1 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -65,6 +65,8 @@
     struct nl_cb *nl_cb;
     int status;
 
+    struct context *c;
+
     enum ovpn_mode ifmode;
 
     int ovpn_dco_id;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 83db739..e5a33a0 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -188,9 +188,11 @@
  * state. The server socket should be initialized later by dco_mp_start_vpn().
  */
 bool
-ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+ovpn_dco_init(struct context *c)
 {
-    switch (mode)
+    dco_context_t *dco = &c->c1.tuntap->dco;
+
+    switch (c->mode)
     {
         case MODE_POINT_TO_POINT:
             dco->ifmode = DCO_MODE_P2P;
@@ -198,7 +200,7 @@
             break;
 
         case MODE_SERVER:
-            ovpn_dco_init_mp(dco, dev_node);
+            ovpn_dco_init_mp(dco, c->options.dev_node);
             break;
 
         default:
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 77747a2..aac8a6a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2007,7 +2007,7 @@
 
         if (dco_enabled(&c->options))
         {
-            ovpn_dco_init(c->mode, &c->c1.tuntap->dco, c->options.dev_node);
+            ovpn_dco_init(c);
         }
 
         /* open the tun device */

