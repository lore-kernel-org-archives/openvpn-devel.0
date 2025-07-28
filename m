From: Gert Doering <gert@...1296...>
Date: Mon, 28 Jul 2025 14:56:41 +0200
Message-ID: <20250728125647.26992-1-gert@...1296...>
In-Reply-To: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
References: <gerrit.1753438913000.I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] options: Simplify function
 setenv_foreign_option
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

This was relatively complex for the actual usage.
Looked at the code because of -Wconversion warnings
related to the len argument. So this should also be
gone.

Change-Id: I7efc77f63734501dfa8a8f5bed17b1a1b4e9e201
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1112
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70b5799..8757581 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1067,41 +1067,32 @@
 
 #ifndef _WIN32
 static void
-setenv_foreign_option(struct options *o, const char *argv[], int len, struct env_set *es)
+setenv_foreign_option(struct options *o, const char *option, const char *value, struct env_set *es)
 {
-    if (len > 0)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        struct buffer value = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        int i;
-        bool first = true;
-        bool good = true;
+    struct gc_arena gc = gc_new();
+    struct buffer env_name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    struct buffer env_value = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    bool good = true;
 
-        good &= buf_printf(&name, "foreign_option_%d", o->foreign_option_index + 1);
-        ++o->foreign_option_index;
-        for (i = 0; i < len; ++i)
-        {
-            if (argv[i])
-            {
-                if (!first)
-                {
-                    good &= buf_printf(&value, " ");
-                }
-                good &= buf_printf(&value, "%s", argv[i]);
-                first = false;
-            }
-        }
-        if (good)
-        {
-            setenv_str(es, BSTR(&name), BSTR(&value));
-        }
-        else
-        {
-            msg(M_WARN, "foreign_option: name/value overflow");
-        }
-        gc_free(&gc);
+    good &= buf_printf(&env_name, "foreign_option_%d", o->foreign_option_index + 1);
+    if (value)
+    {
+        good &= buf_printf(&env_value, "dhcp-option %s %s", option, value);
     }
+    else
+    {
+        good &= buf_printf(&env_value, "dhcp-option %s", option);
+    }
+    if (good)
+    {
+        setenv_str(es, BSTR(&env_name), BSTR(&env_value));
+        ++o->foreign_option_index;
+    }
+    else
+    {
+        msg(M_WARN, "foreign_option: name/value overflow");
+    }
+    gc_free(&gc);
 }
 #endif /* ifndef _WIN32 */
 
@@ -3678,15 +3669,10 @@
     else if (o->up_script && !dns_updown_user_set(dns) && !dns_updown_forced(dns))
     {
         /* Set foreign option env vars from --dns config */
-        const char *p[] = { "dhcp-option", NULL, NULL };
-        size_t p_len = sizeof(p) / sizeof(p[0]);
-
-        p[1] = "DOMAIN";
         const struct dns_domain *d = dns->search_domains;
         while (d)
         {
-            p[2] = d->name;
-            setenv_foreign_option(o, (const char **)p, p_len, es);
+            setenv_foreign_option(o, "DOMAIN", d->name, es);
             d = d->next;
         }
 
@@ -3713,17 +3699,19 @@
             {
                 for (int i = 0; i < s->addr_count; ++i)
                 {
+                    const char *option;
+                    const char *value;
                     if (s->addr[i].family == AF_INET)
                     {
-                        p[1] = "DNS";
-                        p[2] = print_in_addr_t(s->addr[i].in.a4.s_addr, IA_NET_ORDER, &gc);
+                        option = "DNS";
+                        value = print_in_addr_t(s->addr[i].in.a4.s_addr, IA_NET_ORDER, &gc);
                     }
                     else
                     {
-                        p[1] = "DNS6";
-                        p[2] = print_in6_addr(s->addr[i].in.a6, 0, &gc);
+                        option = "DNS6";
+                        value = print_in6_addr(s->addr[i].in.a6, 0, &gc);
                     }
-                    setenv_foreign_option(o, (const char **)p, p_len, es);
+                    setenv_foreign_option(o, option, value, es);
                 }
                 break;
             }
@@ -8388,7 +8376,7 @@
             goto err;
         }
 #else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-        setenv_foreign_option(options, (const char **)p, 3, es);
+        setenv_foreign_option(options, p[1], p[2], es);
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
     }
 #ifdef _WIN32
@@ -8530,7 +8518,7 @@
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        setenv_foreign_option(options, (const char **)p, 3, es);
+        setenv_foreign_option(options, p[1], p[2], es);
     }
     else if (streq(p[0], "route-method") && p[1] && !p[2])
     {

