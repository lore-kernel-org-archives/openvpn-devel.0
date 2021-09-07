From: selva.nair@...277...
Date: Tue,  7 Sep 2021 18:31:25 -0400
Message-Id: <20210907223126.8440-2-selva.nair@...277...>
In-Reply-To: <20210907223126.8440-1-selva.nair@...277...>
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 2/3] Permit unlimited connection entries
 and remotes
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

From: Selva Nair <selva.nair@...277...>

Currently we allow a max of 64 connection entries and remotes.
A larger number would allow users with 100's of independent
config files for different end points of same provider to
consolidate them to connection entries.

v2,v3: no change

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 Changes.rst           |  2 ++
 src/openvpn/options.c | 34 ++++++++++++++++++++++++++++------
 src/openvpn/options.h |  6 ++++--
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index fa5d5ffa..9b1fb294 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -4,6 +4,8 @@ Overview of changes in 2.6
 
 New features
 ------------
+Support unlimited number of connection entries and remote entries
+
 New management commands to enumerate and list remote entries
     Use ``remote-entry-count`` and ``remote-entry-get``
     commands from the management interface to get the number of
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f00b3019..38f97a39 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -888,6 +888,14 @@ init_options(struct options *o, const bool init_gc)
 void
 uninit_options(struct options *o)
 {
+    if (o->connection_list) {
+        free(o->connection_list->array);
+        CLEAR(*o->connection_list);
+    }
+    if (o->remote_list) {
+        free(o->remote_list->array);
+        CLEAR(*o->remote_list);
+    }
     if (o->gc_owned)
     {
         gc_free(&o->gc);
@@ -1946,10 +1954,17 @@ alloc_connection_entry(struct options *options, const int msglevel)
     struct connection_list *l = alloc_connection_list_if_undef(options);
     struct connection_entry *e;
 
-    if (l->len >= CONNECTION_LIST_SIZE)
+    if (l->len == l->capacity)
     {
-        msg(msglevel, "Maximum number of 'connection' options (%d) exceeded", CONNECTION_LIST_SIZE);
-        return NULL;
+        int capacity = l->capacity + CONNECTION_LIST_SIZE;
+        struct connection_entry **ce = realloc(l->array, capacity*sizeof(struct connection_entry *));
+        if (ce == NULL)
+        {
+            msg(msglevel, "Unable to process more connection options: out of memory. Number of entries = %d", l->len);
+            return NULL;
+        }
+        l->array = ce;
+        l->capacity = capacity;
     }
     ALLOC_OBJ_GC(e, struct connection_entry, &options->gc);
     l->array[l->len++] = e;
@@ -1972,10 +1987,17 @@ alloc_remote_entry(struct options *options, const int msglevel)
     struct remote_list *l = alloc_remote_list_if_undef(options);
     struct remote_entry *e;
 
-    if (l->len >= CONNECTION_LIST_SIZE)
+    if (l->len == l->capacity)
     {
-        msg(msglevel, "Maximum number of 'remote' options (%d) exceeded", CONNECTION_LIST_SIZE);
-        return NULL;
+        int capacity = l->capacity + CONNECTION_LIST_SIZE;
+        struct remote_entry **re = realloc(l->array, capacity*sizeof(struct remote_entry *));
+        if (re == NULL)
+        {
+            msg(msglevel, "Unable to process more remote options: out of memory. Number of entries = %d", l->len);
+            return NULL;
+        }
+        l->array = re;
+        l->capacity = capacity;
     }
     ALLOC_OBJ_GC(e, struct remote_entry, &options->gc);
     l->array[l->len++] = e;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0e40cb7..98977d41 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -168,15 +168,17 @@ struct remote_entry
 
 struct connection_list
 {
+    int capacity;
     int len;
     int current;
-    struct connection_entry *array[CONNECTION_LIST_SIZE];
+    struct connection_entry **array;
 };
 
 struct remote_list
 {
+    int capacity;
     int len;
-    struct remote_entry *array[CONNECTION_LIST_SIZE];
+    struct remote_entry **array;
 };
 
 enum vlan_acceptable_frames
-- 
2.20.1


