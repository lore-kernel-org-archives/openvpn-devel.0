From: Arne Schwabe <arne@...1227...>
Date: Tue,  8 Sep 2020 17:41:53 +0200
Message-Id: <20200908154157.13809-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/4] Allow setting up OpenVPN in TLS mode
 without CA
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

Setting up a CA even with the help of easy-tls and similar tools is
difficult/tiresome. For small setups self-signed certificates are
sufficient enough and restarting the server to add another client is
generally not a big problem (when you need that capability a CA is
better suited).

This patch set allows setting up OpenVPN with verification of peer
certificates and without a CA certificate. Instead of verifying
certificates through a CA, it allows to verify a certificate just by it
fingerprint. This is usually called certificate pinning. (If you wonder if
this secure, it is as secure as normal CA operation as certificate signature
also only sign the finerprinter of a certificate and not the whole cert.)

The commit themselves have examples.

The main difference of this patch set to Jason's V1 version is that it does
not rely on an external script on the server side and instead relys on an a
inlined <peer-fingerprint> section. The downside is that this requires a
server restart on adding a client but the upside is that no script-security
or external scripts are necessary and server/client setup become symmetric.

Arne Schwabe (3):
  Extend verify-hash to allow multiple hashes
  Implement peer-fingerprint to check fingerprint of peer certificate
  Document the simple self-signed certificate setup in examples

Jason A. Donenfeld (1):
  Support fingerprint authentication without CA certificate

 Changes.rst                       |  12 +++
 doc/man-sections/examples.rst     |  46 ++++++----
 doc/man-sections/inline-files.rst |   4 +-
 doc/man-sections/tls-options.rst  |  36 +++++++-
 src/openvpn/init.c                |   3 +
 src/openvpn/options.c             | 145 +++++++++++++++++++++++++-----
 src/openvpn/options.h             |  13 ++-
 src/openvpn/ssl.c                 |   2 +-
 src/openvpn/ssl_common.h          |   4 +-
 src/openvpn/ssl_verify.c          |  30 +++++--
 src/openvpn/ssl_verify_mbedtls.c  |  17 ++++
 src/openvpn/ssl_verify_openssl.c  |   2 +-
 12 files changed, 263 insertions(+), 51 deletions(-)

-- 
2.26.2


