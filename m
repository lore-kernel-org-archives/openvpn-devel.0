From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 Jul 2020 16:25:57 +0200
Message-Id: <20200724142557.25204-1-arne@...1227...>
In-Reply-To: <20200717134739.21168-1-arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 10/10] Add a note that ncp-ciphers is
 replaced by data-ciphers
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

This patch adds a message that informs the user that the ncp-cipher
is renamed to data-ciphers. This should address the following concerns:

 - Users being confused by old options.
 - Nudge users to use the modern variant of an option

The man page already documents ncp-ciphers as an old name for
data-ciphers, so looking it up in the man page will also work.

Note that I did not add "deprecated old option" to this message
since I still think that eventually removing the option will only
break configs and we gain almost nothing from that.

Also still accepting the option even though we do not recommend usage of
it also follows the robustness principle of:
"be strict in what you send and tolerant in what you receive"

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5beaba0f..2cff9473 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7939,7 +7939,11 @@ add_option(struct options *options,
             && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
+        if (streq(p[0], "ncp-ciphers"))
+        {
+            msg(M_INFO, "Note: Treating option '--ncp-ciphers' as "
+                        " '--data-ciphers' (renamed in OpenVPN 2.5).");
+        }
         options->ncp_ciphers = p[1];
     }
     else if (streq(p[0], "ncp-disable") && !p[1])
-- 
2.26.2


