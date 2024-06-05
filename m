From: Gert Doering <gert@...1296...>
Date: Wed,  5 Jun 2024 13:10:12 +0200
Message-ID: <20240605111012.3023-1-gert@...1296...>
In-Reply-To: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
References: <gerrit.1717505869000.Ic33c210f06e173a450534aa0969c57f140086655@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_user_pass: Fix building with
 --enable-systemd
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

From: Frank Lichtenheld <frank@...2641...>

Need to make sure that ENABLE_SYSTEMD is really disabled.

Change-Id: Ic33c210f06e173a450534aa0969c57f140086655
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/641
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index ac84654..b43e655 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -27,6 +27,8 @@
 #endif
 
 #undef ENABLE_SYSTEMD
+/* avoid redefining ENABLE_SYSTEMD in misc.c */
+#undef HAVE_CONFIG_H
 
 #include "syshead.h"
 #include "manage.h"

