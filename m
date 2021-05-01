From: Antonio Quartulli <a@...2181...>
Date: Sat,  1 May 2021 15:06:37 +0200
Message-Id: <20210501130640.9330-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] windows: kill a couple of warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

When compiling with mingw32-w64 we still get a bunch of warnings.
Some are easily fixable and therefore I thought about providing small
patches addressing those.

Remaining warnings are not "difficult" to fix, but rather not easy to be
fixed cleanly while keeping the change compact. 

Note: I haven't compiled this with MSVC.

Cheers,

Antonio Quartulli (3):
  windows: use appropriate and portable format specifier for 64bit
    pointer
  windows: define variable only where used
  windows: list all enum values in switch block

 src/openvpn/common.h          | 2 +-
 src/openvpn/run_command.c     | 2 +-
 src/openvpnserv/interactive.c | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.26.3


