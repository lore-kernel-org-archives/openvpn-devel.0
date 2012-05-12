From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:33 +0300
Message-Id: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 00/16] syshead: cleanups
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Hello,

This series include some minor syshead.h cleanups, most moved to
build system.

I think these are simple enough to go into 2.3, the risk is minimal
but I don't care if we truly freeze 2.3 and switch master to 2.4
and apply this for 2.4.

This series is on top of my build branch[1], about to merge it too.

[1] https://github.com/alonbl/openvpn/compare/build

Alon Bar-Lev (16):
  cleanup: syshead: remove OS_SPECIFIC_DIRSEP in favor of autoconf
    PATH_SEPARATOR
  cleanup: syshead: move O_BINARY detection to autoconf
  cleanup: syshead: remove useless WIN32_0_1
  cleanup: syshead: remove useless constant USE_64_BIT_COUNTERS
  cleanup: syshead: move apple specific CPPFLAGS out of syshead
  clenaup: syshead: remove wait macros wrappers
  cleanup: syshead: move likely,unlikely to basic.h
  cleanup: syshead: move sleep,random,syshead.h emulation to compat
  cleanup: syshead: rename S_ERROR->S_ERRORS to avoid conflict with
    stropts.h
  cleanup: syshead: split pedantic into pedantic, lint
  cleanup: syshead: move _P1003_1B_VISIBLE to autoconf
  cleanup: syshead: move socket compat into basic.h
  cleanup: syshead: remove dead code
  cleanup: syshead: move SOL_IP emulation to autoconf
  cleanup: syshead: move ENABLE_MEMSTATS to autoconf
  clenaup: syshead: reworder/cleanup includes

 configure.ac             |   63 ++++++++++-
 src/compat/compat.h      |    6 +
 src/openvpn/basic.h      |   40 +++++++
 src/openvpn/common.h     |   13 +--
 src/openvpn/error.h      |    2 +-
 src/openvpn/misc.c       |    6 +-
 src/openvpn/openvpn.c    |    2 +-
 src/openvpn/ssl.c        |   16 ++--
 src/openvpn/ssl_common.h |    2 +-
 src/openvpn/ssl_verify.c |    2 +-
 src/openvpn/syshead.h    |  270 ++++++----------------------------------------
 src/openvpn/tun.c        |   12 --
 12 files changed, 157 insertions(+), 277 deletions(-)

-- 
1.7.3.4


