From: Antonio Quartulli <a@...2181...>
Date: Tue, 21 Jul 2020 21:55:18 +0200
Message-Id: <20200721195518.14358-1-a@...2181...>
In-Reply-To: <ae3a509f-dc9f-0949-05a9-7e1f9d87d287@...2181...>
References: <ae3a509f-dc9f-0949-05a9-7e1f9d87d287@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_net.sh: drop hard dependency on
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
file is missing and no RUN_SUDO is passed via env.

While at it, reword the error message to better match the current logic
flow.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* default to sudo when no RUN_SUDO is set externally
* change warning message

 tests/t_net.sh | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index c67c3df2..eef3c5d1 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -76,10 +76,6 @@ if [ -r "${top_builddir}"/t_client.rc ]; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ]; then
     . "${srcdir}"/t_client.rc
-else
-    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
-    exit 77
 fi
 
 if [ ! -x "$openvpn" ]; then
@@ -117,18 +113,18 @@ else
 
     if [ -z "$RUN_SUDO" ]
     then
-        echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
-        echo "      must be set correctly in 't_client.rc'. SKIP." >&2
-        exit 77
+        echo "$0: no RUN_SUDO=... in t_client.rc or environment, defaulting to 'sudo'." >&2
+        echo "      if that does not work, set RUN_SUDO= correctly for your system." >&2
+        RUN_SUDO="sudo"
+    fi
+
+    # check that we can run the unit-test binary with sudo
+	if $RUN_SUDO $UNIT_TEST test
+    then
+	    echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good."
     else
-        # check that we can run the unit-test binary with sudo
-	    if $RUN_SUDO $UNIT_TEST test
-        then
-	        echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good."
-        else
-	        echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on. SKIP." >&2
-	        exit 77
-        fi
+	    echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on. SKIP." >&2
+	    exit 77
     fi
 fi
 
-- 
2.27.0


