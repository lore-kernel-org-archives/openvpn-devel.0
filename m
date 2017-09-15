From: selva.nair@...277...
Date: Fri, 15 Sep 2017 00:41:03 -0400
Message-Id: <1505450463-459-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Check whether in pull_mode before warning
 about previous connection blocks
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

Eliminate the confusing message that says "explicit-exit-notify is ignored by
previous <connection> blocks" when the option is pushed.
Reported by: Eike Lohmann e.lohmann@...1294...
https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg04052.html

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a5bccf..d302bd4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6110,7 +6110,7 @@ add_option(struct options *options,
 #ifdef ENABLE_OCC
     else if (streq(p[0], "explicit-exit-notify") && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);
+        VERIFY_PERMISSION(OPT_P_GENERAL|(pull_mode? 0:OPT_P_CONNECTION)|OPT_P_EXPLICIT_NOTIFY);
         if (p[1])
         {
             options->ce.explicit_exit_notification = positive_atoi(p[1]);
-- 
2.6.2


