From: Gert Doering <gert@...1296...>
Date: Sat, 13 Dec 2025 09:42:18 +0100
Message-ID: <20251213084225.30988-1-gert@...1296...>
In-Reply-To: <gerrit.1765563351000.I02db40d7335df7ab037ae1deb3e20f25a9b199bd@...2715...>
References: <gerrit.1765563351000.I02db40d7335df7ab037ae1deb3e20f25a9b199bd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] options: Avoid some conversion warnings
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

Just use the correct types.

Change-Id: I02db40d7335df7ab037ae1deb3e20f25a9b199bd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1440
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1440
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 24c3e92..34af0d3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1154,13 +1154,8 @@
     return get_ipv6_addr(ipv6_prefix_spec, &t_addr, &t_bits, M_WARN);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static char *
-string_substitute(const char *src, int from, int to, struct gc_arena *gc)
+string_substitute(const char *src, char from, char to, struct gc_arena *gc)
 {
     char *ret = (char *)gc_malloc(strlen(src) + 1, true, gc);
     char *dest = ret;
@@ -9306,10 +9301,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 has_udp_in_local_list(const struct options *options)
 {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 555d9dd..0561c25 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -801,7 +801,7 @@
 #define PUF_TYPE_IGNORE 2 /**< filter type to ignore a matching option */
 #define PUF_TYPE_REJECT 3 /**< filter type to reject and trigger SIGUSR1 */
     int type;
-    int size;
+    size_t size;
     char *pattern;
     struct pull_filter *next;
 };

