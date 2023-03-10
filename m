From: Heiko Hund <heiko@...2662...>
Date: Fri, 10 Mar 2023 06:08:14 +0100
Message-Id: <20230310050814.67246-3-heiko@...2662...>
In-Reply-To: <20230310050814.67246-1-heiko@...2662...>
References: <20230310050814.67246-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] dns option: make server id/priority
 optional
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

With the discovery that most of the time only one DNS server's settings
can be applied on various systems, the priority value will likely serve
no purpose most of the time.

This is to make it optional to give a --dns server priority, for cases
where you only specify one DNS server anyway. We keep the priority
because it still serves the case where you want to override pushed
server settings with local ones and when you run backends which do
support multiple server's settings like dnsmasq(8).

Change-Id: I1f97d8e5ae8f049d72db5c12ce627f601d87505c
Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/client-options.rst | 11 ++++----
 src/openvpn/dns.c                   |  9 +++++--
 src/openvpn/dns.h                   |  4 ++-
 src/openvpn/options.c               | 41 +++++++++++++++--------------
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 4555534e..df8ac433 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -168,11 +168,11 @@ configuration.
   ::
 
      dns search-domains domain [domain ...]
-     dns server n address addr[:port] [addr[:port] ...]
-     dns server n resolve-domains domain [domain ...]
-     dns server n dnssec yes|optional|no
-     dns server n transport DoH|DoT|plain
-     dns server n sni server-name
+     dns server [n] address addr[:port] [addr[:port] ...]
+     dns server [n] resolve-domains domain [domain ...]
+     dns server [n] dnssec yes|optional|no
+     dns server [n] transport DoH|DoT|plain
+     dns server [n] sni server-name
 
   The ``--dns search-domains`` directive takes one or more domain names
   to be added as DNS domain suffixes. If it is repeated multiple times within
@@ -180,6 +180,7 @@ configuration.
   a server will amend locally defined ones.
 
   The ``--dns server`` directive is used to configure DNS server ``n``.
+  If the ``n`` parameter is omitted the directive configures DNS server ``0``.
   The server id ``n`` must be a value between -128 and 127. For pushed
   DNS server options it must be between 0 and 127. The server id is used
   to group options and also for ordering the list of configured DNS servers;
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 51fca2fb..5f5e06b6 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -159,13 +159,18 @@ dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_aren
 }
 
 bool
