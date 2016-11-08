From: samuli@...515...
Date: Tue,  8 Nov 2016 14:55:29 +0200
Message-Id: <1478609729-25222-5-git-send-email-samuli@...515...>
In-Reply-To: <1478609729-25222-1-git-send-email-samuli@...515...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Allow passing extra arguments to
	fping/fping6 in t_client.rc
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

This can be useful, for example, in preventing fping failures caused by ext=
ernal
network issues.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 tests/t_client.rc-sample | 1 +
 tests/t_client.sh.in     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 31dfafa..4fdea48 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -11,6 +11,7 @@ top_srcdir=3D"${top_srcdir:-..}"
 CA_CERT=3D"${top_srcdir}/sample/sample-keys/ca.crt"
 CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/client.key"
 CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client.crt"
+#FPING_EXTRA_ARGS=3D"-t 1000"
=20
 # Load EXPECT_IFCONFIG* parameters from cache
 if [ -r "${top_builddir}/t_client_ips.rc" ]; then
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 408703e..9b980cf 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -231,8 +231,8 @@ run_ping_tests()
     do
 	echo "run IPv$proto ping tests ($want), $bytes byte packets..."
=20
-	echo "$cmd -b $bytes -C 20 -p 250 -q $targetlist" >>$LOGDIR/$SUF:fping.out
-	$cmd -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
+	echo "$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist" >>$LO=
GDIR/$SUF:fping.out
+	$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$S=
UF:fping.out 2>&1
=20
 	# while OpenVPN is running, pings must succeed (want=3D'want_ok')
 	# before OpenVPN is up, pings must NOT succeed (want=3D'want_fail')
--=20
2.1.4


