From: Arne Schwabe <arne@...1227...>
Date: Thu, 13 Jun 2019 16:41:08 +0200
Message-Id: <20190613144113.6418-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/5] Implement additional two step
 authentication methods
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

These patches mainly implement forwarding passing/forwarding extra
messages between management interface on server and client side.

These new extra messages can be used to implement a two step
authentication like TOTP (Google Authenticator) or web based
out of band (like SAML).

Since this requires a tight integration on both client and
server side, it is currently only supported with the management
interface.

Arne Schwabe (5):
  Implement parsing and sending INFO and INFO_PRE control messages
  Implement forwarding client CR_RESPONSE messages to management
  Implement support for signalling IV_SSO to server
  Implement sending response to challenge via CR_RESPONSE
  Implement sending SSO challenge to clients

 doc/management-notes.txt |  74 ++++++++++++++++++++++++++++
 src/openvpn/forward.c    |  12 +++++
 src/openvpn/init.c       |  25 ++++++++++
 src/openvpn/manage.c     | 101 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/manage.h     |   8 ++++
 src/openvpn/multi.c      |  19 ++++++++
 src/openvpn/push.c       |  78 ++++++++++++++++++++++++++++++
 src/openvpn/push.h       |   7 +++
 src/openvpn/ssl.c        |   4 +-
 9 files changed, 325 insertions(+), 3 deletions(-)

-- 
2.22.0


