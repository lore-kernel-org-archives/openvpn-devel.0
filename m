From: Gert Doering <gert@...1296...>
Date: Wed, 18 Jun 2025 16:00:09 +0200
Message-ID: <20250618140016.2766-1-gert@...1296...>
In-Reply-To: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
References: <gerrit.1749198097000.I32effed9e273fbe8986d1f4e8da4a4d0ac216463@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Multi-socket: local_list clean-up
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Optimize the current local_list implementation
by replacing the static array with a resizable
one, as the static allocation serves no real
purpose, particularly on the client side.

Github: #682

Change-Id: I32effed9e273fbe8986d1f4e8da4a4d0ac216463
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1039
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6ea01d4..70337b1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2212,12 +2212,20 @@
     struct local_list *l = alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
 
-    if (l->len >= CONNECTION_LIST_SIZE)
+    if (l->len >= l->capacity)
     {
-        msg(msglevel, "Maximum number of 'local' options (%d) exceeded",
-            CONNECTION_LIST_SIZE);
+        const int new_cap = l->capacity + 1;
+        const size_t elem_size = sizeof(*l->array);
 
-        return NULL;
+        struct local_entry **new_array = gc_realloc(l->array, new_cap * elem_size, gc);
+        if (!new_array)
+        {
+            msg(msglevel, "Unable to process more local options: out of memory. Number of entries = %d", l->len);
+            return NULL;
+        }
+
+        l->array = new_array;
+        l->capacity = new_cap;
     }
 
     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b28ad58..46ec32b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -188,8 +188,9 @@
 
 struct local_list
 {
+    int capacity;
     int len;
-    struct local_entry *array[CONNECTION_LIST_SIZE];
+    struct local_entry **array;
 };
 
 struct connection_list

