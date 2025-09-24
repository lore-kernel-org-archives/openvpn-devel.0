From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 22:15:56 +0200
Message-ID: <20250924201601.25304-1-gert@...1296...>
In-Reply-To: <gerrit.1758720945000.I09209ccd785cc368b2fcf467a3d211fbd41005c6@...2715...>
References: <gerrit.1758720945000.I09209ccd785cc368b2fcf467a3d211fbd41005c6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Validate DNS parameters
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

From: Lev Stipakov <lev@...515...>

This adds validation of following DNS options:

 --dns search-domains
 --dns server N resolve-domains
 --dns server N sni

 --dhcp-option DOMAIN
 --dhcp-option ADAPTER_DOMAIN_SUFFIX
 --dhcp-option DOMAIN-SEARCH

On Linux (and similar platforms), those options are written to a tmp file,
which is later sourced by a script running as root. Since options are
controlled by the server, it is possible for a malicious server to
execute script injection attack by pushing something like

 --dns search-domains x;id

in which case "id" command will be executed as a root.

On Windows, the value of DOMAIN/ADAPTER_DOMAIN_SUFFIX is passed to
a powershell script. A malicious server could push:

 --dhcp-option DOMAIN a';Restart-Computer'

and if openvpn is not using DHCP (this is the default, with dco-win driver)
and and running without interactive service, that powershell command
will be executed.

Validation is performed in a way that value only contains following
symbols:

  [A-Za-z0-9.-_\x80-\0xff]

Reported-By: Stanislav Fort <disclosure@...2935...>
CVE: 2025-10680
Change-Id: I09209ccd785cc368b2fcf467a3d211fbd41005c6
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1213
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1213
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 217f897..1247f11 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -61,6 +61,7 @@
 	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
+	domain_helper.h \
 	env_set.c env_set.h \
 	errlevel.h \
 	error.c error.h \
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 2a9e60b..d2ff670 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -30,6 +30,7 @@
 #include "socket_util.h"
 #include "options.h"
 #include "run_command.h"
+#include "domain_helper.h"
 
 #ifdef _WIN32
 #include "win32.h"
@@ -143,7 +144,7 @@
     return true;
 }
 
-void
+bool
 dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc)
 {
     /* Fast forward to the end of the list */
@@ -155,11 +156,19 @@
     /* Append all domains to the end of the list */
     while (*domains)
     {
+        char *domain = *domains++;
+        if (!validate_domain(domain))
+        {
+            return false;
+        }
+
         ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, gc);
         struct dns_domain *new = *entry;
-        new->name = *domains++;
+        new->name = domain;
         entry = &new->next;
     }
+
+    return true;
 }
 
 bool
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 6cd98f2..3dd7847 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -141,13 +141,14 @@
 struct dns_server *dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc);
 
 /**
- * Appends DNS domain parameters to a linked list.
+ * Appends safe DNS domain parameters to a linked list.
  *
  * @param   entry       Address of the first list entry pointer
  * @param   domains     Address of the first domain parameter
  * @param   gc          The gc the new list items should be allocated in
+ * @return              True if domains were appended and don't contain invalid characters
  */
-void dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc);
+bool dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc);
 
 /**
  * Parses a string IPv4 or IPv6 address and optional colon separated port,
diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h
new file mode 100644
index 0000000..f1ecf86
--- /dev/null
+++ b/src/openvpn/domain_helper.h
@@ -0,0 +1,45 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 Lev Stipakov <lev@...515...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+static inline bool
+is_allowed_domain_ascii(unsigned char c)
+{
+    return (c >= 'A' && c <= 'Z')
+           || (c >= 'a' && c <= 'z')
+           || (c >= '0' && c <= '9')
+           || c == '.' || c == '-' || c == '_' || c >= 0x80;
+}
+
+static inline bool
+validate_domain(const char *domain)
+{
+    for (const char *ch = domain; *ch; ++ch)
+    {
+        if (!is_allowed_domain_ascii((unsigned char)*ch))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f801743..f35738d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "dco.h"
 #include "options_util.h"
 #include "tun_afunix.h"
+#include "domain_helper.h"
 
 #include <ctype.h>
 
@@ -5877,8 +5878,12 @@
 {
     if (streq(p[1], "search-domains") && p[2])
     {
-        dns_domain_list_append(&options->dns_options.search_domains, &p[2],
-                               &options->dns_options.gc);
+        if (!dns_domain_list_append(&options->dns_options.search_domains, &p[2],
+                                    &options->dns_options.gc))
+        {
+            msg(msglevel, "--dns %s contain invalid characters", p[1]);
+            return false;
+        }
     }
     else if (streq(p[1], "server") && p[2] && p[3] && p[4])
     {
@@ -5906,7 +5911,11 @@
         }
         else if (streq(p[3], "resolve-domains"))
         {
-            dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
+            if (!dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc))
+            {
+                msg(msglevel, "--dns server %ld: %s contain invalid characters", priority, p[3]);
+                return false;
+            }
         }
         else if (streq(p[3], "dnssec") && !p[5])
         {
@@ -5950,6 +5959,11 @@
         }
         else if (streq(p[3], "sni") && !p[5])
         {
+            if (!validate_domain(p[4]))
+            {
+                msg(msglevel, "--dns server %ld: %s contains invalid characters", priority, p[3]);
+                return false;
+            }
             server->sni = p[4];
         }
         else
@@ -8551,11 +8565,23 @@
 
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")) && p[2] && !p[3])
         {
+            if (!validate_domain(p[2]))
+            {
+                msg(msglevel, "--dhcp-option %s contains invalid characters", p[1]);
+                goto err;
+            }
+
             dhcp->domain = p[2];
             dhcp_optional = true;
         }
         else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
+            if (!validate_domain(p[2]))
+            {
+                msg(msglevel, "--dhcp-option %s contains invalid characters", p[1]);
+                goto err;
+            }
+
             if (dhcp->domain_search_list_len < N_SEARCH_LIST_LEN)
             {
                 dhcp->domain_search_list[dhcp->domain_search_list_len++] = p[2];

