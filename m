From: Conrad Hoffmann <ch@...2291...>
Date: Wed,  2 Aug 2017 20:14:33 +0200
Message-Id: <20170802181435.14549-1-ch@...2291...>
Subject: [Openvpn-devel] [PATCH 0/2] Improve usability of non-privileged
 operation
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

Ohai!

I recently undertook the project of not having my VPN client run as root
anymore. I noticed there are a lot of questions about this on the internet, and
I think one reason that this is more difficult then necessary is that the
"official" client.down script doesn't work when used in the conjunction with
the down-root plugin.

I noticed that both the up and the down script get a lot of information through
environment variables, and the up script relies on that already anyways. So I
figured doing the same in the down script would be a reasonable thing to do
(it's also what the most commonly referred to external up/down scripts do).

With this change, the down script can actually be used with the down-root
plugin just like this:

  plugin openvpn-plugin-down-root.so "/etc/openvpn/client.down"

Hope this makes sense,
Conrad

Conrad Hoffmann (2):
  Use provided env vars in up/down script.
  Document down-root plugin usage in client.down

 contrib/pull-resolv-conf/client.down | 6 +++++-
 contrib/pull-resolv-conf/client.up   | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.13.3


