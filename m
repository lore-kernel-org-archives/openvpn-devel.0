From: Michael Karvan <michael.karvan@...277...>
Date: Sat, 16 Dec 2017 10:57:22 -0800
Message-Id: <1513450642-29687-1-git-send-email-Michael.Karvan@...277...>
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

---
 src/plugins/auth-pam/auth-pam.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index ae514d7..c64e14b 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -637,9 +637,16 @@ my_conv(int n, const struct pam_message **msg_array,
                         ret = PAM_CONV_ERR;
                     }
                     break;
+                
+                case PAM_TEXT_INFO:
+                    aresp[i].resp = strdup(up->common_name);
+                    if (aresp[i].resp == NULL)
+                    {
+                        ret = PAM_CONV_ERR;
+                    }
+                    break;
 
                 case PAM_ERROR_MSG:
-                case PAM_TEXT_INFO:
                     break;
 
                 default:
-- 
2.1.4


