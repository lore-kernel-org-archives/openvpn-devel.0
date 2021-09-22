From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:45 -0400
Message-Id: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
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

This patch set stops at interfacing the provider with
management-external-key. For pkcs11-helper, only some glue
code is needed and is in the works. Same with cryptoapicert
 aka CNG, but I want to cleanup the old code a bit before
hooking to the provider.

I haven't attempted to remove any of the deprecated interfaces.
That is better done along with Arne's patches. There will be
only minor, if at all any, conflicts between that and this 
patch set. 

Selva Nair (9):
  A built-in provider for using external key with OpenSSL 3.0
  Initialize the xkey provider and use it in SSL context
  Implement keymgmt in the xkey provider
  Implement provider interface for signature operations
  Implement import of custom external keys
  A helper function to load key for management-external-key
  Enable signing via provider for management-external-key
  Add a function to encode digests with PKCS1 DigestInfo wrapper
  Allow management client to announce pss padding support

 configure.ac                            |   11 +
 doc/man-sections/management-options.rst |    8 +-
 doc/management-notes.txt                |   15 +-
 src/openvpn/Makefile.am                 |    2 +
 src/openvpn/crypto_openssl.c            |   19 +
 src/openvpn/manage.h                    |    1 +
 src/openvpn/openssl_compat.h            |   12 +
 src/openvpn/options.c                   |    7 +-
 src/openvpn/ssl_openssl.c               |   17 +-
 src/openvpn/xkey_common.h               |  120 +++
 src/openvpn/xkey_helper.c               |  285 ++++++
 src/openvpn/xkey_provider.c             | 1158 +++++++++++++++++++++++
 12 files changed, 1647 insertions(+), 8 deletions(-)
 create mode 100644 src/openvpn/xkey_common.h
 create mode 100644 src/openvpn/xkey_helper.c
 create mode 100644 src/openvpn/xkey_provider.c

-- 
2.20.1


