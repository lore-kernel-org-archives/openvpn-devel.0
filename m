From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 03:24:57 +0200
Message-Id: <20220527012457.1819262-5-heiko@...2662...>
In-Reply-To: <20220527012457.1819262-1-heiko@...2662...>
References: <20220527012457.1819262-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] dns: also (re)place foreign dhcp
 options in env
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

Override DNS related foreign_options with values set by the --dns
option. This is done, so that scripts looking for these options continue
to work if only --dns option were pushed, or the values in the
--dhcp-options differ fron what's pushed in --dns.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/openvpn.c |  2 +-
 src/openvpn/options.c | 88 ++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/options.h |  2 +-
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index a6389fed..15e21452 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -248,7 +248,7 @@ openvpn_main(int argc, char *argv[])
             }
 
             /* sanity check on options */
-            options_postprocess(&c.options);
+            options_postprocess(&c.options, c.es);
 
             /* show all option settings */
             show_settings(&c.options);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9a0634a5..750444fe 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1381,6 +1381,80 @@ tuntap_options_copy_dns(struct options *o)
         }
     }
 }
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+static void
+foreign_options_copy_dns(struct options *o, struct env_set *es)
+{
+    const struct dns_domain *domain = o->dns_options.search_domains;
+    const struct dns_server *server = o->dns_options.servers;
+    if (!domain && !server)
+    {
+        return;
+    }
+
+    /* reset the index since we're starting all over again */
+    int opt_max = o->foreign_option_index;
+    o->foreign_option_index = 0;
+
+    for (int i = 1; i <= opt_max; ++i)
+    {
+        char name[32];
+        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", i);
+
+        const char *env_str = env_set_get(es, name);
+        const char *value = strchr(env_str, '=') + 1;
+        if ((domain && strstr(value, "dhcp-option DOMAIN-SEARCH") == value)
+            || (server && strstr(value, "dhcp-option DNS") == value))
+        {
+            setenv_del(es, name);
+        }
+        else
+        {
+            setenv_foreign_option(o, &value, 1, es);
+        }
+    }
+
+    struct gc_arena gc = gc_new();
+
+    while (server)
+    {
+        if (server->addr4_defined)
+        {
+            const char *argv[] = {
+                "dhcp-option",
+                "DNS",
+                print_in_addr_t(server->addr4.s_addr, 0, &gc)
+            };
+            setenv_foreign_option(o, argv, 3, es);
+        }
+        if (server->addr6_defined)
+        {
+            const char *argv[] = {
+                "dhcp-option",
+                "DNS6",
+                print_in6_addr(server->addr6, 0, &gc)
+            };
+            setenv_foreign_option(o, argv, 3, es);
+        }
+        server = server->next;
+    }
+    while (domain)
+    {
+        const char *argv[] = { "dhcp-option", "DOMAIN-SEARCH", domain->name };
+        setenv_foreign_option(o, argv, 3, es);
+        domain = domain->next;
+    }
+
+    gc_free(&gc);
+
+    /* remove old leftover entries */
+    while (o->foreign_option_index < opt_max)
+    {
+        char name[32];
+        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
+        setenv_del(es, name);
+    }
+}
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
 #ifndef ENABLE_SMALL
@@ -3368,7 +3442,7 @@ options_set_backwards_compatible_options(struct options *o)
 }
 
 static void
-options_postprocess_mutate(struct options *o)
+options_postprocess_mutate(struct options *o, struct env_set *es)
 {
     int i;
     /*
@@ -3462,12 +3536,14 @@ options_postprocess_mutate(struct options *o)
     {
         dns_options_preprocess_pull(&o->dns_options);
     }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
     else
     {
+#if defined(_WIN32) || defined(TARGET_ANDROID)
         tuntap_options_copy_dns(o);
-    }
+#else
+        foreign_options_copy_dns(o, es);
 #endif
+    }
     pre_connect_save(o);
 }
 
@@ -3803,9 +3879,9 @@ options_postprocess_filechecks(struct options *options)
  * options.
  */
 void
-options_postprocess(struct options *options)
+options_postprocess(struct options *options, struct env_set *es)
 {
-    options_postprocess_mutate(options);
+    options_postprocess_mutate(options, es);
     options_postprocess_verify(options);
 #ifndef ENABLE_SMALL
     options_postprocess_filechecks(options);
@@ -3826,6 +3902,8 @@ options_postprocess_pull(struct options *o, struct env_set *es)
         setenv_dns_options(&o->dns_options, es);
 #if defined(_WIN32) || defined(TARGET_ANDROID)
         tuntap_options_copy_dns(o);
+#else
+        foreign_options_copy_dns(o, es);
 #endif
     }
     return success;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2937dc3..0e50c19e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -813,7 +813,7 @@ char *options_string_extract_option(const char *options_string,
                                     const char *opt_name, struct gc_arena *gc);
 
 
-void options_postprocess(struct options *options);
+void options_postprocess(struct options *options, struct env_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *es);
 
-- 
2.32.0


