From: Gert Doering <gert@...1296...>
Date: Tue, 25 Mar 2025 11:54:40 +0100
Message-ID: <20250325105447.32164-1-gert@...1296...>
In-Reply-To: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
References: <gerrit.1742224441000.I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Mention address if not unspecific on DNS
 failure
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

From: Arne Schwabe <arne@...1227...>

With the recent changes breaking configs that included lport 0, it became
apparent that having  the address family in the error message when
resolving fails, would have made diagnosis in this case and probably others
much easier.

Change-Id: I1c8fcd5bb6e1fa0020d52879eefbafdb2630e7b5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/909
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..bea5393 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -445,6 +445,22 @@
     throw_signal_soft(SIGHUP, "Preresolving failed");
 }
 
+/**
+ * Small helper function for openvpn_getaddrinfo to print the address
+ * family when resolving fails
+ */
+static const char *
+getaddrinfo_addr_family_name(int af)
+{
+    switch (af)
+    {
+        case AF_INET:  return "[AF_INET]";
+
+        case AF_INET6: return "[AF_INET6]";
+    }
+    return "";
+}
+
 /*
  * Translate IPv4/IPv6 addr or hostname into struct addrinfo
  * If resolve error, try again for resolve_retry_seconds seconds.
@@ -545,11 +561,11 @@
             print_hostname = "undefined";
         }
 
-        fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s)";
+        fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
         if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
             && !resolve_retry_seconds)
         {
-            fmt = "RESOLVE: Cannot resolve host address: %s:%s (%s) "
+            fmt = "RESOLVE: Cannot resolve host address: %s:%s%s (%s) %s"
                   "(I would have retried this name query if you had "
                   "specified the --resolv-retry option.)";
         }
@@ -639,6 +655,7 @@
                 fmt,
                 print_hostname,
                 print_servname,
+                getaddrinfo_addr_family_name(ai_family),
                 gai_strerror(status));
 
             if (--resolve_retries <= 0)

