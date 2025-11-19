From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 22:42:34 +0100
Message-ID: <20251119214239.13629-1-gert@...1296...>
In-Reply-To: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
References: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] tun: Change return type of
 write_tun/read_tun to ssize_t
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

So we can directly give back the actual return
type from write/read. Even if we then cast it
back to int. The cast should be safe since we
also specify an int as we also put an int in
as length.

Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1376
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1376
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e592eb5..9a2c928 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1300,11 +1300,6 @@
 #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Output: c->c2.buf
  */
@@ -1331,11 +1326,11 @@
     if (c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
     {
         c->c2.buf.len =
-            read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
+            (int)read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
     }
     else
     {
-        c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
+        c->c2.buf.len = (int)read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
     }
 #endif /* ifdef _WIN32 */
 
@@ -1365,6 +1360,11 @@
     check_status(c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 90505a0..d1fc442 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1708,8 +1708,8 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>
 
-static inline int
-header_modify_read_write_return(int len)
+static inline ssize_t
+header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
     {
@@ -1721,12 +1721,7 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-static int
+static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)
@@ -1757,7 +1752,7 @@
     }
 }
 
-static int
+static ssize_t
 read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type == DEV_TYPE_TUN)
@@ -1778,26 +1773,21 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #if !defined(TARGET_DARWIN)
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
 #endif
 
-
-#endif /* defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
 tun_name_is_fixed(const char *dev)
@@ -2054,13 +2044,13 @@
     free(tt);
 }
 
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
@@ -2268,27 +2258,18 @@
     free(tt);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_SOLARIS)
 
 #ifndef TUNNEWPPA
@@ -2613,7 +2594,7 @@
     argv_free(&argv);
 }
 
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -2622,7 +2603,7 @@
     return putmsg(tt->fd, NULL, &sbuf, 0) >= 0 ? sbuf.len : -1;
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -3097,11 +3078,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
@@ -3125,7 +3101,7 @@
     gc_free(&gc);
 }
 
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver == DRIVER_UTUN)
@@ -3138,7 +3114,7 @@
     }
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver == DRIVER_UTUN)
@@ -3151,10 +3127,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_AIX)
 
 void
@@ -3277,13 +3249,13 @@
     argv_free(&argv);
 }
 
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
@@ -6329,13 +6301,13 @@
     free(tt);
 }
 
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e13f99f..77c3c09 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -274,9 +274,9 @@
 
 void close_tun_handle(struct tuntap *tt);
 
-int write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
-int read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, int persist_mode,
             const char *username, const char *groupname, const struct tuntap_options *options,

