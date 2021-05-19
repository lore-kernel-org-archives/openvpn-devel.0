From: Gert Doering <gert@...1296...>
Date: Wed, 19 May 2021 07:55:44 +0200
Message-Id: <20210519055544.11676-1-gert@...1296...>
In-Reply-To: <20210518143218.14520-1-gert@...1296...>
References: <20210518143218.14520-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ignore leading whitespace and comment lines
 for peer-fingerprint.
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

Inline peer-fingerprint blocks can benefit from a bit of structuring
by indentation or by putting comments ("# this is Alice's key").

v2: accept ';' and '#' as comment delimiter.  Fix tab-indent.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index db460796..037454f7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1145,8 +1145,13 @@ parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel,
     const char *line;
     while ((line = strsep(&lines, "\n")))
     {
-        /* skip empty lines */
-        if (strlen(line) == 0)
+        /* ignore leading whitespace */
+        while(isspace(*line))
+        {
+            line++;
+        }
+        /* skip empty lines and comment lines */
+        if (strlen(line) == 0 || *line == '#' || *line = ';')
         {
             continue;
         }
-- 
2.26.3


