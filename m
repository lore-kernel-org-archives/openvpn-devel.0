From: samuli@...515...
Date: Tue,  8 Nov 2016 16:06:03 +0200
Message-Id: <1478613963-28077-1-git-send-email-samuli@...515...>
In-Reply-To: <1478609729-25222-3-git-send-email-samuli@...515...>
References: <1478609729-25222-3-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 2/4] Prevent generation of duplicate
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
t_client_ips.rc on every run. This patch makes update_t_client_ips.sh check=
 if
the entry exists before trying to add it.

v2: prevent partial matches of the EXCEPT_IFCONFIG variable name

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tests/update_t_client_ips.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index e7b58ba..96e3826 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -3,5 +3,14 @@
 # This --up script caches the IPs handed out by the test VPN server to a f=
ile
 # for later use.
=20
-echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $TOP_BUILDDIR/t_clie=
nt_ips.rc
-echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $TOP_BUILDDIR/t=
_client_ips.rc
+RC=3D"$TOP_BUILDDIR/t_client_ips.rc"
+
+grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+    echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $RC
+fi
+
+grep EXPECT_IFCONFIG6_$TESTNUM=3D $RC > /dev/null 2>&1
+if [ $? -ne 0 ]; then
+    echo "EXPECT_IFCONFIG6_$TESTNUM=3D$ifconfig_ipv6_local" >> $RC
+fi
--=20
2.1.4


