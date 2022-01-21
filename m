From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 21 Jan 2022 07:22:57 +0200
Message-Id: <20220121052259.508-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 0/2] *** msvc: switch to openssl3 ***
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

These two patches add openssl3 support for msvc build.
The first one contains fixes to xkey code to make it
compilable by msvc. Second one adds openssl3 port.

Lev Stipakov (2):
  xkey: fix msvc build
  msvc: switch to openssl3

 .github/workflows/build.yaml                  |   2 +-
 .../openssl3/detect_platform.cmake            |  86 ++++++++
 contrib/vcpkg-ports/openssl3/portfile.cmake   | 204 ++++++++++++++++++
 contrib/vcpkg-ports/openssl3/usage            |  11 +
 contrib/vcpkg-ports/openssl3/vcpkg.json       |   7 +
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   2 +-
 src/openvpn/xkey_helper.c                     |   4 +-
 src/openvpn/xkey_provider.c                   |  13 +-
 8 files changed, 317 insertions(+), 12 deletions(-)
 create mode 100644 contrib/vcpkg-ports/openssl3/detect_platform.cmake
 create mode 100644 contrib/vcpkg-ports/openssl3/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl3/usage
 create mode 100644 contrib/vcpkg-ports/openssl3/vcpkg.json

-- 
2.23.0.windows.1


