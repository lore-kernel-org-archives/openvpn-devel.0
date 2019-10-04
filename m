From: David Sommerseth <davids@...515...>
Date: Fri,  4 Oct 2019 19:12:42 +0200
Message-Id: <20191004171246.26343-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 0/4] struct argv overhual - Oct 2019 edition
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

Hi,

I've rebased the last attempt of the struct argv overual patches [1]
to the lastest public git master [2].

This rebase just needed a few minor changes to account for changes
with tls-crypt-v2 and sitnl patches now being included.  I've also
applied Arne's review comments  [3].

To simplify the review, I've also pushed these changes to my gitlab
account:

   https://gitlab.com/dazo/openvpn.git

Look at the dev/struct-argv-overhaul-2019.10 branch for the proper
commits.

[1] <https://patchwork.openvpn.net/project/openvpn2/list/?series=386>
[2] git master commit ef2c7b2fa4fd9fae934e608e37dc8d98edbace5f
[3] Message-ID: <fef5a979-ccff-71c2-61c8-1bd8ead96cbc@...1227...>
    <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17957.html>


--
kind regards,

David Sommerseth
OpenVPN Inc

----------------------------------------------------------------

David Sommerseth (1):
  Documented all the argv related code with minor refactoring

Heiko Hund (3):
  re-implement argv_printf_*()
  argv: do fewer memory re-allocations
  Add gc_arena to struct argv to save allocations

 src/openvpn/argv.c                   | 525 +++++++++++++++++----------
 src/openvpn/argv.h                   |   7 +-
 src/openvpn/console_systemd.c        |   2 +-
 src/openvpn/init.c                   |  15 +-
 src/openvpn/lladdr.c                 |   2 +-
 src/openvpn/multi.c                  |  10 +-
 src/openvpn/networking_iproute2.c    |  23 +-
 src/openvpn/options.c                |   2 +-
 src/openvpn/plugin.c                 |   2 +-
 src/openvpn/route.c                  |  16 +-
 src/openvpn/socket.c                 |   4 +-
 src/openvpn/ssl_verify.c             |   6 +-
 src/openvpn/tls_crypt.c              |   2 +-
 src/openvpn/tun.c                    |  62 ++--
 tests/unit_tests/openvpn/test_argv.c | 118 +++++-
 15 files changed, 509 insertions(+), 287 deletions(-)

-- 
2.17.1


