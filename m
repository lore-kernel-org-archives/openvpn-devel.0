From: Gert Doering <gert@...1296...>
Date: Sun, 14 Sep 2025 15:51:20 +0200
Message-ID: <20250914135128.19621-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
References: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] events: Make sure rwflags are treated
 as unsigned
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

From: Frank Lichtenheld <frank@...2641...>

event_set_return.rwflags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Requires to change rwflags in proxy_connection struct as
well since those use the same flags.

Change-Id: I0272b709b907545de05bfded03a649b259ce5af6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1107
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 8422996..8a89a25 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -35,8 +35,8 @@
 #define WRITE_SHIFT 1
 
 #define EVENT_UNDEF 4
-#define EVENT_READ  (1 << READ_SHIFT)
-#define EVENT_WRITE (1 << WRITE_SHIFT)
+#define EVENT_READ  (1u << READ_SHIFT)
+#define EVENT_WRITE (1u << WRITE_SHIFT)
 
 /* event flags returned by io_wait.
  *
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index eae03e3..b4199c3 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -70,7 +70,7 @@
     struct proxy_connection *counterpart;
     struct buffer buf;
     bool buffer_initial;
-    int rwflags;
+    unsigned int rwflags;
     int sd;
     char *jfn;
 };
@@ -391,12 +391,12 @@
 }
 
 static inline void
-proxy_connection_io_requeue(struct proxy_connection *pc, const int rwflags_new,
+proxy_connection_io_requeue(struct proxy_connection *pc, const unsigned int rwflags_new,
                             struct event_set *es)
 {
     if (socket_defined(pc->sd) && pc->rwflags != rwflags_new)
     {
-        /*dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: requeue[%d] rwflags=%d", (int)pc->sd,
+        /*dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: requeue[%d] rwflags=%u", (int)pc->sd,
          * rwflags_new);*/
         event_ctl(es, pc->sd, rwflags_new, (void *)pc);
         pc->rwflags = rwflags_new;
@@ -656,7 +656,7 @@
  * Decide how the receipt of an EAGAIN status should affect our next IO queueing.
  */
 static bool
-proxy_connection_io_status(const int status, int *rwflags_pc, int *rwflags_cp)
+proxy_connection_io_status(const int status, unsigned int *rwflags_pc, unsigned int *rwflags_cp)
 {
     switch (status)
     {
@@ -687,12 +687,13 @@
  * in the proxied connection.
  */
 static int
-proxy_connection_io_dispatch(struct proxy_connection *pc, const int rwflags, struct event_set *es)
+proxy_connection_io_dispatch(struct proxy_connection *pc, const unsigned int rwflags,
+                             struct event_set *es)
 {
     const int max_transfer_per_iteration = 10000;
     struct proxy_connection *cp = pc->counterpart;
-    int rwflags_pc = pc->rwflags;
-    int rwflags_cp = cp->rwflags;
+    unsigned int rwflags_pc = pc->rwflags;
+    unsigned int rwflags_cp = cp->rwflags;
 
     ASSERT(pc->defined && cp->defined && cp->counterpart == pc);
 

