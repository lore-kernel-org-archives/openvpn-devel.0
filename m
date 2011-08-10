From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 10 Aug 2011 12:55:06 +0000
Message-Id: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 0/2] fix building for WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

git master currently fails when cross compiling for WIN32 in Debian testing.
Two IPv6 related things were introduced in commits

  512cda46b0f65f388e24436cd28d44bdc90fe985 and
  8335caf929f21b317a0243a12285e1f04361db25

that are incompatible with Windows. IN6_ARE_ADDR_EQUAL and
struct in6_addr.s6_addr32 are not available there.

While MinGW added both features to ws2tcpip.h, the Microsoft
Platform SDK headers do not include them and they are (correctly)
missing in the MinGW-w64 headers as well.

Following are two patches that try to fix these issues.

Heiko Hund (2):
  define IN6_ARE_ADDR_EQUAL macro for WIN32
  don't use struct in6_addr s6_addr32 member anymore

 socket.c |   16 +++++++---------
 win32.h  |   13 +++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

Regards
Heiko
-- 
1.7.5.4


