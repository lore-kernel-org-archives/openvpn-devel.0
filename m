From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:10 -0500
Message-Id: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 00/18] External key provider for use with
 OpenSSL 3
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

From: Selva Nair <selva.nair@...277...>

The following series of patches implement a built-in
provider for interfacing OpenSSL 3.0 when external 
keys are in use.

Essentially, to intercept the sign operation, the SSL_CTX
object has to be created with properties string set to 
prioritize our provider. In the provider we implement
only keymgmt and signature operations and specify the
property string as optional. That allows all operations
we do not provide to be used from the default provider.

Same as PR#161 https://github.com/OpenVPN/openvpn/pull/161
with fixup commits in there squashed and rebased to master.

Requires OpenSSL 3.0.1 (released on Dec 14, 2021) or
OpenSSL 3.0 or 3.1 dev branch post Oct 27. 

Selva Nair (18):
  A built-in provider for using external key with OpenSSL 3.0
  Implement KEYMGMT in the xkey provider
  Implement SIGNATURE operations in xkey provider
  Implement import of custom external keys
  Initialize the xkey provider and use it in SSL context
  A helper function to import private key for management-external-key
  Enable signing via provider for management-external-key
  Add a function to encode digests with PKCS1 DigestInfo wrapper
  Allow management client to announce pss padding support
  Respect algorithm support announced by management client
  Support sending DigestSign request to management client
  Increase ERR_BUF_SIZE when management interface support is enabled
  Add a generic key loading helper function for xkey provider
  pkcs11: Interface the xkey provider with pkcs11-helper
  Enable signing using CNG through xkey provider
  Add a unit test for external key provider
  xkey-provider: Add a test for generic key load and signature
  Add xkey_provider sources and includes to MSVC project

 doc/man-sections/management-options.rst  |    8 +-
 doc/management-notes.txt                 |   22 +-
 src/openvpn/Makefile.am                  |    2 +
 src/openvpn/cryptoapi.c                  |  241 ++++-
 src/openvpn/error.h                      |    4 +-
 src/openvpn/manage.h                     |    2 +
 src/openvpn/openssl_compat.h             |    8 +
 src/openvpn/openvpn.vcxproj              |    3 +
 src/openvpn/options.c                    |   31 +-
 src/openvpn/options.h                    |    2 +
 src/openvpn/pkcs11_openssl.c             |  151 +++
 src/openvpn/ssl.c                        |    5 +
 src/openvpn/ssl.h                        |    6 +
 src/openvpn/ssl_mbedtls.c                |    6 +
 src/openvpn/ssl_openssl.c                |  108 +-
 src/openvpn/xkey_common.h                |  158 +++
 src/openvpn/xkey_helper.c                |  393 +++++++
 src/openvpn/xkey_provider.c              | 1189 ++++++++++++++++++++++
 tests/unit_tests/openvpn/Makefile.am     |   16 +
 tests/unit_tests/openvpn/test_provider.c |  403 ++++++++
 20 files changed, 2715 insertions(+), 43 deletions(-)
 create mode 100644 src/openvpn/xkey_common.h
 create mode 100644 src/openvpn/xkey_helper.c
 create mode 100644 src/openvpn/xkey_provider.c
 create mode 100644 tests/unit_tests/openvpn/test_provider.c

-- 
2.30.2


