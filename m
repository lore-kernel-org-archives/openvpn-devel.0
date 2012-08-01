From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Aug 2012 18:11:06 +0200
Message-Id: <1343837470-3923-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 0/4] Cleanup patches
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

The first patch is a corrected (read working) version of the patch I posted a while ago.

For the last three patches. I am in the progress of looking through the socket.c code. 
The ultimate goal is to simplify the code and have good way of dealing with ipv4/ipv6 
dual stack. These first patches don't change any functionality but clean up the code.

Arne Schwabe (4):
  Fixes error:  --key fails with EXTERNAL_PRIVATE_KEY: No such file or
    directory if  --management-external-key is used
  Merge getaddr_multi and getaddr6 into one function
  Merge almost identical create_socket_tcp and create_socket_tcp6
  Simplify print_sockaddr_ex function, merge duplicate ipv4/ipv6 logic

 src/openvpn/manage.c  |    4 +-
 src/openvpn/options.c |   18 +-
 src/openvpn/route.c   |   50 ++--
 src/openvpn/socket.c  |  724 ++++++++++++++++---------------------------------
 src/openvpn/socket.h  |   19 +-
 5 files changed, 280 insertions(+), 535 deletions(-)

-- 
1.7.9.6 (Apple Git-31.1)


