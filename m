From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 20:14:35 +0100
Message-Id: <20230203191440.136050-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/5] Allow mingw builds with -Werror
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

Since I needed to test mingw builds today, I took a
look into the warnings reported.

Most of those patches are trivial and
straightforward. Not 100% sure whether the recv/send
one is a good idea.

Frank Lichtenheld (5):
  Windows: fix unused function setenv_foreign_option
  Windows: fix unused variables in delete_route_ipv6
  Windows: fix wrong printf format in x_check_status
  Windows: fix unused variable in win32_get_arch
  Windows: fix signedness errors with recv/send

 src/openvpn/error.c   |  4 ++--
 src/openvpn/manage.c  |  4 ++--
 src/openvpn/options.c |  2 ++
 src/openvpn/proxy.c   |  2 +-
 src/openvpn/route.c   | 32 ++++++++++++++++----------------
 src/openvpn/syshead.h |  2 ++
 src/openvpn/win32.c   |  7 +++----
 7 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.34.1


