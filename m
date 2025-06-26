From: Gert Doering <gert@...1296...>
Date: Thu, 26 Jun 2025 11:30:00 +0200
Message-ID: <20250626093006.24789-1-gert@...1296...>
In-Reply-To: <gerrit.1750841904000.I55940b78e35f0e3d74aa6cba14378afed97a444e@...2715...>
References: <gerrit.1750841904000.I55940b78e35f0e3d74aa6cba14378afed97a444e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] run forced --dns-updown without
 --script-security
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

From: Heiko Hund <heiko@...2662...>

Due to a shortcut in the `--dns-updown force' implementation, running the
default dns-updown script required `--script-security 2'. This makes the
forced default script run without --script-security set.

Change-Id: I55940b78e35f0e3d74aa6cba14378afed97a444e
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1065
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 939ae09..ea3d91b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -264,7 +264,7 @@
     clone.servers = clone_dns_servers(o->servers, gc);
     clone.servers_prepull = clone_dns_servers(o->servers_prepull, gc);
     clone.updown = o->updown;
-    clone.user_set_updown = o->user_set_updown;
+    clone.updown_flags = o->updown_flags;
 
     return clone;
 }
@@ -580,7 +580,7 @@
     argv_printf(&argv, "%s", o->updown);
     argv_msg(M_INFO, &argv);
     int res;
-    if (o->user_set_updown)
+    if (dns_updown_user_set(o))
     {
         res = openvpn_run_script(&argv, es, S_EXITCODE, "dns updown");
     }
@@ -692,7 +692,7 @@
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)
 {
     struct dns_options *dns = &o->dns_options;
-    if (!dns->updown || (o->up_script && !dns->user_set_updown))
+    if (!dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forced(dns)))
     {
         return;
     }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 688daa7..d33f64e 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -42,13 +42,18 @@
     DNS_TRANSPORT_TLS
 };
 
+enum dns_updown_flags {
+    DNS_UPDOWN_NO_FLAGS,
+    DNS_UPDOWN_USER_SET,
+    DNS_UPDOWN_FORCED
+};
+
 struct dns_domain {
     struct dns_domain *next;
     const char *name;
 };
 
-struct dns_server_addr
-{
+struct dns_server_addr {
     union {
         struct in_addr a4;
         struct in6_addr a6;
@@ -103,7 +108,7 @@
     struct dns_server *servers;
     struct gc_arena gc;
     const char *updown;
-    bool user_set_updown;
+    enum dns_updown_flags updown_flags;
 };
 
 /**
@@ -195,4 +200,26 @@
  */
 void show_dns_options(const struct dns_options *o);
 
+/**
+ * Returns whether dns-updown is user defined
+ *
+ * @param   o           Pointer to the DNS options struct
+ */
+static inline bool
+dns_updown_user_set(const struct dns_options *o)
+{
+    return o->updown_flags == DNS_UPDOWN_USER_SET;
+}
+
+/**
+ * Returns whether dns-updown is forced to run
+ *
+ * @param   o           Pointer to the DNS options struct
+ */
+static inline bool
+dns_updown_forced(const struct dns_options *o)
+{
+    return o->updown_flags == DNS_UPDOWN_FORCED;
+}
+
 #endif /* ifndef DNS_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e26069..af097f8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3593,7 +3593,7 @@
     struct gc_arena gc = gc_new();
     struct dns_options *dns = &o->dns_options;
 
-    if (dns->servers || dns->user_set_updown)
+    if (dns->servers || dns_updown_user_set(dns) || dns_updown_forced(dns))
     {
         /* Clean up env from --dhcp-option DNS config */
         struct buffer name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
@@ -3667,7 +3667,7 @@
             }
         }
     }
-    else if (o->up_script && !dns->user_set_updown)
+    else if (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forced(dns))
     {
         /* Set foreign option env vars from --dns config */
         const char *p[] = { "dhcp-option", NULL, NULL };
@@ -8182,15 +8182,15 @@
         if (streq(p[1], "disable"))
         {
             dns->updown = NULL;
-            dns->user_set_updown = false;
+            dns->updown_flags = DNS_UPDOWN_NO_FLAGS;
         }
         else if (streq(p[1], "force"))
         {
             /* force dns-updown run, even if a --up script is defined */
-            if (dns->user_set_updown == false)
+            if (!dns_updown_user_set(dns))
             {
                 dns->updown = DEFAULT_DNS_UPDOWN;
-                dns->user_set_updown = true;
+                dns->updown_flags = DNS_UPDOWN_FORCED;
             }
         }
         else
@@ -8201,7 +8201,7 @@
                 dns->updown = NULL;
             }
             set_user_script(options, &dns->updown, p[1], p[0], false);
-            dns->user_set_updown = true;
+            dns->updown_flags = DNS_UPDOWN_USER_SET;
         }
     }
     else if (streq(p[0], "dns") && p[1])

