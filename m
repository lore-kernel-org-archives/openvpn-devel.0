From: selva.nair@...277...
Date: Tue, 22 Jan 2019 10:50:32 -0500
Message-Id: <1548172232-11268-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] White-list pull-filter and script-security
 in interactive service
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

This allows the Windows GUI to use these options on the command
line without triggering user authorization errors.

Useful for
(i) ignoring certain pushed options such as "route-method" which
could otherwise bypass the interactive service
(ii) enforcing a safer script-security setting from the GUI

See also:
https://github.com/OpenVPN/openvpn-gui/issues/235#issuecomment-456142928

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9e1d7d2..9b01770 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -44,6 +44,8 @@ static const WCHAR *white_list[] =
     L"setenv",
     L"service",
     L"verb",
+    L"pull-filter",
+    L"script-security",
 
     NULL                                /* last value */
 };
-- 
2.6.2


