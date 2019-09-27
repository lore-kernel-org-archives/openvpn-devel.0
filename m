From: David Sommerseth <davids@...515...>
Date: Sat, 28 Sep 2019 00:45:33 +0200
Message-Id: <20190927224536.27480-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/3] Last-minute fixes to auth-token-hmac
 patch series
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

During the review of the auth-token-hmac patches from Arne Schwabe, there
were still a few minor issues left out.  To avoid holding back further
inclusion, we decided to add these patches on top of the patches from Arne.

The first patch, --disable-server fix, is only needed when running
./configure with --disable-server.  Otherwise the existing patches works
fine.

The second patch, --disable-management fix, just fixes a long outstanding
compiler warning.

And the final patch with comment updates are just clarifications and
minor improvements.

David Sommerseth (3):
  auth-token: Fix building with --disable-server
  auth-token: Fix compiler complaints with --disable-management
  Improve the comments related to auth-token-hmac patches

 src/openvpn/auth_token.h | 2 --
 src/openvpn/push.c       | 2 ++
 src/openvpn/ssl.h        | 4 ++--
 src/openvpn/ssl_common.h | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
kind regards,

David Sommerseth
OpenVPN Inc


