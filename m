From: Antonio Quartulli <a@...2181...>
Date: Sat, 18 Apr 2020 03:18:49 +0200
Message-Id: <20200418011849.382-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sitnl: fix failure reporting by keeping
 error negative
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
Cc: Antonio Quartulli <a@...2181...>, Richard Bonhomme <tincanteksup@...277...>

The err->errno value reported by netlink is already negative.

Prepending ierr->errno with '-' when forwarding it to
the caller results in a positive value and thus not
detected as error.

Fix error handling in sitnl by not negating the sign of
the value returned by sitnl_send() in case of generic error.

While at it, print the errno in decimal form along with
its string represenation.

Reported-by: Richard Bonhomme <tincanteksup@...277...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_sitnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b93697e9..7adcb64c 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -365,9 +365,9 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
                     }
                     else
                     {
-                        msg(M_WARN, "%s: rtnl: generic error: %s",
-                            __func__, strerror(-err->error));
-                        ret = -err->error;
+                        msg(M_WARN, "%s: rtnl: generic error (%d): %s",
+                            __func__, err->error, strerror(-err->error));
+                        ret = err->error;
                     }
                 }
                 goto out;
-- 
2.26.1


