From: selva.nair@...277...
Date: Fri, 15 Sep 2017 14:46:15 -0400
Message-Id: <1505501175-9016-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1505450463-459-1-git-send-email-selva.nair@...277...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Check whether in pull_mode before
 warning about previous connection blocks
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

In particular, this eliminates the message that says "explicit-exit-notify
is ignored by previous <connection> blocks" when the option is pushed.

Note: pull_mode is identified as "allowed & OPT_P_PULL_MODE" matching with the
definition in add_options().

Reported by: Eike Lohmann e.lohmann@...1294...
https://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg04052.html

v2: move the check to verify_permissions() as suggested by
Gert <gert@...1296...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a5bccf..b4613df 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4824,11 +4824,13 @@ verify_permission(const char *name,
 #ifndef ENABLE_SMALL
     /* Check if this options is allowed in connection block,
      * but we are currently not in a connection block
+     * unless this is a pushed option.
      * Parsing a connection block uses a temporary options struct without
      * connection_list
      */
 
-    if ((type & OPT_P_CONNECTION) && options->connection_list)
+    if ((type & OPT_P_CONNECTION) && options->connection_list
+        && !(allowed & OPT_P_PULL_MODE))
     {
         if (file)
         {
-- 
2.6.2


