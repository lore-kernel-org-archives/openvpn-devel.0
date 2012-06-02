From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:40 +0200
Message-Id: <1338642223-20324-6-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/8] Add the name of the context where
	option is not allowed to the error message.
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

Changes

Options error: option 'dhcp-option' cannot be used in this context

to

P:Options error: option 'dhcp-option' cannot be used in this context ([PUSH-OPTIONS])

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1d5a75b..9ed4ff5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4021,10 +4021,11 @@ void options_string_import (struct options *options,
 
 #if P2MP
 
-#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], (mask), permission_mask, option_types_found, msglevel)) goto err; }
+#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, (mask), permission_mask, option_types_found, msglevel)) goto err; }
 
 static bool
 verify_permission (const char *name,
+		   const char* file,
 		   const unsigned int type,
 		   const unsigned int allowed,
 		   unsigned int *found,
@@ -4032,7 +4033,7 @@ verify_permission (const char *name,
 {
   if (!(type & allowed))
     {
-      msg (msglevel, "option '%s' cannot be used in this context", name);
+      msg (msglevel, "option '%s' cannot be used in this context (%s)", name, file);
       return false;
     }
   else
-- 
1.7.7.5 (Apple Git-26)


