From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 Sep 2025 15:16:09 +0200
Message-Id: <20250912131609.43444-1-frank@...2641...>
In-Reply-To: <gerrit.1757613551000.I889b53ed72efaec546a6609491fae9715726ea00@...2715...>
References: <gerrit.1757613551000.I889b53ed72efaec546a6609491fae9715726ea00@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] remove newline characters at the end of
 msg() calls
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
Cc: Gert Doering <gert@...1296...>

From: Gert Doering <gert@...1296...>

Unlike debugging with printf(), or msg() calls do not need or want
a '\n' at the end of the string.  Remove those that were overlooked.

Change-Id: I889b53ed72efaec546a6609491fae9715726ea00
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1180
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 85975ff..7db4eda 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1036,7 +1036,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
     {
-        msg(D_MULTI_DEBUG, "inotify watchers count: %d\n", hash_n_elements(m->inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify watchers count: %d", hash_n_elements(m->inotify_watchers));
     }
 #endif
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e65a3bc..ea76a08 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -1007,7 +1007,7 @@
         msg(msglevel, "PLUGIN #%d (%s)", i, prefix);
         while (l)
         {
-            msg(msglevel, "[%d] '%s' -> '%s'\n", ++count, l->name, l->value);
+            msg(msglevel, "[%d] '%s' -> '%s'", ++count, l->name, l->value);
             l = l->next;
         }
     }
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 5ea37dd..361edff 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -475,7 +475,7 @@
         default:
 #if 0
             /* could be called from socket_do_accept() with empty addr */
-            msg(M_ERR, "Bad address family: %d\n", af);
+            msg(M_ERR, "Bad address family: %d", af);
             ASSERT(0);
 #endif
             return 0;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6c3096b..29f74a2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2392,7 +2392,7 @@
     {
         if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
-            msg(M_ERR, "Can't get flags\n");
+            msg(M_ERR, "Can't get flags");
         }
         strncpynt(ifr.lifr_name, tt->actual_name, sizeof(ifr.lifr_name));
         ifr.lifr_ppa = ppa;
@@ -2403,7 +2403,7 @@
         }
         if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
-            msg(M_ERR, "Can't get flags\n");
+            msg(M_ERR, "Can't get flags");
         }
         /* Push arp module to if_fd */
         if (ioctl(if_fd, I_PUSH, "arp") < 0)
@@ -2422,18 +2422,18 @@
         /* Push arp module to ip_fd */
         if (ioctl(tt->ip_fd, I_PUSH, "arp") < 0)
         {
-            msg(M_ERR, "Can't push ARP module\n");
+            msg(M_ERR, "Can't push ARP module");
         }
 
         /* Open arp_fd */
         if ((arp_fd = open(arp_node, O_RDWR, 0)) < 0)
         {
-            msg(M_ERR, "Can't open %s\n", arp_node);
+            msg(M_ERR, "Can't open %s", arp_node);
         }
         /* Push arp module to arp_fd */
         if (ioctl(arp_fd, I_PUSH, "arp") < 0)
         {
-            msg(M_ERR, "Can't push ARP module\n");
+            msg(M_ERR, "Can't push ARP module");
         }
 
         /* Set ifname to arp */
@@ -2443,7 +2443,7 @@
         strioc_if.ic_dp = (char *)&ifr;
         if (ioctl(arp_fd, I_STR, &strioc_if) < 0)
         {
-            msg(M_ERR, "Can't set ifname to arp\n");
+            msg(M_ERR, "Can't set ifname to arp");
         }
     }
 
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 3820808..72a24b5 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -53,7 +53,7 @@
     unsigned long e;
     while ((e = ERR_get_error()))
     {
-        msg(M_WARN, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+        msg(M_WARN, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }
 
@@ -429,7 +429,7 @@
     if (derlen > (int)capacity)
     {
         ECDSA_SIG_free(ecsig);
-        msg(M_NONFATAL, "Error: DER encoded ECDSA signature is too long (%d)\n", derlen);
+        msg(M_NONFATAL, "Error: DER encoded ECDSA signature is too long (%d)", derlen);
         return 0;
     }
     derlen = i2d_ECDSA_SIG(ecsig, &buf);
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 1819ab0..168b554 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -944,7 +944,7 @@
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
                const unsigned char *tbs, size_t tbslen)
 {
-    xkey_dmsg(D_XKEY, "entry with siglen = %zu\n", *siglen);
+    xkey_dmsg(D_XKEY, "entry with siglen = %zu", *siglen);
 
     XKEY_SIGNATURE_CTX *sctx = ctx;
     ASSERT(sctx);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 0cfc952..6e83465 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -64,7 +64,7 @@
     unsigned long e;
     while ((e = ERR_get_error()))
     {
-        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+        msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }
 
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 56125df..9ba6cfc 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -52,7 +52,7 @@
     unsigned long e;
     while ((e = ERR_get_error()))
     {
-        msg(flags, "OpenSSL error %lu: %s\n", e, ERR_error_string(e, NULL));
+        msg(flags, "OpenSSL error %lu: %s", e, ERR_error_string(e, NULL));
     }
 }
 
@@ -170,7 +170,7 @@
     }
     else
     {
-        msg(M_NONFATAL, "ERROR: get_user_pass called with unknown request <%s> ignored\n", prefix);
+        msg(M_NONFATAL, "ERROR: get_user_pass called with unknown request <%s> ignored", prefix);
         ret = false;
     }
 

