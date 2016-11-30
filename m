From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 20:53:14 -0500
Message-Id: <1480470794-6349-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2.4 and 2.3] When parsing "--setenv opt xx
	.." make sure a third parameter is present
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

When no parameters are present, set it to "setenv opt" to trigger a
descriptive error message. And, thus get rid of the pesky NULL pointer
dereferencing.

Resolves Trac 779

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c540e05..d4ee340 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4425,6 +4425,8 @@ add_option (struct options *options,
    */
   if (streq (p[0], "setenv") && p[1] && streq (p[1], "opt") && !(permission_mask & OPT_P_PULL_MODE))
     {
+      if (!p[2])
+        p[2] = "setenv opt"; /* will trigger an error that includes setenv opt */
       p += 2;
       msglevel_fc = M_WARN;
     }
-- 
2.1.4


