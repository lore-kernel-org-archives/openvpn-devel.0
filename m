From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 May 2017 22:07:28 +0200
Message-ID: <1494014848-20099-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't run packet_id unit tests for
	--disable-crypto builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Because there is no packet_id in those builds...  This fixes 'make check'
for --disable-crypto builds, caught by travis.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 tests/unit_tests/openvpn/Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 5d7123e..3bd382c 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -3,11 +3,11 @@ AUTOMAKE_OPTIONS = foreign
 check_PROGRAMS=
 
 if HAVE_LD_WRAP_SUPPORT
-check_PROGRAMS += argv_testdriver buffer_testdriver packet_id_testdriver
+check_PROGRAMS += argv_testdriver buffer_testdriver
 endif
 
 if ENABLE_CRYPTO
-check_PROGRAMS += tls_crypt_testdriver
+check_PROGRAMS += packet_id_testdriver tls_crypt_testdriver
 endif
 
 TESTS = $(check_PROGRAMS)
-- 
2.7.4


