From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 May 2023 17:50:23 +0200
Message-Id: <20230512155023.444406-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco_linux: properly close dco version file
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

Since we only call this once, it is not a bad
leak, but still.

Change-Id: Id85766738c3ece4f2d1860f7d101e4446a894aed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/dco_linux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 41540c0f..796e6f25 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1020,6 +1020,7 @@ dco_version_string(struct gc_arena *gc)
 
     if (!fgets(BSTR(&out), BCAP(&out), fp))
     {
+        fclose(fp);
         return "ERR";
     }
 
@@ -1031,6 +1032,7 @@ dco_version_string(struct gc_arena *gc)
         *nl = '\0';
     }
 
+    fclose(fp);
     return BSTR(&out);
 }
 
-- 
2.34.1


