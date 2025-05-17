From: Gert Doering <gert@...1296...>
Date: Sat, 17 May 2025 11:26:26 +0200
Message-ID: <20250517092637.2103-1-gert@...1296...>
In-Reply-To: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v28] dns: don't publish env vars to non-dns
 scripts
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

With --dns-updown in place we no longer need --dns option related vars in
the environment for other script hooks. Code for doing that is removed and
the function to set --dns stuff made static, for internal use only.

Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/840
This mail reflects revision 28 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 19de321..221e9a9 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -350,93 +350,6 @@
     }
 }
 
-static void
-setenv_dns_option(struct env_set *es,
-                  const char *format, int i, int j,
-                  const char *value)
-{
-    char name[64];
-    bool name_ok = false;
-
-    if (j < 0)
-    {
-        name_ok = snprintf(name, sizeof(name), format, i);
-    }
-    else
-    {
-        name_ok = snprintf(name, sizeof(name), format, i, j);
-    }
-
-    if (!name_ok)
-    {
-        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
-    }
-
-    setenv_str(es, name, value);
-}
-
-void
-setenv_dns_options(const struct dns_options *o, struct env_set *es)
-{
-    struct gc_arena gc = gc_new();
-    const struct dns_server *s;
-    const struct dns_domain *d;
-    int i, j;
-
-    for (i = 1, d = o->search_domains; d != NULL; i++, d = d->next)
-    {
-        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
-    }
-
-    for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
-    {
-        for (j = 0; j < s->addr_count; ++j)
-        {
-            if (s->addr[j].family == AF_INET)
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in_addr_t(s->addr[j].in.a4.s_addr, IA_NET_ORDER, &gc));
-            }
-            else
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in6_addr(s->addr[j].in.a6, 0, &gc));
-            }
-            if (s->addr[j].port)
-            {
-                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
-                                  print_in_port_t(s->addr[j].port, &gc));
-            }
-        }
-
-        if (s->domains)
-        {
-            for (j = 1, d = s->domains; d != NULL; j++, d = d->next)
-            {
-                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i, j, d->name);
-            }
-        }
-
-        if (s->dnssec)
-        {
-            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
-                              dnssec_value(s->dnssec));
-        }
-
-        if (s->transport)
-        {
-            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
-                              transport_value(s->transport));
-        }
-        if (s->sni)
-        {
-            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
-        }
-    }
-
-    gc_free(&gc);
-}
-
 #ifdef _WIN32
 
 static void
@@ -554,6 +467,93 @@
 #else /* ifdef _WIN32 */
 
 static void
+setenv_dns_option(struct env_set *es,
+                  const char *format, int i, int j,
+                  const char *value)
+{
+    char name[64];
+    bool name_ok = false;
+
+    if (j < 0)
+    {
+        name_ok = snprintf(name, sizeof(name), format, i);
+    }
+    else
+    {
+        name_ok = snprintf(name, sizeof(name), format, i, j);
+    }
+
+    if (!name_ok)
+    {
+        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
+    }
+
+    setenv_str(es, name, value);
+}
+
+static void
+setenv_dns_options(const struct dns_options *o, struct env_set *es)
+{
+    struct gc_arena gc = gc_new();
+    const struct dns_server *s;
+    const struct dns_domain *d;
+    int i, j;
+
+    for (i = 1, d = o->search_domains; d != NULL; i++, d = d->next)
+    {
+        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+    }
+
+    for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
+    {
+        for (j = 0; j < s->addr_count; ++j)
+        {
+            if (s->addr[j].family == AF_INET)
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr, IA_NET_ORDER, &gc));
+            }
+            else
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in6_addr(s->addr[j].in.a6, 0, &gc));
+            }
+            if (s->addr[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                                  print_in_port_t(s->addr[j].port, &gc));
+            }
+        }
+
+        if (s->domains)
+        {
+            for (j = 1, d = s->domains; d != NULL; j++, d = d->next)
+            {
+                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i, j, d->name);
+            }
+        }
+
+        if (s->dnssec)
+        {
+            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
+                              dnssec_value(s->dnssec));
+        }
+
+        if (s->transport)
+        {
+            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
+                              transport_value(s->transport));
+        }
+        if (s->sni)
+        {
+            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+        }
+    }
+
+    gc_free(&gc);
+}
+
+static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct env_set *es)
 {
     setenv_str(es, "dev", tt->actual_name);
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 4cc1e73..c56d603 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -168,14 +168,6 @@
                      struct dns_updown_runner_info *duri);
 
 /**
- * Puts the DNS options into an environment set.
- *
- * @param   o           Pointer to the DNS options to set
- * @param   es          Pointer to the env_set to set the options into
- */
-void setenv_dns_options(const struct dns_options *o, struct env_set *es);
-
-/**
  * Prints configured DNS options.
  *
  * @param   o           Pointer to the DNS options to print
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3c1632f..810bb56 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1059,11 +1059,6 @@
             setenv_local_entry(es, o->ce.local_list->array[i], i+1);
         }
     }
-
-    if (!o->pull)
-    {
-        setenv_dns_options(&o->dns_options, es);
-    }
 }
 
 #ifndef _WIN32
@@ -4182,7 +4177,6 @@
     if (success)
     {
         dns_options_postprocess_pull(&o->dns_options);
-        setenv_dns_options(&o->dns_options, es);
 #if defined(_WIN32) || defined(TARGET_ANDROID)
         tuntap_options_copy_dns(o);
 #else

