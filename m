From: Gert Doering <gert@...1296...>
Date: Mon, 19 Jan 2026 13:25:51 +0100
Message-ID: <20260119122556.15225-1-gert@...1296...>
In-Reply-To: <gerrit.1768578994000.I5ad13bc6674b3403251cc552d1f2c0f057431817@...2715...>
References: <gerrit.1768578994000.I5ad13bc6674b3403251cc552d1f2c0f057431817@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: Avoid conversion warning in
 get_addr_generic
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

We already check earlier that bits is smaller that
max_bits, so the cast is safe.

While reviewing the callers, remove some unused
variables.

Change-Id: I5ad13bc6674b3403251cc552d1f2c0f057431817
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1475
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1475
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cede758..85669e0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1144,10 +1144,7 @@
 static bool
 ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
 {
-    struct in6_addr t_addr;
-    unsigned int t_bits;
-
-    return get_ipv6_addr(ipv6_prefix_spec, &t_addr, &t_bits, M_WARN);
+    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
 }
 
 static char *
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 093f822..331249d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -72,11 +72,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Functions related to the translation of DNS names to IP addresses.
  */
@@ -180,7 +175,7 @@
 
     if (netbits)
     {
-        *netbits = bits;
+        *netbits = (unsigned int)bits;
     }
 
     /* restore '/' separator, if any */
@@ -683,6 +678,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
@@ -738,6 +738,10 @@
     bind_local(sock, addr->ai_family);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef TARGET_ANDROID
 static void
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -861,10 +865,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *act,
                      const struct addrinfo *local, bool do_listen,

