From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  5 Mar 2025 18:17:30 +0100
Message-Id: <20250305171730.250444-1-frank@...2641...>
In-Reply-To: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
References: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Handle missing DCO peer by restarting
 the session
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

Occasionally, CMD_DEL_PEER is not delivered to userspace, preventing the
openvpn process from registering the event. To handle this case, we
check if calls to the Linux DCO module return an error, and, if so, send
a SIGUSR1 signal to reset the session.

Most DCO commands that return an error already trigger a SIGUSR1 signal
or even call _exit(1). This commit extends that behavior to include
dco_get_peer_stats_multi() and dco_get_peer_stats().

Change-Id: Ib118426c5a69256894040c69856a4003d9f4637c
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/831
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 35ceace..ed194cc 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -231,17 +231,20 @@
 /**
  * Update traffic statistics for all peers
  *
- * @param dco   DCO device context
- * @param m     the server context
+ * @param dco                   DCO device context
+ * @param m                     the server context
+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m);
+int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                             const bool raise_sigusr1_on_err);
 
 /**
  * Update traffic statistics for single peer
  *
- * @param c   instance context of the peer
+ * @param c                     instance context of the peer
+ * @param raise_sigusr1_on_err  whether to raise SIGUSR1 on error
  **/
-int dco_get_peer_stats(struct context *c);
+int dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err);
 
 /**
  * Retrieve the list of ciphers supported by the current platform
@@ -373,13 +376,14 @@
 }
 
 static inline int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     return 0;
 }
 
 static inline int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     return 0;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 0e536de..b8816c6 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -713,7 +713,8 @@
 }
 
 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
 
     struct ifdrv drv;
@@ -781,7 +782,7 @@
 }
 
 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 68c1a8d..b0a85fd 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -952,7 +952,8 @@
 }
 
 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     msg(D_DCO_DEBUG, "%s", __func__);
 
@@ -963,6 +964,14 @@
     int ret = ovpn_nl_msg_send(dco, nl_msg, dco_parse_peer_multi, m, __func__);
 
     nlmsg_free(nl_msg);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO peer"
+            "may have been deleted from the kernel without notifying "
+            "userspace. Restarting the session");
+        register_signal(m->top.sig, SIGUSR1, "dco peer stats error");
+    }
     return ret;
 }
 
@@ -1008,9 +1017,14 @@
 }
 
 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    uint32_t peer_id = c->c2.tls_multi->dco_peer_id;
+    int peer_id = c->c2.tls_multi->dco_peer_id;
+    if (peer_id == -1)
+    {
+        return 0;
+    }
+
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
 
     if (!c->c1.tuntap)
@@ -1030,6 +1044,14 @@
 
 nla_put_failure:
     nlmsg_free(nl_msg);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        msg(M_WARN, "Error retrieving DCO peer stats: the underlying DCO peer"
+            "may have been deleted from the kernel without notifying "
+            "userspace. Restarting the session");
+        register_signal(c->sig, SIGUSR1, "dco peer stats error");
+    }
     return ret;
 }
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 45cb919..8b47124 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -712,14 +712,15 @@
 }
 
 int
-dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m,
+                         const bool raise_sigusr1_on_err)
 {
     /* Not implemented. */
     return 0;
 }
 
 int
-dco_get_peer_stats(struct context *c)
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
     struct tuntap *tt = c->c1.tuntap;
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8b94469..d5c5f87 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -488,16 +488,14 @@
 static void
 check_inactivity_timeout(struct context *c)
 {
-    if (dco_enabled(&c->options) && dco_get_peer_stats(c) == 0)
+    if (dco_enabled(&c->options) && dco_get_peer_stats(c, true) == 0)
     {
         int64_t tot_bytes = c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes = tot_bytes - c->c2.inactivity_bytes;
-
         if (new_bytes > c->options.inactivity_minimum_bytes)
         {
             c->c2.inactivity_bytes = tot_bytes;
             event_timeout_reset(&c->c2.inactivity_interval);
-
             return;
         }
     }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 484042a..0e73942 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4146,8 +4146,13 @@
         counter_type dco_read_bytes = 0;
         counter_type dco_write_bytes = 0;
 
-        if (dco_enabled(&c->options) && (dco_get_peer_stats(c) == 0))
+        if (dco_enabled(&c->options))
         {
+            if (dco_get_peer_stats(c, true) < 0)
+            {
+                return;
+            }
+
             dco_read_bytes = c->c2.dco_read_bytes;
             dco_write_bytes = c->c2.dco_write_bytes;
         }
@@ -4166,7 +4171,8 @@
 void
 man_persist_client_stats(struct management *man, struct context *c)
 {
-    if (dco_enabled(&c->options) && (dco_get_peer_stats(c) == 0))
+    /* no need to raise SIGUSR1 since we are already closing the instance */
+    if (dco_enabled(&c->options) && (dco_get_peer_stats(c, false) == 0))
     {
         management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write_bytes);
     }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7ab9289..65d7ce9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -549,7 +549,10 @@
 {
     if (dco_enabled(&m->top.options))
     {
-        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+        if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, false) < 0)
+        {
+            return;
+        }
     }
 
     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->c2.dco_read_bytes);
@@ -856,7 +859,10 @@
 
         if (dco_enabled(&m->top.options))
         {
-            dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+            if (dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m, true) < 0)
+            {
+                return;
+            }
         }
 
         if (version == 1)
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 8323f0d..b0f8935 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -489,7 +489,10 @@
 
     if (dco_enabled(&c->options))
     {
-        dco_get_peer_stats(c);
+        if (dco_get_peer_stats(c, true) < 0)
+        {
+            return;
+        }
     }
 
     status_printf(so, "OpenVPN STATISTICS");

