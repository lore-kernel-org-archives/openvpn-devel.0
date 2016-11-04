From: samuli@...515...
Date: Fri,  4 Nov 2016 16:19:32 +0200
Message-Id: <1478269172-24579-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Prevent generation of duplicate
	EXPECT_IFCONFIG entries
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

Previously, if t_client.rc did not source t_client_ips.rc,
update_t_client_ips.sh would add (the same) EXPECT_IFCONFIG entries to
t_client_ips.rc on every run. With this patch update_t_client_ips.sh checks=
 if
the entry exists before adding it.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tests/update_t_client_ips.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index e7b58ba..9fd1c46 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -3,5 +3,5 @@
 # This --up script caches the IPs handed out by the test VPN server to a f=
ile
 # for later use.
=20
-echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $TOP_BUILDDIR/t_clie=
nt_ips.rc
-echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $TOP_BUILDDIR/t=
_client_ips.rc
+grep EXPECT_IFCONFIG4_$TESTNUM $TOP_BUILDDIR/t_client_ips.rc || echo "EXPE=
CT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $TOP_BUILDDIR/t_client_ips.rc
+grep EXPECT_IFCONFIG6_$TESTNUM $TOP_BUILDDIR/t_client_ips.rc || echo "EXPE=
CT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $TOP_BUILDDIR/t_client_ips=
.rc
--=20
2.1.4


