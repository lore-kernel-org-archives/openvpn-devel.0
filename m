From: Arne Schwabe <arne@...1227...>
Date: Tue, 27 Dec 2022 15:02:44 +0100
Message-Id: <20221227140249.3524943-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Replace custom min macro and use more
 C99 style in man_remote_entry_get
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index be9a38952..7e326702f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -865,8 +865,6 @@ man_remote_entry_count(struct management *man)
     }
 }
 
-#define min(a, b) ((a) < (b) ? (a) : (b))
-
 static void
 man_remote_entry_get(struct management *man, const char *p1, const char *p2)
 {
@@ -875,12 +873,10 @@ man_remote_entry_get(struct management *man, const char *p1, const char *p2)
     if (man->persist.callback.remote_entry_get
         && man->persist.callback.remote_entry_count)
     {
-        bool res;
-        unsigned int from, to;
         unsigned int count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
 
-        from = (unsigned int) atoi(p1);
-        to = p2 ? (unsigned int) atoi(p2) : from + 1;
+        unsigned int from = (unsigned int) atoi(p1);
+        unsigned int to = p2 ? (unsigned int) atoi(p2) : from + 1;
 
         if (!strcmp(p1, "all"))
         {
@@ -888,10 +884,10 @@ man_remote_entry_get(struct management *man, const char *p1, const char *p2)
             to = count;
         }
 
-        for (unsigned int i = from; i < min(to, count); i++)
+        for (unsigned int i = from; i < min_uint(to, count); i++)
         {
             char *remote = NULL;
-            res = (*man->persist.callback.remote_entry_get)(man->persist.callback.arg, i, &remote);
+            bool res = (*man->persist.callback.remote_entry_get)(man->persist.callback.arg, i, &remote);
             if (res && remote)
             {
                 msg(M_CLIENT, "%u,%s", i, remote);
-- 
2.37.1 (Apple Git-137.1)


