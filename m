From: David Sommerseth <dazo@...384...>
Date: Sat, 28 Aug 2010 22:31:57 +0200
Message-Id: <1283027520-26460-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 0/3] Code clean-up - removing "dead" code.
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
Cc: David Sommerseth <dazo@...384...>

This is a patch series which tries to do some source code clean-up.
After having noticed that ./configure --enable-pthread was simply doing
*nothing*, as it was forcefully being disabled in syshead.h, I went through
the code and began cleaning up this and some of the related code.

As threading is not buildable in the current code base and OpenVPN 3.x most
likely will have a brand new design in regards to the threading, it seemed to
be better to clean up this code.  This is also to remove false presumptions
that OpenVPN supports threads.


kind regards,

David Sommerseth

*** BLURB HERE ***

David Sommerseth (3):
  Clean-up: Remove pthread and mutex locking code
  Clean-up: Remove more dead and inactive code paths
  Clean-up: Removing useless code - hash related functions

 Makefile.am    |    1 -
 acinclude.m4   |  224 -----------------------------------------------------
 buffer.c       |    5 -
 buffer.h       |    1 -
 config-win32.h |    5 -
 configure.ac   |   38 +---------
 crypto.c       |    3 -
 error.c        |   39 ---------
 error.h        |   17 ----
 forward.c      |   10 ---
 init.c         |   50 ------------
 list.c         |   24 +-----
 list.h         |   33 +-------
 mbuf.c         |   16 +----
 mbuf.h         |    3 +-
 misc.c         |   23 ------
 mroute.c       |    6 --
 mroute.h       |   13 ---
 mtcp.c         |    5 +-
 mudp.c         |    3 -
 multi.c        |   32 +++-----
 multi.h        |    2 -
 openvpn.h      |    3 -
 options.c      |   36 ---------
 options.h      |    5 -
 otime.c        |    2 -
 otime.h        |    1 -
 perf.c         |    4 -
 pf.c           |    2 +-
 plugin.c       |    4 -
 pool.h         |    1 -
 schedule.c     |    4 -
 schedule.h     |    8 --
 socket.c       |    7 --
 ssl.c          |    5 -
 ssl.h          |    4 -
 syshead.h      |   18 ----
 thread.c       |  156 -------------------------------------
 thread.h       |  235 --------------------------------------------------------
 39 files changed, 26 insertions(+), 1022 deletions(-)
 delete mode 100644 thread.c
 delete mode 100644 thread.h

-- 
1.7.2.2


