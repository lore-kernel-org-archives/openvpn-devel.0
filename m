From: Paolo Cerrito <wardragon78@...277...>
Date: Mon, 30 Mar 2020 14:44:28 +0200
Message-Id: <20200330124427.764219-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [Openvpn-Devel] [PATCH v4] Insert client connection
 data into PAM environment
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
Cc: Paolo Cerrito <paolo.cerrito@...2517...>

From: Paolo Cerrito <paolo.cerrito@...2517...>

1) changed again remote lenght, we have to consider only the lenght op
   ipv6 address into form nnnn:nnnn:nnnn:nnnn:nnnn:ddd.ddd.ddd.ddd not
   the mask, so we have max lenght of 45 plus terminator.

2) refactored calls to get_env, now we make one call to take ipv6
address, the if it's NULL, we try to get ipv4 address.

---
 src/plugins/auth-pam/auth-pam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index b55a2ecd..ae0d495a 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -115,7 +115,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
-    char remote[51]; //51 as ipv6 form n:n:n:n:n:n:d.d.d.d/mask and terminator+1
+    char remote[46]; //46 as ipv6 form n:n:n:n:n:n:d.d.d.d and + terminator \0
 
     const struct name_value_list *name_value_list;
 };
-- 
2.26.0


