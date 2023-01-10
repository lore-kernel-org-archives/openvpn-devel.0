From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 10 Jan 2023 18:02:57 +0100
Message-Id: <20230110170257.113527-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] check_engine_keys: make pass with OpenSSL 3
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

Not enabled by default with OpenSSL 3, so we don't
see this in our builds.
While here add missing entries to .gitignore (which
is what made me look at engine-key test in the first
place).

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .gitignore                                       | 4 ++++
 tests/unit_tests/engine-key/check_engine_keys.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 7335154f..813413fe 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,10 @@ tests/t_client-*-20??????-??????/
 t_client.rc
 t_client_ips.rc
 tests/unit_tests/**/*_testdriver
+tests/unit_tests/engine-key/client.key
+tests/unit_tests/engine-key/log.txt
+tests/unit_tests/engine-key/openssl.cnf
+tests/unit_tests/engine-key/passwd
 
 src/openvpn/openvpn
 include/openvpn-plugin.h
diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_tests/engine-key/check_engine_keys.sh
index 7e9a0e80..12dd2301 100755
--- a/tests/unit_tests/engine-key/check_engine_keys.sh
+++ b/tests/unit_tests/engine-key/check_engine_keys.sh
@@ -27,7 +27,7 @@ ${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-co
 # first off check we died because of a key mismatch.  If this doesn't
 # pass, suspect openssl of returning different messages and update the
 # test accordingly
-loggrep '(X509_check_private_key:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
+loggrep '(x509 certificate routines:(X509_check_private_key)?:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
 
 # now look for the engine prints (these are under our control)
 loggrep 'ENGINE: engine_init called' || { echo "Engine initialization not detected"; exit 1; }
-- 
2.34.1


