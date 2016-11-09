From: samuli@...515...
Date: Wed,  9 Nov 2016 14:42:05 +0200
Message-Id: <1478695325-18038-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix a logic problem in handling of --up
	scripts in t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Previously the $up variable was never reset after being set. This mean that
"--up update_t_client_ips.sh" was appended to all subsequent openvpn
command-lines, even if cached IPs existed.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tests/t_client.sh.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 076f6bd..b92cb65 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -276,6 +276,8 @@ do
     # script to generate them dynamically.
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
         up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} =
--script-security 2 --up ${srcdir}/update_t_client_ips.sh"
+    else
+        up=3D""
     fi
=20
     echo -e "\n### test run $SUF: '$test_run_title' ###\n"
--=20
2.1.4


