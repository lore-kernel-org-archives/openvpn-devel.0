From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 May 2020 23:59:59 +0200
Message-Id: <20200519220004.25136-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 0/5] Implement additional two step
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

This patchset implements the basic blocks for a more flexible
authentication protocol in OpenVPN. The basic idea is to instead of
giving a immediate deny/accept the client gets a additional challgen via
the info message to a 2FA method or external authentication with URL (e.g.
via SAML).

The patch already sends the AUTH_PENDING control message. An OpenVPN3 cliets
needs this to scale back pull request frequency, OpenVPN2 currently logs
a warning about an unknown. This will be fixed in a follw up patch

Currently both client and server side need a management interface make
the support work. For a server script follow up patch, I am currently
waiting for the client-connect patch set to be merge and for the client
side, David offered to help with helping with the getting an async password
input working.


Arne Schwabe (5):
  Implement parsing and sending INFO and INFO_PRE control messages
  Implement support for signalling IV_SSO to server
  Implement sending response to challenge via CR_RESPONSE
  Implement sending AUTH_PENDING challenges to clients
  Implement forwarding client CR_RESPONSE messages to management

 doc/management-notes.txt | 130 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/forward.c    |  12 ++++
 src/openvpn/init.c       |  39 ++++++++++++
 src/openvpn/manage.c     | 113 +++++++++++++++++++++++++++++++++-
 src/openvpn/manage.h     |   9 +++
 src/openvpn/multi.c      |  19 ++++++
 src/openvpn/push.c       |  78 +++++++++++++++++++++++
 src/openvpn/push.h       |  12 ++++
 src/openvpn/ssl.c        |   4 +-
 9 files changed, 412 insertions(+), 4 deletions(-)

-- 
2.26.0


