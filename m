From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 19 Jun 2023 15:29:30 +0200
Message-Id: <20230619132934.76085-1-frank@...2641...>
In-Reply-To: <20230614102115.138724-1-frank@...2641...>
References: <20230614102115.138724-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/4] Various dist-related fixes
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

After this series the diff between git and the tarball
is:

Only in ../: dev-tools
Only in openvpn-2.7_git/doc: openvpn.8
Only in openvpn-2.7_git/doc: openvpn.8.html
Only in openvpn-2.7_git/doc: openvpn-examples.5
Only in openvpn-2.7_git/doc: openvpn-examples.5.html
Only in ../: .git
Only in ../: .git-blame-ignore-revs
Only in ../: .github
Only in openvpn-2.7_git/include: openvpn-plugin.h
Only in ../m4: .keep
Only in ../: .mailmap
Only in openvpn-2.7_git/sample/sample-plugins: Makefile
Only in ../: .svncommitters
Only in ../: .travis
Only in ../: .travis.yml

That looks reasonable to me.

Frank Lichtenheld (4):
  dist: add more missing files only used in the MSVC build
  vcpkg-ports/pkcs11-helper: rename patches to make file names shorter
  unit_tests: Add missing cert_data.h to source list for unit tests
  dist: Include all documentation in distribution

 Makefile.am                                   |  5 ++++-
 build/msvc/msvc-generate/Makefile.am          |  1 +
 ...ch => Fix-build-with-disable-shared.patch} |  0
 ...config-w32-vc.h.in-indicate-OpenSSL.patch} |  0
 ...make-compatibility-with-vcpkg-nmake.patch} |  0
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  6 +++---
 doc/Makefile.am                               |  9 +++++++-
 doc/doxygen/Makefile.am                       | 21 ++++++++++++++++++-
 src/openvpn/Makefile.am                       |  3 ++-
 tests/unit_tests/openvpn/Makefile.am          |  4 ++--
 10 files changed, 40 insertions(+), 9 deletions(-)
 rename contrib/vcpkg-ports/pkcs11-helper/{0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch => Fix-build-with-disable-shared.patch} (100%)
 rename contrib/vcpkg-ports/pkcs11-helper/{0002-config-w32-vc.h.in-indicate-OpenSSL.patch => config-w32-vc.h.in-indicate-OpenSSL.patch} (100%)
 rename contrib/vcpkg-ports/pkcs11-helper/{0001-nmake-compatibility-with-vcpkg-nmake.patch => nmake-compatibility-with-vcpkg-nmake.patch} (100%)

-- 
2.34.1


