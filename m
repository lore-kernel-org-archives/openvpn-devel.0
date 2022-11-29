From: selva.nair@...277...
Date: Tue, 29 Nov 2022 13:05:34 -0500
Message-Id: <20221129180534.657529-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] pull_filer: ignore leading "spaces" in
 option names
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

It seems sometimes comma-separated pulled options have
an offending leading space. Not sure whether that is an error,
but the change here matches the behaviour of option parsing.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b7b34c9c..94cbd659 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5385,6 +5385,12 @@ apply_pull_filter(const struct options *o, char *line)
         return true;
     }
 
+    /* skip leading spaces matching the behaviour of parse_line */
+    while(*line && space(*line))
+    {
+        line++;
+    }
+
     for (f = o->pull_filter_list->head; f; f = f->next)
     {
         if (f->type == PUF_TYPE_ACCEPT && strncmp(line, f->pattern, f->size) == 0)
-- 
2.34.1


