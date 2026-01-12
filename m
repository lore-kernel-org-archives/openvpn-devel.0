From: Gert Doering <gert@...1296...>
Date: Mon, 12 Jan 2026 19:02:56 +0100
Message-ID: <20260112180304.8742-1-gert@...1296...>
In-Reply-To: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
References: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socks: Fix wrong success check in
 socks_username_password_auth
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

From: Frank Lichtenheld <frank@...2641...>

Due to wrong boolean operator the function did not
correctly detect when the authentication failed.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#4
Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ed2d9e9..1e99c9a 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -143,7 +143,7 @@
     }
 
     /* VER = 5, SUCCESS = 0 --> auth success */
-    if (buf[0] != 5 && buf[1] != 0)
+    if (buf[0] != 5 || buf[1] != 0)
     {
         msg(D_LINK_ERRORS, "socks_username_password_auth: server refused the authentication");
         goto cleanup;

