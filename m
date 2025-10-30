From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 20:36:30 +0100
Message-ID: <20251030193638.1010-1-gert@...1296...>
In-Reply-To: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
References: <gerrit.1761756587000.I830b6b27fc3efe707e103ba629c4bfe3796a9cbe@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Ensure return value of snprintf is
 correctly checked
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

Commit 130548fe4d change the usages of openvpn_snprintf to snprintf. When
doing that conversion I did not notice that, despite the function name,
openvpn_snprintf had a different semantic for the return value.

This commit goes through all the usages of snprintf and ensures that
the return is correctly checked for overruns.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I830b6b27fc3efe707e103ba629c4bfe3796a9cbe
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1330
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1330
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2e328c3..89f0ab9 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -127,7 +127,7 @@
 {
     char prefix[256];
 
-    if (!snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -243,11 +243,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
     {
         return false;
     }
-    if (!snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
+    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
     {
         return false;
     }
@@ -280,11 +280,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
+    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
     {
         return false;
     }
-    if (!snprintf(footer, sizeof(footer), "-----END %s-----", name))
+    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
     {
         return false;
     }
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index d2ff670..539023f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -485,11 +485,13 @@
 
     if (j < 0)
     {
-        name_ok = snprintf(name, sizeof(name), format, i);
+        const int ret = snprintf(name, sizeof(name), format, i);
+        name_ok = (ret > 0 && ret < sizeof(name));
     }
     else
     {
-        name_ok = snprintf(name, sizeof(name), format, i, j);
+        const int ret = snprintf(name, sizeof(name), format, i, j);
+        name_ok = (ret > 0 && ret < sizeof(name));
     }
 
     if (!name_ok)
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 2ae71ab..1311e6f 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -334,7 +334,7 @@
     strcpy(tmpname, name);
     while (NULL != env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter));
+        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter) < tmpname_len);
         counter++;
     }
     if (counter < 1000)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index a1ffdaf..a612237 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -550,8 +550,9 @@
     {
         ++attempts;
 
-        if (!snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-                      (unsigned long)get_random(), (unsigned long)get_random()))
+        const int ret = snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
+                                 (unsigned long)get_random(), (unsigned long)get_random());
+        if (ret < 0 || ret >= sizeof(fname))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 790e50f..d4519b0 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -198,7 +198,7 @@
     size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
 
-    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, ciphername));
+    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, ciphername) < newlen);
     o->ncp_ciphers = ncp_ciphers;
 }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..0331727 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -548,7 +548,7 @@
         goto cleanup;
     }
 
-    if (!snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
+    if (snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial) >= sizeof(fn))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 472eb49..9e2aa19 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -85,8 +85,9 @@
 
         ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, "", *flags);
         if (ret <= 0
-            && !snprintf(errstr, sizeof(errstr), "Could not retrieve error string, flags=%" PRIx32,
-                         *flags))
+            && snprintf(errstr, sizeof(errstr), "Could not retrieve error string, flags=%" PRIx32,
+                        *flags)
+                   >= sizeof(errstr))
         {
             errstr[0] = '\0';
         }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3c11ec3..df29dd7 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -881,8 +881,9 @@
     char force_path[256];
     char *sysroot = get_win_sys_path();
 
-    if (!snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
-                  sysroot, sysroot, sysroot))
+    if (snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
+                 sysroot, sysroot, sysroot)
+        >= sizeof(force_path))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }

