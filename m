From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Jun 2021 09:10:27 +0300
Message-Id: <20210617061027.140-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 0/2] Disable OpenSSL config autoload in
 Windows
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

These two patches prevent OpenSSL from loading
config from a user-writable location, which may
pose a security risk.

Lev Stipakov (2):
  crypto_openssl.c: disable explicit initialization on Windows
  contrib/vcpkg-ports: add openssl port with --no-autoload-config option
    set

 contrib/vcpkg-ports/openssl/portfile.cmake    |  25 ++
 .../vcpkg-ports/openssl/unix/CMakeLists.txt   | 280 ++++++++++++++++++
 .../vcpkg-ports/openssl/unix/portfile.cmake   |  49 +++
 .../openssl/unix/remove-deps.cmake            |   7 +
 .../openssl/unix/vcpkg-cmake-wrapper.cmake    |  18 ++
 contrib/vcpkg-ports/openssl/usage             |   4 +
 .../openssl/uwp/EnableUWPSupport.patch        | 170 +++++++++++
 .../vcpkg-ports/openssl/uwp/make-openssl.bat  |  16 +
 .../vcpkg-ports/openssl/uwp/portfile.cmake    | 156 ++++++++++
 contrib/vcpkg-ports/openssl/vcpkg.json        |   7 +
 .../openssl/windows/portfile.cmake            | 174 +++++++++++
 .../openssl/windows/vcpkg-cmake-wrapper.cmake |  10 +
 src/openvpn/crypto_openssl.c                  |   2 +
 13 files changed, 918 insertions(+)
 create mode 100644 contrib/vcpkg-ports/openssl/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/unix/CMakeLists.txt
 create mode 100644 contrib/vcpkg-ports/openssl/unix/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/unix/remove-deps.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/unix/vcpkg-cmake-wrapper.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/usage
 create mode 100644 contrib/vcpkg-ports/openssl/uwp/EnableUWPSupport.patch
 create mode 100644 contrib/vcpkg-ports/openssl/uwp/make-openssl.bat
 create mode 100644 contrib/vcpkg-ports/openssl/uwp/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/vcpkg.json
 create mode 100644 contrib/vcpkg-ports/openssl/windows/portfile.cmake
 create mode 100644 contrib/vcpkg-ports/openssl/windows/vcpkg-cmake-wrapper.cmake

-- 
2.23.0.windows.1


