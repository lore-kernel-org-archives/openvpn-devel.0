From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:46:33 +0100
Message-Id: <20211201184633.2500466-1-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/9] Cleanup crypto and use string isntead
 internal types
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

This series of commits clean up the external API of the cipher_kt/md_kt
related functions to use a simple const char* to designate the cipher
algorithm instead of using internal OpenSSL/mbed TLS types that are
a used in a typedef of cipher_kt_t/md_kt_t. This adds a little bit
of overhead to these methods but also eliminates the problem with
the free/allocate of these types in OpenSSL 3.0. None of these
methods are used in any critical path.

Additionally this series removes the cipher_length and hmac_length
fields. We do not supprot changing the length from the default and
these fields are just containing redundant data now.

Arne Schwabe (9):
  Implement optional cipher in --data-ciphers prefixed with ?
  Directly use hardcoed OPENVPN_TAG_LENGTH instead lookup
  Remove cipher_ctx_get_cipher_kt and replace with direct context calls
  Remove cipher_kt_var_key_size and remaining --keysize documentation
  Remove key_type->cipher_length field
  Remove key_type->hmac_length
  Remove cipher_kt_t and change type to const char* in API
  Remove md_kt_t and change cyrpto API to use const char*
  Initialise kt_cipher even when no crypto is enabled

 Changes.rst                            |   4 +
 doc/man-sections/protocol-options.rst  |  18 +-
 src/openvpn/auth_token.c               |   6 +-
 src/openvpn/crypto.c                   | 153 +++++++-------
 src/openvpn/crypto.h                   |   8 +-
 src/openvpn/crypto_backend.h           | 145 +++++++------
 src/openvpn/crypto_mbedtls.c           | 158 +++++++++-----
 src/openvpn/crypto_mbedtls.h           |   9 -
 src/openvpn/crypto_openssl.c           | 280 ++++++++++++++++++-------
 src/openvpn/crypto_openssl.h           |  24 +--
 src/openvpn/httpdigest.c               |  10 +-
 src/openvpn/init.c                     |  31 +--
 src/openvpn/ntlm.c                     |  12 +-
 src/openvpn/openssl_compat.h           |  15 ++
 src/openvpn/openvpn.h                  |   4 +-
 src/openvpn/options.c                  |   9 +-
 src/openvpn/push.c                     |   2 +-
 src/openvpn/ssl.c                      |  12 +-
 src/openvpn/ssl_mbedtls.c              |   3 +-
 src/openvpn/ssl_ncp.c                  |  48 +++--
 src/openvpn/tls_crypt.c                |   7 +-
 tests/unit_tests/openvpn/test_crypto.c |   9 +-
 tests/unit_tests/openvpn/test_ncp.c    |  17 +-
 23 files changed, 607 insertions(+), 377 deletions(-)

-- 
2.33.0


