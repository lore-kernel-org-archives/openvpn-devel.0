From: Arne Schwabe <arne@...1227...>
Date: Sun, 30 Aug 2020 16:07:34 +0200
Message-Id: <20200830140736.16571-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/2] Backport/implement IV_CIPHERS support
 for OpenVPN 2.4
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

This is basically to improve 2.4 client to OpenVPN 2.5 server compatibility.
The commit message of patch 2/2 explains the motivations and details more.

Arne Schwabe (2):
  Normalise ncp-ciphers option and restrict it to 127 bytes
  Also announce IV_CIPHERS as client in OpenVPN 2.4

 doc/openvpn.8            |   2 +
 src/openvpn/init.c       |   1 +
 src/openvpn/options.c    |   9 +++
 src/openvpn/ssl.c        |  74 +++++++++++++++++++++++++
 src/openvpn/ssl.h        |  23 ++++++++
 src/openvpn/ssl_common.h |   1 +
 src/openvpn/ssl_ncp.h    | 116 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 226 insertions(+)
 create mode 100644 src/openvpn/ssl_ncp.h

-- 
2.26.2


