From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:41 +0100
Message-Id: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 0/6] GNU C compiler warning clean-up
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

The GNU C compiler gives a lot of different warnings when compiling
with -Wall set.  This patch-set tries to clean up all these issues,
hopefully without breaking anything for other compilers - especially
on the Windows platform.


David Sommerseth (6):
  Use stricter snprintf() formatting in socks_username_password_auth()
  Fix compiler warnings about not used dummy() functions
  Fixed potential misinterpretation of boolean logic
  Only add some functions when really needed
  Removed functions not being used anywhere
  Merged add_bypass_address() and add_host_route_if_nonlocal()

 cryptoapi.c |    2 ++
 ieproxy.c   |    3 ++-
 options.c   |    2 ++
 perf.c      |    2 ++
 pkcs11.c    |    2 ++
 ps.c        |   12 ------------
 reliable.c  |    2 ++
 route.c     |   34 ++++++++++++----------------------
 sig.c       |    9 ---------
 socks.c     |    4 ++--
 ssl.c       |    2 +-
 11 files changed, 27 insertions(+), 47 deletions(-)

-- 
1.7.2.3


