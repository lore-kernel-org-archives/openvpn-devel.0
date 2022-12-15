From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:42 +0100
Message-Id: <20221215190143.2107896-8-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/8] Fix corner case that might lead to
 leaked file descriptor
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

Reported-By: Trail of Bits
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d78106cdc..551606e0e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -258,6 +258,7 @@ get_user_pass_cr(struct user_pass *up,
                 msg(D_LOW, "No password found in %s authfile '%s'. Querying the management interface", prefix, auth_file);
                 if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
                 {
+                    fclose(fp);
                     return false;
                 }
             }
-- 
2.37.1 (Apple Git-137.1)


