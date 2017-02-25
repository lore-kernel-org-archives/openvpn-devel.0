From: David Sommerseth <davids@...515...>
Date: Sat, 25 Feb 2017 03:02:29 +0100
Message-Id: <20170225020229.17287-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] cleanup: Remove faulty env processing
	functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The env_set_add_to_environmenti() and env_set_remove_from_environment()
functions where not used in the code at all and they would cause an
ASSERT() in setenv_str_ex() later on, as it would not allow the
struct env_set *es pointer to be NULL (misc.c:807).

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/misc.c | 51 ---------------------------------------------------
 src/openvpn/misc.h |  4 ----
 2 files changed, 55 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a2f45b6..68d0687 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -701,57 +701,6 @@ env_set_inherit(struct env_set *es, const struct env_set *src)
     }
 }
 
-void
-env_set_add_to_environment(const struct env_set *es)
-{
-    if (es)
-    {
-        struct gc_arena gc = gc_new();
-        const struct env_item *e;
-
-        e = es->list;
-
-        while (e)
-        {
-            const char *name;
-            const char *value;
-
-            if (deconstruct_name_value(e->string, &name, &value, &gc))
-            {
-                setenv_str(NULL, name, value);
-            }
-
-            e = e->next;
-        }
-        gc_free(&gc);
-    }
-}
-
-void
-env_set_remove_from_environment(const struct env_set *es)
-{
-    if (es)
-    {
-        struct gc_arena gc = gc_new();
-        const struct env_item *e;
-
-        e = es->list;
-
-        while (e)
-        {
-            const char *name;
-            const char *value;
-
-            if (deconstruct_name_value(e->string, &name, &value, &gc))
-            {
-                setenv_del(NULL, name);
-            }
-
-            e = e->next;
-        }
-        gc_free(&gc);
-    }
-}
 
 /* add/modify/delete environmental strings */
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 16be621..009767f 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -161,10 +161,6 @@ void env_set_print(int msglevel, const struct env_set *es);
 
 void env_set_inherit(struct env_set *es, const struct env_set *src);
 
-void env_set_add_to_environment(const struct env_set *es);
-
-void env_set_remove_from_environment(const struct env_set *es);
-
 /* Make arrays of strings */
 
 const char **make_env_array(const struct env_set *es,
-- 
2.11.0


