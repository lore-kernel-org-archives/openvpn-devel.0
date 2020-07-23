From: Arne Schwabe <arne@...1227...>
Date: Thu, 23 Jul 2020 17:59:37 +0200
Message-Id: <20200723155937.1867-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Deprecate --inetd
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

This is a corner case of a corner case option. It only works with tcp,
tap and needs special configuration.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index aa7f57b5..5beaba0f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5871,6 +5871,8 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "inetd") && !p[3])
     {
+        msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
+                    "and will be removed in OpenVPN 2.6");
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (!options->inetd)
         {
-- 
2.26.2


