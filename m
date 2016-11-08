From: samuli@...515...
Date: Tue,  8 Nov 2016 14:55:26 +0200
Message-Id: <1478609729-25222-2-git-send-email-samuli@...515...>
In-Reply-To: <1478609729-25222-1-git-send-email-samuli@...515...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Fix update_t_client_ips.sh for out of
	tree builds
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

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tests/t_client.rc-sample | 4 ++--
 tests/t_client.sh.in     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 59f34c7..31dfafa 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -13,8 +13,8 @@ CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/client.key"
 CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client.crt"
=20
 # Load EXPECT_IFCONFIG* parameters from cache
-if [ -r "${top_srcdir}/t_client_ips.rc" ]; then
-    . "${top_srcdir}/t_client_ips.rc"
+if [ -r "${top_builddir}/t_client_ips.rc" ]; then
+    . "${top_builddir}/t_client_ips.rc"
 else
     echo "NOTICE: missing t_client_ips.rc will be auto-generated"
 fi
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 6c81bc4..408703e 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -275,7 +275,7 @@ do
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
     # script to generate them dynamically.
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} =
--script-security 2 --up ${top_builddir}/tests/update_t_client_ips.sh"
+        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} =
--script-security 2 --up ${srcdir}/update_t_client_ips.sh"
     fi
=20
     echo -e "\n### test run $SUF: '$test_run_title' ###\n"
--=20
2.1.4


