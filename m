From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:22 +0200
Message-Id: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/7] Improve OpenSSL 3.0 support in OpenVPN
 2.5
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

We already see distros shipping 2.5 with OpenSSL 3.0 and while it builds and works,
there are number of problems. This patch addresses most of them while not
backporting the full refactoring that also allows using ciphers and digests
from providers that were not present in OpenSSL itself. Also the patches
that allow a build and make check to suceed with OpenSSL 3.0 have been backported.

Most of the commits are cherry-picked from master with small changes were needed.
The exception is the 

From Changes.rst:

Limited OpenSSL 3.0 support
    OpenSSL 3.0 support has been added. OpenSSL 3.0 support in 2.5 relies
    on the compatiblity layer and full OpenSSL 3.0 support is coming with
    OpenVPN 2.6. Only features that impact usage directly have been
    backported:

    ``--tls-cert-profile insecure``  has been added to allow selecting the
    lowest  OpenSSL security level (not recommended, use only if you must).

    OpenSSL 3.0 no longer supports the Blowfish (and other deprecated)
    algorithm by default and the new option ``--providers`` allows loading
    the legacy provider to renable these algorithms.

    The OpenSSL engine feature ``--engine`` is not enabled by default
    anymore if OpenSSL 3.0 is detected.


Arne Schwabe (7):
  Refactor early initialisation and uninitialisation into methods
  Allow loading of non default providers
  Add ubuntu 22.04 to Github Actions
  Add macos OpenSSL 3.0 and ASAN builds
  Add --with-openssl-engine autoconf option (auto|yes|no)
  Fix allowing/showing unsupported ciphers and digests
  Remove dependency on BF-CBC existance from test_ncp

 .github/workflows/build.yaml         | 34 ++++++++++--
 Changes.rst                          | 17 ++++++
 configure.ac                         | 60 ++++++++++++++++-----
 doc/man-sections/generic-options.rst | 12 +++++
 src/openvpn/crypto_backend.h         | 15 ++++++
 src/openvpn/crypto_mbedtls.c         | 13 +++++
 src/openvpn/crypto_mbedtls.h         |  3 ++
 src/openvpn/crypto_openssl.c         | 81 ++++++++++++++++++++++++++--
 src/openvpn/crypto_openssl.h         | 11 ++++
 src/openvpn/openvpn.c                | 36 +++++++++++--
 src/openvpn/options.c                |  8 +++
 src/openvpn/options.h                |  9 ++++
 tests/unit_tests/openvpn/test_ncp.c  | 10 +++-
 13 files changed, 282 insertions(+), 27 deletions(-)

-- 
2.32.0 (Apple Git-132)


