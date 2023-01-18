From: Timo Rothenpieler <timo@...2669...>
Date: Wed, 18 Jan 2023 15:24:28 +0100
Message-Id: <20230118142428.162-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't clear capability bounding set on
 capng_change_id
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

The bounding set being empty will overpower the likes of su/sudo
and will make it impossible for any child processes to ever gain
additional privileges again.

This fixes https://github.com/OpenVPN/openvpn/issues/220

Signed-off-by: Timo Rothenpieler <timo@...2669...>
---
 src/openvpn/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 1b5fa9ad..580c4cb8 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -246,7 +246,7 @@ platform_user_group_set(const struct platform_state_user *user_state,
     /* Change to new UID/GID.
      * capng_change_id() internally calls capng_apply() to apply prepared capabilities.
      */
-    res = capng_change_id(new_uid, new_gid, CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING);
+    res = capng_change_id(new_uid, new_gid, CAPNG_DROP_SUPP_GRP);
     if (res == -4 || res == -6)
     {
         /* -4 and -6 mean failure of setuid/gid respectively.
-- 
2.34.1


