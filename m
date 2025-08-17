From: Gert Doering <gert@...1296...>
Date: Sun, 17 Aug 2025 16:39:15 +0200
Message-ID: <20250817143922.17988-1-gert@...1296...>
In-Reply-To: <gerrit.1754586150000.Id565ec17856444b580dd89edab92e9fe18d39b77@...2715...>
References: <gerrit.1754586150000.Id565ec17856444b580dd89edab92e9fe18d39b77@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Collect trivial conversion fixes
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

These are very local, simple fixes that do not
warrant their own commit.

Change-Id: Id565ec17856444b580dd89edab92e9fe18d39b77
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1140
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index af7583a..a63e543 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1901,7 +1901,7 @@
     const char *seed = "tls1-prf-test";
     const char *secret = "tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] = { 'q', 'D', '\xfe', '%', '@', 's', 'u', '\x95' };
+    uint8_t expected_out[] = { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
 
     int ret = ssl_tls1_PRF((uint8_t *)seed, (int)strlen(seed), (uint8_t *)secret,
                            (int)strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 40ae2c8..5583274 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -343,7 +343,7 @@
         const char *status = (ce->flags & CE_DISABLED) ? "disabled" : "enabled";
 
         /* space for output including 3 commas and a nul */
-        int len =
+        size_t len =
             strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) + strlen(status) + 3 + 1;
         char *out = malloc(len);
         check_malloc_return(out);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d4dc0d3..d1c41d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4957,7 +4957,7 @@
 #endif
 
 static inline bool
-space(unsigned char c)
+space(char c)
 {
     return c == '\0' || isspace(c);
 }
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 898a045..a41364a 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -158,7 +158,7 @@
         switch (pool->ipv4.type)
         {
             case IFCONFIG_POOL_30NET:
-                pool->ipv4.base = start & ~3;
+                pool->ipv4.base = start & ~3u;
                 pool_ipv4_size = (((end | 3) + 1) - pool->ipv4.base) >> 2;
                 break;
 

