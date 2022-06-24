From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:51 +0200
Message-Id: <20220624083809.23487-8-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 07/25] dco: add option check - disable DCO
 if conflict is detected
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/Makefile.am             |   2 +-
 src/openvpn/dco.c                   | 149 ++++++++++++++++++++++++++++
 src/openvpn/openvpn.vcxproj         |   1 +
 src/openvpn/openvpn.vcxproj.filters |   3 +
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 src/openvpn/dco.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 91635b67..aaa1dbce 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -53,7 +53,7 @@ openvpn_SOURCES = \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
-	dco.h dco_internal.h \
+	dco.c dco.h dco_internal.h \
 	dco_linux.c dco_linux.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
new file mode 100644
index 00000000..1e45130a
--- /dev/null
+++ b/src/openvpn/dco.c
@@ -0,0 +1,149 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2022 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(ENABLE_DCO)
+
+#include "syshead.h"
+#include "dco.h"
+
+static bool
+dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
+{
+    if (ce->fragment)
+    {
+        msg(msglevel, "Note: --fragment disables data channel offload.");
+        return false;
+    }
+
+    if (ce->http_proxy_options)
+    {
+        msg(msglevel, "Note: --http-proxy disables data channel offload.");
+        return false;
+    }
+
+    if (ce->socks_proxy_server)
+    {
+        msg(msglevel, "Note: --socks-proxy disables data channel offload.");
+        return false;
+    }
+
+    return true;
+}
+
+bool
+dco_check_option_conflict(int msglevel, const struct options *o)
+{
+    if (o->tuntap_options.disable_dco)
+    {
+        /* already disabled by --disable-dco, no need to print warnings */
+        return false;
+    }
+
+    if (!dco_available(msglevel))
+    {
+        return false;
+    }
+
+    if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
+    {
+        msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
+        return false;
+    }
+
+    /* At this point the ciphers have already been normalised */
+    if (o->enable_ncp_fallback
+        && !tls_item_in_cipher_list(o->ciphername, DCO_SUPPORTED_CIPHERS))
+    {
+        msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
+            "disables data channel offload.", o->ciphername);
+        return false;
+    }
+
+    if (o->connection_list)
+    {
+        const struct connection_list *l = o->connection_list;
+        for (int i = 0; i < l->len; ++i)
+        {
+            if (!dco_check_option_conflict_ce(l->array[i], msglevel))
+            {
+                return false;
+            }
+        }
+    }
+    else
+    {
+        if (!dco_check_option_conflict_ce(&o->ce, msglevel))
+        {
+            return false;
+        }
+    }
+
+    if (o->mode == MODE_SERVER && o->topology != TOP_SUBNET)
+    {
+        msg(msglevel, "Note: NOT using '--topology subnet' disables data channel offload.");
+        return false;
+    }
+
+#if defined(USE_COMP)
+    if (o->comp.alg != COMP_ALG_UNDEF)
+    {
+        msg(msglevel, "Note: Using compression disables data channel offload.");
+
+        if (o->mode == MODE_SERVER && !(o->comp.flags & COMP_F_MIGRATE))
+        {
+            /* We can end up here from the multi.c call, only print the
+             * note if it is not already enabled */
+            msg(msglevel, "Consider using the '--compress migrate' option.");
+        }
+        return false;
+    }
+#endif
+
+    struct gc_arena gc = gc_new();
+    char *tmp_ciphers = string_alloc(o->ncp_ciphers, &gc);
+    const char *token;
+    while ((token = strsep(&tmp_ciphers, ":")))
+    {
+        if (!tls_item_in_cipher_list(token, DCO_SUPPORTED_CIPHERS))
+        {
+            msg(msglevel, "Note: cipher '%s' in --data-ciphers is not supported "
+                "by ovpn-dco, disabling data channel offload.", token);
+            gc_free(&gc);
+            return false;
+        }
+    }
+    gc_free(&gc);
+
+    return true;
+}
+
+#endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index bc1a0300..0b3db7c7 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -276,6 +276,7 @@
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
+    <ClCompile Include="dco.c" />
     <ClCompile Include="dco_linux.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 3c21a4c6..16905079 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -36,6 +36,9 @@
     <ClCompile Include="cryptoapi.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="dco_linux.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-- 
2.35.1


