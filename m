From: David Sommerseth <dazo@...384...>
Date: Thu, 21 Nov 2013 18:02:08 +0100
Message-Id: <1385053332-14533-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 0/4] RFC: Move memory allocations from
	malloc() to calloc()
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

From: David Sommerseth <davids@...1347...>

Hi,

This might be seen as controversial for some, but my intension here
is just to clean up and simplify the code base a little bit by reducing
the memory/buffer allocation API.

The reason for doing a move from malloc() to calloc() is to first of
all simplify the memory management (buffer) code somewhat.  As with
calloc() you will always get a cleared memory region by default, which
means much of the current API-set for memory management can be somewhat
reduced.  Currently we have separate functions and macros, one set which
clears the memory and another one which does not.

Some even claim that calloc() has a smaller overhead than doing a malloc()
call + memset().  If this truly is true, then OpenVPN may even perform
slightly better.  But this is most likely also tightly connected to how
the kernel and the libc library handles memory allocations.

And the last reason, probably the most important one in my eyes, is that
when you work by default on cleared memory regions, buffer overruns are
harder to accomplish.  As long as you stay inside the allocated memory
region, you cannot trigger overrun issues due to missing NULL
termination.  The memory region contains by default only NULLs.

I've split this patch set into several pieces to hopefully eaiser
see the bigger picture.

These patches needs to be tested a bit more, but it compiles well on
Fedora 19 (with a compiler which can by default complain a lot).  Also
basic client testing seems to work fine too.  The overall behaviour is
not expected to change, excpet perhaps a slight performance boost if
we're lucky.


kind regards,

David Sommerseth


David Sommerseth (4):
  Move over to calloc() in gc_malloc()
  Change from malloc() to calloc() where it can be beneficial
  Move ALLOC_OBJ() macro to use calloc()
  Merge the rest of ALLOC_*_CLEAR*() macros into ALLOC_*()

 src/openvpn/base64.c              |  2 +-
 src/openvpn/buffer.c              | 34 ++++++++++++++++-----------------
 src/openvpn/buffer.h              | 40 +++++++++------------------------------
 src/openvpn/circ_list.h           |  2 +-
 src/openvpn/clinat.c              |  2 +-
 src/openvpn/comp.c                |  6 +++---
 src/openvpn/console.c             |  2 +-
 src/openvpn/crypto.c              |  2 +-
 src/openvpn/error.c               |  4 ++--
 src/openvpn/event.c               | 20 ++++++++++----------
 src/openvpn/fragment.c            |  2 +-
 src/openvpn/init.c                |  8 ++++----
 src/openvpn/list.c                |  2 +-
 src/openvpn/manage.c              |  8 ++++----
 src/openvpn/mbuf.c                |  2 +-
 src/openvpn/misc.c                | 32 +++++++++++++++----------------
 src/openvpn/mroute.c              |  2 +-
 src/openvpn/mtcp.c                |  2 +-
 src/openvpn/mtu.c                 |  2 +-
 src/openvpn/multi.c               |  2 +-
 src/openvpn/openvpn.c             |  2 +-
 src/openvpn/options.c             | 20 ++++++++++----------
 src/openvpn/pf.c                  |  8 ++++----
 src/openvpn/plugin.c              | 10 +++++-----
 src/openvpn/pool.c                | 10 +++++-----
 src/openvpn/proxy.c               |  6 +++---
 src/openvpn/ps.c                  | 12 ++++++------
 src/openvpn/push.c                |  2 +-
 src/openvpn/route.c               | 16 ++++++++--------
 src/openvpn/schedule.c            |  4 ++--
 src/openvpn/socket.c              |  2 +-
 src/openvpn/socks.c               |  2 +-
 src/openvpn/ssl.c                 | 20 ++++++++++----------
 src/openvpn/ssl_openssl.c         |  2 +-
 src/openvpn/ssl_polarssl.c        | 24 +++++++++++------------
 src/openvpn/ssl_verify.c          |  6 +++---
 src/openvpn/ssl_verify_openssl.c  | 12 ++++++------
 src/openvpn/ssl_verify_polarssl.c |  4 ++--
 src/openvpn/status.c              |  2 +-
 src/openvpn/tun.c                 | 14 +++++++-------
 src/openvpn/win32.c               |  6 +++---
 41 files changed, 168 insertions(+), 192 deletions(-)

-- 
1.8.3.1


