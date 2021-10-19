From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:06 +0200
Message-Id: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 00/21] OpenSSL 3.0 improvements for
 OpenVPN
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

This patchset removes almost all deprecation warnings from OpenVPN that
related to OpenSSL 3.0. The patchset has already been tested with users
and OpenSSL 3.0 as part of my OpenVPN for Android client.

Some patches also improve interaction with new features of OpenSSL 3.0,
mainly with providers.

The patchset does not address using a provider to replace the
RSA_method/EC_method. This is a separate patchset currently prepared by
Selva.

Arne Schwabe (21):
  [OSSL 3.0] Use new EVP_MAC API for HMAC implementation
  [OSSL 3.0] Add --with-openssl-engine autoconf option (auto|yes|no)
  [OSSL 3.0] Implement DES ECB encrypt via EVP_CIPHER api
  [OSSL 3.0] Remove DES check with OpenSSL 3.0
  [OSSL 3.0] Use EVP_PKEY based API for loading DH keys
  [OSSL 3.0] Deprecate --ecdh-curve with OpenSSL 3.0 and adjust mbed TLS
    message
  [OSSL 3.0] Remove DES key fixup code
  [OSSL 3.0] Use EVP_PKEY_get_group_name to query group name
  Refactor early initialisation and uninitialisation into methods
  [OSSL 3.0] Replace EVP_get_cipherbyname with EVP_CIPHER_fetch
  [OSSL 3.0] USe EVP_MD_get0_name instead EV_MD_name
  [OSSL 3.0] Allow loading of non default providers
  [OSSL 3.0] Remove dependency on BF-CBC existance from test_ncp
  [OSSL 3.0] Use TYPE_do_all_provided function for listing cipher/digest
  [OSSL 3.0] Do not allow CTS ciphers
  Add message when decoding PKCS12 file fails.
  Add small unit test for testing HMAC
  Fix error when BF-CBC is not available
  Add insecure tls-cert-profile options
  Add macos OpenSSL 3.0 and ASAN builds
  Always use 8192 bytes for ERR_BUF_SIZE

 .github/workflows/build.yaml           |  28 ++-
 configure.ac                           |  68 ++++--
 doc/man-sections/generic-options.rst   |  10 +
 doc/man-sections/tls-options.rst       |   6 +
 src/openvpn/crypto.c                   |  46 ----
 src/openvpn/crypto.h                   |   2 -
 src/openvpn/crypto_backend.h           |  18 +-
 src/openvpn/crypto_mbedtls.c           |  34 +--
 src/openvpn/crypto_openssl.c           | 288 +++++++++++++++++++------
 src/openvpn/crypto_openssl.h           |   8 +
 src/openvpn/error.h                    |   6 +-
 src/openvpn/ntlm.c                     |   1 -
 src/openvpn/openssl_compat.h           |  61 ++++++
 src/openvpn/openvpn.c                  |  27 ++-
 src/openvpn/options.c                  |   7 +
 src/openvpn/options.h                  |   1 +
 src/openvpn/ssl.c                      |  18 --
 src/openvpn/ssl_mbedtls.c              |   8 +-
 src/openvpn/ssl_openssl.c              |  57 +++--
 tests/unit_tests/openvpn/test_crypto.c |  61 +++++-
 tests/unit_tests/openvpn/test_ncp.c    |  13 +-
 21 files changed, 541 insertions(+), 227 deletions(-)

-- 
2.33.0


