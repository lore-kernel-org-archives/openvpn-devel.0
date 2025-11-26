From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 12:40:40 +0100
Message-ID: <20251126114047.10280-1-gert@...1296...>
In-Reply-To: <gerrit.1762517501000.I750a46246c0d2447a6691e5c25c4732e3d335a63@...2715...>
References: <gerrit.1762517501000.I750a46246c0d2447a6691e5c25c4732e3d335a63@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] error: Allow status argument to
 check_status to be ssize_t
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

We only check for < 0 so no reason not to allow bigger
signed values. This makes it easier to feed result
values of read/write to it. Fixes a conversion warning
in process_outgoing_tun.

Also changes register_activity to int64_t for similar
reasons.

Change-Id: I750a46246c0d2447a6691e5c25c4732e3d335a63
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1357
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1357
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bd588d4..83eb9eb 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -621,14 +621,14 @@
  * from the OS.
  */
 void
-x_check_status(int status, const char *description, struct link_socket *sock, struct tuntap *tt)
+x_check_status(ssize_t status, const char *description, struct link_socket *sock, struct tuntap *tt)
 {
     const char *extended_msg = NULL;
 
     bool crt_error = false;
     int my_errno = openvpn_errno_maybe_crt(&crt_error);
 
-    msg(x_cs_verbose_level, "%s %s returned %d",
+    msg(x_cs_verbose_level, "%s %s returned %zd",
         sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "", description, status);
 
     if (status < 0)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 2913498..3088dbb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -307,11 +307,11 @@
 
 void set_check_status(unsigned int info_level, unsigned int verbose_level);
 
-void x_check_status(int status, const char *description, struct link_socket *sock,
+void x_check_status(ssize_t status, const char *description, struct link_socket *sock,
                     struct tuntap *tt);
 
 static inline void
-check_status(int status, const char *description, struct link_socket *sock, struct tuntap *tt)
+check_status(ssize_t status, const char *description, struct link_socket *sock, struct tuntap *tt)
 {
     if (status < 0 || check_debug_level(x_cs_verbose_level))
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f01fb4c..e592eb5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1673,6 +1673,10 @@
 #undef MAX_ICMPV6LEN
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
                   struct link_socket *sock)
@@ -1915,7 +1919,7 @@
         /*
          * Write to TUN/TAP device.
          */
-        int size;
+        ssize_t size;
 
 #ifdef LOG_RW
         if (c->c2.log_rw)
@@ -1956,7 +1960,7 @@
             if (size != BLEN(&c->c2.to_tun))
             {
                 msg(D_LINK_ERRORS,
-                    "TUN/TAP packet was destructively fragmented on write to %s (tried=%d,actual=%d)",
+                    "TUN/TAP packet was destructively fragmented on write to %s (tried=%d,actual=%zd)",
                     c->c1.tuntap->actual_name, BLEN(&c->c2.to_tun), size);
             }
 
@@ -1977,10 +1981,6 @@
     buf_reset(&c->c2.to_tun);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 pre_select(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index a575faf..3cd710e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -343,7 +343,7 @@
 }
 
 static inline void
-register_activity(struct context *c, const int size)
+register_activity(struct context *c, const int64_t size)
 {
     if (c->options.inactivity_timeout)
     {