-dns_server_priority_parse(long *priority, const char *str, bool pulled)
+dns_server_priority_parse(long *priority, size_t *subidx, const char *str, bool pulled)
 {
     char *endptr;
     const long min = pulled ? 0 : INT8_MIN;
     const long max = INT8_MAX;
     long prio = strtol(str, &endptr, 10);
-    if (*endptr != '\0' || prio < min || prio > max)
+    if (endptr == str)
+    {
+        /* No priority found, str isn't numeric */
+        *subidx -= 1;
+    }
+    else if (*endptr != '\0' || prio < min || prio > max)
     {
         return false;
     }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index e4978579..d0258f75 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -78,11 +78,13 @@ struct dns_options {
  * Parses a string DNS server priority and validates it.
  *
  * @param   priority    Pointer to where the priority should be stored
+ * @param   subidx      Pointer to the sub-option index, decremented if no
+ *                      priority value could be found
  * @param   str         Priority string to parse
  * @param   pulled      Whether this was pulled from a server
  * @return              True if priority in string is valid
  */
-bool dns_server_priority_parse(long *priority, const char *str, bool pulled);
+bool dns_server_priority_parse(long *priority, size_t *subidx, const char *str, bool pulled);
 
 /**
  * Find or create DNS server with priority in a linked list.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3e0cb62b..ea69ea7a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -510,7 +510,7 @@ static const char usage_message[] =
     "                  ignore or reject causes the option to be allowed, removed or\n"
     "                  rejected with error. May be specified multiple times, and\n"
     "                  each filter is applied in the order of appearance.\n"
-    "--dns server <n> <option> <value> [value ...] : Configure option for DNS server #n\n"
+    "--dns server [n] <option> <value> [value ...] : Configure option for DNS server #n\n"
     "                  Valid options are :\n"
     "                  address <addr[:port]> [addr[:port] ...] : server addresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domains\n"
@@ -7997,10 +7997,11 @@ add_option(struct options *options,
         {
             dns_domain_list_append(&options->dns_options.search_domains, &p[2], &options->dns_options.gc);
         }
-        else if (streq(p[1], "server") && p[2] && p[3] && p[4])
+        else if (streq(p[1], "server") && p[2] && p[3])
         {
             long priority;
-            if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+            size_t subcmd = 3; /* one after priority, if a priority was given */
+            if (!dns_server_priority_parse(&priority, &subcmd, p[2], pull_mode))
             {
                 msg(msglevel, "--dns server: invalid priority value '%s'", p[2]);
                 goto err;
@@ -8008,9 +8009,9 @@ add_option(struct options *options,
 
             struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
 
-            if (streq(p[3], "address") && p[4])
+            if (streq(p[subcmd], "address") && p[subcmd + 1])
             {
-                for (int i = 4; p[i]; ++i)
+                for (int i = subcmd + 1; p[i]; ++i)
                 {
                     if (!dns_server_addr_parse(server, p[i]))
                     {
@@ -8019,57 +8020,57 @@ add_option(struct options *options,
                     }
                 }
             }
-            else if (streq(p[3], "resolve-domains"))
+            else if (streq(p[subcmd], "resolve-domains") && p[subcmd + 1])
             {
-                dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
+                dns_domain_list_append(&server->domains, &p[subcmd + 1], &options->dns_options.gc);
             }
-            else if (streq(p[3], "dnssec") && !p[5])
+            else if (streq(p[subcmd], "dnssec") && p[subcmd + 1] && !p[subcmd + 2])
             {
-                if (streq(p[4], "yes"))
+                if (streq(p[subcmd + 1], "yes"))
                 {
                     server->dnssec = DNS_SECURITY_YES;
                 }
-                else if (streq(p[4], "no"))
+                else if (streq(p[subcmd + 1], "no"))
                 {
                     server->dnssec = DNS_SECURITY_NO;
                 }
-                else if (streq(p[4], "optional"))
+                else if (streq(p[subcmd + 1], "optional"))
                 {
                     server->dnssec = DNS_SECURITY_OPTIONAL;
                 }
                 else
                 {
-                    msg(msglevel, "--dns server %ld: malformed dnssec value '%s'", priority, p[4]);
+                    msg(msglevel, "--dns server %ld: malformed dnssec value '%s'", priority, p[subcmd + 1]);
                     goto err;
                 }
             }
-            else if (streq(p[3], "transport") && !p[5])
+            else if (streq(p[subcmd], "transport") && p[subcmd + 1] && !p[subcmd + 2])
             {
-                if (streq(p[4], "plain"))
+                if (streq(p[subcmd + 1], "plain"))
                 {
                     server->transport = DNS_TRANSPORT_PLAIN;
                 }
-                else if (streq(p[4], "DoH"))
+                else if (streq(p[subcmd + 1], "DoH"))
                 {
                     server->transport = DNS_TRANSPORT_HTTPS;
                 }
-                else if (streq(p[4], "DoT"))
+                else if (streq(p[subcmd + 1], "DoT"))
                 {
                     server->transport = DNS_TRANSPORT_TLS;
                 }
                 else
                 {
-                    msg(msglevel, "--dns server %ld: malformed transport value '%s'", priority, p[4]);
+                    msg(msglevel, "--dns server %ld: malformed transport value '%s'", priority, p[subcmd + 1]);
                     goto err;
                 }
             }
-            else if (streq(p[3], "sni") && !p[5])
+            else if (streq(p[subcmd], "sni") && p[subcmd + 1] && !p[subcmd + 2])
             {
-                server->sni = p[4];
+                server->sni = p[subcmd + 1];
             }
             else
             {
-                msg(msglevel, "--dns server %ld: unknown option type '%s' or missing or unknown parameter", priority, p[3]);
+                msg(msglevel, "--dns server %ld: unknown option type '%s' or missing or unknown parameter", priority, p[subcmd]);
                 goto err;
             }
         }
-- 
2.37.2


