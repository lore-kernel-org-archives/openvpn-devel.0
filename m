From: Gert Doering <gert@...1296...>
Date: Mon, 26 Jan 2026 15:55:53 +0100
Message-ID: <20260126145558.31460-1-gert@...1296...>
In-Reply-To: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
References: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] test_openvpnserv: Make sure to include
 config.h
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

Otherwise the check for cmocka version doesn't
work. Includes the update to vcpkg in GHA since
that exposed the problem.

chore(deps): update vcpkg digest to 6d332a0

Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1488
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1488
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5f5d624..7d1574c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -49,7 +49,7 @@
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -84,7 +84,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
           vcpkgJsonGlob: '**/mingw/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest
@@ -274,7 +274,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any package)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
           vcpkgJsonGlob: '**/windows/vcpkg.json'
 
       - name: Run CMake with vcpkg.json manifest (NO TESTS)
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c
index 348de4f..45096a1 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -21,6 +21,10 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <setjmp.h>
 #include <cmocka.h>
 #include "test_common.h"

