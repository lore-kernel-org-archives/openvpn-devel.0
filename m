From: Heiko Hund <heiko@...2662...>
Date: Fri, 27 May 2022 03:24:56 +0200
Message-Id: <20220527012457.1819262-4-heiko@...2662...>
In-Reply-To: <20220527012457.1819262-1-heiko@...2662...>
References: <20220527012457.1819262-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] rename foreign_option() and move it up
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

Add setenv_ prefix to foreign_option funtion so it is more obvious what
it does. Move it further up within options.c, so it is defined before
all future callers. Also declare all argv strings const.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/options.c | 78 +++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bc3fd6a2..9a0634a5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1013,6 +1013,44 @@ setenv_settings(struct env_set *es, const struct options *o)
     }
 }
 
+static void
+setenv_foreign_option(struct options *o, const char *argv[], int len, struct env_set *es)
+{
+    if (len > 0)
+    {
+        struct gc_arena gc = gc_new();
+        struct buffer name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+        struct buffer value = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+        int i;
+        bool first = true;
+        bool good = true;
+
+        good &= buf_printf(&name, "foreign_option_%d", o->foreign_option_index + 1);
+        ++o->foreign_option_index;
+        for (i = 0; i < len; ++i)
+        {
+            if (argv[i])
+            {
+                if (!first)
+                {
+                    good &= buf_printf(&value, " ");
+                }
+                good &= buf_printf(&value, "%s", argv[i]);
+                first = false;
+            }
+        }
+        if (good)
+        {
+            setenv_str(es, BSTR(&name), BSTR(&value));
+        }
+        else
+        {
+            msg(M_WARN, "foreign_option: name/value overflow");
+        }
+        gc_free(&gc);
+    }
+}
+
 static in_addr_t
 get_ip_addr(const char *ip_string, int msglevel, bool *error)
 {
@@ -4378,44 +4416,6 @@ options_string_extract_option(const char *options_string, const char *opt_name,
     return ret;
 }
 
-static void
-foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
-{
-    if (len > 0)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        struct buffer value = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
-        int i;
-        bool first = true;
-        bool good = true;
-
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
-    }
-}
-
 #ifdef _WIN32
 /**
  * Parses --windows-driver config option
@@ -8014,7 +8014,7 @@ add_option(struct options *options,
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_IPWIN32);
-        foreign_option(options, p, 3, es);
+        setenv_foreign_option(options, (const char **)p, 3, es);
     }
     else if (streq(p[0], "route-method") && p[1] && !p[2]) /* ignore when pushed to non-Windows OS */
     {
-- 
2.32.0


