From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Feb 2023 01:18:14 +0100
Message-Id: <20230208001819.244694-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/5] Build and run unittests with mingw in
 Github actions
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

This patch also includes the previous patches from Sevla to make the dependency
from these patches clear. Patch 0/3 can be squashed into 2/5 as it is only a minor
fixup of that patch.

The Github actions could probably made a little bit nicer, eg by static compiling
and requiring copying less dlls but since these binaries are not meant to be
distributed, I don't think it is an issue.

Arne Schwabe (3):
  Do not run check_engine test when crosscompiling
  Add missing stdint.h includes in unit tests files
  Add building unit tests with mingw to github actions

Selva Nair (2):
  Conditionally add subdir-objects option to automake
  Build unit tests in mingw Windows build

 .github/workflows/build.yaml              | 110 +++++++++++++++++++++-
 configure.ac                              |  17 +++-
 tests/Makefile.am                         |   3 +
 tests/unit_tests/engine-key/Makefile.am   |   2 +
 tests/unit_tests/example_test/Makefile.am |   2 +
 tests/unit_tests/example_test/test.c      |   1 +
 tests/unit_tests/example_test/test2.c     |   1 +
 tests/unit_tests/openvpn/Makefile.am      |  28 +++++-
 tests/unit_tests/openvpn/mock_msg.c       |   1 +
 9 files changed, 157 insertions(+), 8 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


