From: Antonio Quartulli <a@...2181...>
Date: Fri, 17 Jul 2020 18:02:31 +0200
Message-Id: <20200717160231.12042-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: drop hard dependency on
 t_client.rc
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
Cc: Antonio Quartulli <a@...2181...>

Right now t_net.sh depends on t_client.rc in order to source the
RUN_SUDO variable only.
However, t_client.rc is something that a few people only have configured
and thus this would result in t_net.sh almost never executed even if it
just could.

Drop dependency on t_client.rc by falling back to RUN_SUDO=sudo when the
file is missing.

The assignment is made as conditional so that a user can still override
RUN_SUDO by speciying an alternate string on the command line.

While at it, reword the error message to better match the current logic
flow.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 tests/t_net.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index c67c3df2..63732db9 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -77,9 +77,7 @@ if [ -r "${top_builddir}"/t_client.rc ]; then
 elif [ -r "${srcdir}"/t_client.rc ]; then
     . "${srcdir}"/t_client.rc
 else
-    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
-    exit 77
+    RUN_SUDO="${RUN_SUDO:-sudo}"
 fi
 
 if [ ! -x "$openvpn" ]; then
@@ -117,8 +115,7 @@ else
 
     if [ -z "$RUN_SUDO" ]
     then
-        echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
-        echo "      must be set correctly in 't_client.rc'. SKIP." >&2
+        echo "$0: using t_client.rc, but RUN_SUDO=... is not defined correctly. SKIP. " >&2
         exit 77
     else
         # check that we can run the unit-test binary with sudo
-- 
2.27.0


