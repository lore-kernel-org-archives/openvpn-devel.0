From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 16:08:18 +0200
Message-Id: <20220917140818.6155-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add common_name to the conv method. This
 allows the common_name to be accessible in PAM.
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
Cc: Michael Karvan <Michael.Karvan@...277...>

From: Michael Karvan <Michael.Karvan@...277...>

Signed-off-by: Michael Karvan <Michael.Karvan@...277...>
---
 src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 70339445..9f37c8c0 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -746,8 +746,15 @@ my_conv(int n, const struct pam_message **msg_array,
                     }
                     break;
 
-                case PAM_ERROR_MSG:
                 case PAM_TEXT_INFO:
+                    aresp[i].resp = strdup(up->common_name);
+                    if (aresp[i].resp == NULL)
+                    {
+                        ret = PAM_CONV_ERR;
+                    }
+                    break;
+
+                case PAM_ERROR_MSG:
                     break;
 
                 default:
-- 
2.35.1


