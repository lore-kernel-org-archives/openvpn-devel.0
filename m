From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu, 29 Mar 2012 11:16:38 +0200
Message-Id: <1333012602-5419-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
Subject: [Openvpn-devel] [PATCH 0/4] cleanup: avoid using ~0
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Remove the arithmetic magic in favor of constants or alternatives.

Alon Bar-Lev (4):
  cleanup: avoid using ~0 - generic
  cleanup: avoid using ~0 - ipv6
  cleanup: avoid using ~0 - netmask
  cleanup: avoid using ~0 - windows

 config-msvc.h         |    1 +
 configure.ac          |    2 +-
 src/openvpn/basic.h   |    2 ++
 src/openvpn/mroute.c  |    2 +-
 src/openvpn/pf.c      |    2 +-
 src/openvpn/route.c   |   46 +++++++++++++++++++++++++---------------------
 src/openvpn/route.h   |    2 +-
 src/openvpn/syshead.h |    4 ++++
 src/openvpn/tun.c     |   48 ++++++++++++++++++++++++------------------------
 src/openvpn/tun.h     |    2 ++
 10 files changed, 62 insertions(+), 49 deletions(-)

-- 
1.7.3.4


