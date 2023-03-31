From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 31 Mar 2023 17:42:11 +0200
Message-Id: <20230331154214.613245-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] Cleanup the pkcs11-helper vcpkg port
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

The biggest change is that this allows to build this port
with mingw, not just MSVC
(which will become important with my CMake patch that
will include mingw vcpkg builds)

Some smaller cleanups as well.

Was reviewed by Lev in Gerrit at
https://gerrit.openvpn.net/q/topic:pkcs11-helper-vcpkg-mingw

Frank Lichtenheld (3):
  vcpkg-ports/pkcs11-helper: Make compatible with mingw build
  vcpkg-ports/pkcs11-helper: Convert CONTROL to vcpkg.json
  vcpkg-ports/pkcs11-helper: reference upstream PRs in patches

 .github/workflows/build.yaml                  |  1 +
 ...to-succeed-if-configured-with-disabl.patch | 48 +++++++++++++++++++
 contrib/vcpkg-ports/pkcs11-helper/CONTROL     |  4 --
 .../pkcs11-helper-001-RFC7512.patch           |  2 +
 ...cs11-helper-002-dynamic_loader_flags.patch |  2 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  | 33 ++++++++++---
 contrib/vcpkg-ports/pkcs11-helper/vcpkg.json  |  7 +++
 contrib/vcpkg-triplets/x64-mingw-ovpn.cmake   |  8 ++++
 contrib/vcpkg-triplets/x86-mingw-ovpn.cmake   |  8 ++++
 9 files changed, 102 insertions(+), 11 deletions(-)
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0001-Allow-the-build-to-succeed-if-configured-with-disabl.patch
 delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/CONTROL
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
 create mode 100644 contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
 create mode 100644 contrib/vcpkg-triplets/x86-mingw-ovpn.cmake

-- 
2.34.1


